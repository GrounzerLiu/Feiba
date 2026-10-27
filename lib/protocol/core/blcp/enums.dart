/// BLCP (Baidu LCP) protocol identifiers.
///
/// Ported from `aiotieba/core/blcp/enums.py` (Unlicense).
library;

/// BLCP service ids.
///
/// * [lcm] - LCP control plane: login / heartbeat / logout.
/// * [im] - IM session bus: private messages, groups, notifications.
/// * [mcast] - multicast channel: forum groups / chat rooms.
/// * [cloudControl] - cloud configuration delivery.
enum BlcpServiceId {
  lcm(1),
  im(2),
  mcast(3),
  cloudControl(4);

  const BlcpServiceId(this.value);

  final int value;

  /// Returns the matching service id, or `null` for an unknown value.
  static BlcpServiceId? tryFromValue(int value) {
    for (final item in BlcpServiceId.values) {
      if (item.value == value) return item;
    }
    return null;
  }
}

/// BLCP method ids; always paired with a [BlcpServiceId].
///
/// * [login] - LCM login / cloud-control login.
/// * [heartbeat] - LCM heartbeat.
/// * [loginByToken] - IM login.
/// * [sendMcastMsg] - send a multicast (chat room) message.
/// * [joinCast] - join a multicast channel.
enum BlcpMethodId {
  login(1),
  heartbeat(3),
  loginByToken(50),
  sendMcastMsg(185),
  joinCast(201);

  const BlcpMethodId(this.value);

  final int value;

  /// Returns the matching method id, or `null` for an unknown value.
  static BlcpMethodId? tryFromValue(int value) {
    for (final item in BlcpMethodId.values) {
      if (item.value == value) return item;
    }
    return null;
  }
}

/// Compression type of a BLCP message body.
enum BlcpCompressType {
  none(0),
  gzip(1);

  const BlcpCompressType(this.value);

  final int value;

  /// Unknown compression types fall back to [none], mirroring aiotieba.
  static BlcpCompressType fromValue(int value) {
    for (final item in BlcpCompressType.values) {
      if (item.value == value) return item;
    }
    return BlcpCompressType.none;
  }
}

/// State of a [BlcpCore] connection.
enum BlcpStatus {
  closed(-1),
  connecting(0),
  open(1),
  loggedIn(2);

  const BlcpStatus(this.value);

  final int value;
}
