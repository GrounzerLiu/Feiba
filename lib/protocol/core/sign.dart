import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Computes the Tieba form signature.
///
/// The signature is `md5(concat(sorted "key=value") + salt)`.
/// Sorting is performed on the `(key, value)` tuples, matching CPython's
/// `sorted(data)` used by aiotieba.
String computeSign(Iterable<MapEntry<String, String>> data, String salt) {
  final entries = data.toList(growable: false)
    ..sort((a, b) {
      final byKey = a.key.compareTo(b.key);
      return byKey != 0 ? byKey : a.value.compareTo(b.value);
    });
  final buffer = StringBuffer();
  for (final entry in entries) {
    buffer
      ..write(entry.key)
      ..write('=')
      ..write(entry.value);
  }
  buffer.write(salt);
  return md5.convert(utf8.encode(buffer.toString())).toString();
}

/// Returns a copy of [data] with the `sign` field appended.
List<MapEntry<String, String>> signForm(
  Iterable<MapEntry<String, String>> data, {
  required String salt,
}) {
  final list = data.toList();
  list.add(MapEntry('sign', computeSign(list, salt)));
  return list;
}
