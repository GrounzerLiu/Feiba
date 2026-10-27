import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Port of aiotieba's device-identifier crypto (Unlicense).
///
/// The original implementation lives in C (tbcrypto); this file reproduces
/// `cuid_galaxy2` and `c3_aid` byte-for-byte.

const int _mask32 = 0xFFFFFFFF;

int _rotl32(int value, int count) {
  final v = value & _mask32;
  return ((v << count) | (v >> (32 - count))) & _mask32;
}

int _readLe32(List<int> data, int offset) {
  return (data[offset] |
          (data[offset + 1] << 8) |
          (data[offset + 2] << 16) |
          (data[offset + 3] << 24)) &
      _mask32;
}

// ---------------------------------------------------------------------------
// CRC32 (IEEE 802.3), matching tbc_crc32.
// ---------------------------------------------------------------------------

final List<int> _crcTable = List<int>.generate(256, (n) {
  var c = n;
  for (var k = 0; k < 8; k++) {
    c = (c & 1) != 0 ? (0xEDB88320 ^ (c >> 1)) : (c >> 1);
  }
  return c & _mask32;
});

int crc32(List<int> data, [int previous = 0]) {
  var crc = (~previous) & _mask32;
  for (final byte in data) {
    crc = (crc >> 8) ^ _crcTable[(crc ^ byte) & 0xFF];
  }
  return (~crc) & _mask32;
}

// ---------------------------------------------------------------------------
// XXH32 streaming implementation (seed 0 is all the Tieba format needs).
// ---------------------------------------------------------------------------

const int _prime1 = 0x9E3779B1;
const int _prime2 = 0x85EBCA77;
const int _prime3 = 0xC2B2AE3D;
const int _prime4 = 0x27D4EB2F;
const int _prime5 = 0x165667B1;

class Xxh32 {
  Xxh32([this.seed = 0]) {
    reset();
  }

  final int seed;
  int _v1 = 0;
  int _v2 = 0;
  int _v3 = 0;
  int _v4 = 0;
  final List<int> _mem = List<int>.filled(16, 0);
  int _memSize = 0;
  int _totalLen = 0;

  Xxh32._copy(Xxh32 other)
    : seed = other.seed,
      _v1 = other._v1,
      _v2 = other._v2,
      _v3 = other._v3,
      _v4 = other._v4,
      _memSize = other._memSize,
      _totalLen = other._totalLen {
    _mem.setAll(0, other._mem);
  }

  void reset() {
    _v1 = (seed + _prime1 + _prime2) & _mask32;
    _v2 = (seed + _prime2) & _mask32;
    _v3 = seed & _mask32;
    _v4 = (seed - _prime1) & _mask32;
    _mem.fillRange(0, 16, 0);
    _memSize = 0;
    _totalLen = 0;
  }

  Xxh32 copy() => Xxh32._copy(this);

  void _round(int lane, int input) {
    var acc = switch (lane) {
      1 => _v1,
      2 => _v2,
      3 => _v3,
      _ => _v4,
    };
    acc = (acc + ((input * _prime2) & _mask32)) & _mask32;
    acc = _rotl32(acc, 13);
    acc = (acc * _prime1) & _mask32;
    switch (lane) {
      case 1:
        _v1 = acc;
      case 2:
        _v2 = acc;
      case 3:
        _v3 = acc;
      default:
        _v4 = acc;
    }
  }

  void _processStripe(List<int> data, int offset) {
    _round(1, _readLe32(data, offset));
    _round(2, _readLe32(data, offset + 4));
    _round(3, _readLe32(data, offset + 8));
    _round(4, _readLe32(data, offset + 12));
  }

  void update(List<int> input) {
    final length = input.length;
    _totalLen += length;
    var index = 0;

    if (_memSize + length < 16) {
      for (var i = 0; i < length; i++) {
        _mem[_memSize + i] = input[i];
      }
      _memSize += length;
      return;
    }

    if (_memSize > 0) {
      final fill = 16 - _memSize;
      for (var i = 0; i < fill; i++) {
        _mem[_memSize + i] = input[i];
      }
      _processStripe(_mem, 0);
      index = fill;
      _memSize = 0;
    }

    while (index + 16 <= length) {
      _processStripe(input, index);
      index += 16;
    }

    final remaining = length - index;
    for (var i = 0; i < remaining; i++) {
      _mem[i] = input[index + i];
    }
    _memSize = remaining;
  }

  int digest() {
    var hash = _memSize == 0 && _totalLen == 0
        ? seed + _prime5
        : (_totalLen >= 16
              ? (_rotl32(_v1, 1) +
                        _rotl32(_v2, 7) +
                        _rotl32(_v3, 12) +
                        _rotl32(_v4, 18)) &
                    _mask32
              : (seed + _prime5) & _mask32);
    hash = (hash + _totalLen) & _mask32;

    var index = 0;
    while (index + 4 <= _memSize) {
      hash = (hash + ((_readLe32(_mem, index) * _prime3) & _mask32)) & _mask32;
      hash = _rotl32(hash, 17);
      hash = (hash * _prime4) & _mask32;
      index += 4;
    }
    while (index < _memSize) {
      hash = (hash + ((_mem[index] * _prime5) & _mask32)) & _mask32;
      hash = _rotl32(hash, 11);
      hash = (hash * _prime1) & _mask32;
      index++;
    }

    hash ^= hash >> 15;
    hash = (hash * _prime2) & _mask32;
    hash ^= hash >> 13;
    hash = (hash * _prime3) & _mask32;
    hash ^= hash >> 16;
    return hash & _mask32;
  }
}

// ---------------------------------------------------------------------------
// Base32 (RFC 4648 alphabet, no padding), matching tbc_base32_encode.
// ---------------------------------------------------------------------------

const String _base32Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

String base32Encode(List<int> source) {
  if (source.isEmpty) return '';
  final output = StringBuffer();
  var buffer = source[0];
  var next = 1;
  var bitsLeft = 8;

  while (bitsLeft > 0 || next < source.length) {
    if (bitsLeft < 5) {
      if (next < source.length) {
        buffer = (buffer << 8) | (source[next++] & 0xFF);
        bitsLeft += 8;
      } else {
        final pad = 5 - bitsLeft;
        buffer <<= pad;
        bitsLeft += pad;
      }
    }
    final index = 0x1F & (buffer >> (bitsLeft - 5));
    bitsLeft -= 5;
    output.write(_base32Alphabet[index]);
  }
  return output.toString();
}

// ---------------------------------------------------------------------------
// Helios hash used by both identifiers.
// ---------------------------------------------------------------------------

const int _hashBits = 32;
const int _stepSize = 5;
const int _heliosSize = 5;

void _updateSection(List<int> state, int hashValue, int start, bool xorMode) {
  final end = start + _hashBits;
  var section = state[0];
  final mask = (1 << end) - 1;
  var value = (mask & section) >> start;
  if (xorMode) {
    value ^= hashValue;
  } else {
    value &= hashValue;
  }
  for (var i = 0; i < _hashBits; i++) {
    final target = start + i;
    if ((value & (1 << i)) != 0) {
      section |= 1 << target;
    } else {
      section &= ~(1 << target);
    }
  }
  state[0] = section & 0xFFFFFFFFFF;
}

void _writeState(List<int> buffer, int offset, int state) {
  var value = state;
  for (var i = 0; i < _stepSize; i++) {
    buffer[offset + i] = value & 0xFF;
    value >>= 8;
  }
}

List<int> heliosHash(List<int> source) {
  final state = <int>[(1 << 40) - 1];
  final buffer = List<int>.filled(4 * _stepSize, 0);
  buffer.fillRange(0, _stepSize, 0xFF);

  var crc = crc32(source);
  crc = crc32(buffer.sublist(0, _stepSize), crc);
  _updateSection(state, crc, 8, false);
  _writeState(buffer, _stepSize, state[0]);

  final xxState = Xxh32()
    ..update(source)
    ..update(buffer.sublist(0, _stepSize * 2));
  final xxCopy = xxState.copy();
  var xx = xxState.digest();
  _updateSection(state, xx, 0, true);
  _writeState(buffer, _stepSize * 2, state[0]);

  xxCopy.update(buffer.sublist(_stepSize * 2, _stepSize * 3));
  xx = xxCopy.digest();
  _updateSection(state, xx, 1, true);
  _writeState(buffer, _stepSize * 3, state[0]);

  crc = crc32(buffer.sublist(_stepSize, _stepSize * 4), crc);
  _updateSection(state, crc, 7, true);

  final result = List<int>.filled(_heliosSize, 0);
  _writeState(result, 0, state[0]);
  return result;
}

// ---------------------------------------------------------------------------
// Public identifiers.
// ---------------------------------------------------------------------------

String _upperHex(List<int> bytes) {
  final buffer = StringBuffer();
  for (final byte in bytes) {
    buffer.write(byte.toRadixString(16).padLeft(2, '0').toUpperCase());
  }
  return buffer.toString();
}

/// Generates `cuid_galaxy2` from a 16-character android id.
String cuidGalaxy2(String androidId) {
  if (androidId.length != 16) {
    throw ArgumentError.value(androidId, 'androidId', 'must be 16 characters');
  }
  final digest = md5.convert(<int>[
    ...ascii.encode('com.baidu'),
    ...ascii.encode(androidId),
  ]).bytes;
  final hex = _upperHex(digest);
  final helios = heliosHash(ascii.encode(hex));
  return '$hex|V${base32Encode(helios)}';
}

/// Generates `c3_aid` from a 16-character android id and a UUID.
String c3Aid(String androidId, String uuid) {
  if (androidId.length != 16) {
    throw ArgumentError.value(androidId, 'androidId', 'must be 16 characters');
  }
  if (uuid.length != 36) {
    throw ArgumentError.value(uuid, 'uuid', 'must be 36 characters');
  }
  final digest = sha1.convert(<int>[
    ...ascii.encode('com.helios'),
    ...ascii.encode(androidId),
    ...ascii.encode(uuid),
  ]).bytes;
  final prefix = 'A00-${base32Encode(digest)}-';
  final helios = heliosHash(ascii.encode(prefix));
  return '$prefix${base32Encode(helios)}';
}
