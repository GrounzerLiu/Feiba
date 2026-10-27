/// BLCP transport: TLS socket, request/response correlation and heartbeats.
///
/// Ported from `aiotieba/core/blcp/core.py` (Unlicense).
library;

import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import '../account.dart';
import 'enums.dart';
import 'exceptions.dart';
import 'packet.dart';

/// Connection settings for [BlcpCore].
class BlcpConfig {
  const BlcpConfig({
    this.host = 'common.lcs.baidu.com',
    this.port = 443,
    this.connectTimeout = const Duration(seconds: 10),
    this.readTimeout = const Duration(seconds: 10),
    this.heartbeatInterval = const Duration(seconds: 60),
    this.maxPendingNotifications = 100,
    this.allowBadCertificate = false,
  });

  /// BLCP gateway host.
  final String host;

  /// BLCP gateway port (TLS).
  final int port;

  final Duration connectTimeout;

  /// How long [BlcpCore.send] waits for the matching response.
  final Duration readTimeout;

  /// Fallback heartbeat interval; a server-provided interval wins.
  final Duration heartbeatInterval;

  /// Upper bound of retained push packets.
  final int maxPendingNotifications;

  /// Whether to skip TLS certificate-chain validation.
  ///
  /// Kept off by default: the reference implementation only disables hostname
  /// matching, not chain validation.
  final bool allowBadCertificate;
}

/// Core container for the BLCP connection.
///
/// The BLCP connection is a TLS socket carrying length-prefixed LCP frames.
/// [send] correlates responses with requests through the frame correlation id;
/// server pushes are exposed through [notifications].
class BlcpCore {
  BlcpCore({required this.account, this.config = const BlcpConfig()})
    : _heartbeatInterval = config.heartbeatInterval;

  final BlcpConfig config;

  /// Account whose chat identity this connection belongs to.
  TiebaAccount account;

  LcpFrameParser _parser = LcpFrameParser();
  final Map<int, Completer<BlcpResponse>> _waiters =
      <int, Completer<BlcpResponse>>{};
  final ListQueue<BlcpNotify> _pendingNotifies = ListQueue<BlcpNotify>();
  final StreamController<BlcpNotify> _notifyController =
      StreamController<BlcpNotify>.broadcast();

  SecureSocket? _socket;
  StreamSubscription<Uint8List>? _subscription;
  Timer? _heartbeatTimer;
  BlcpStatus _status = BlcpStatus.closed;
  Duration _heartbeatInterval;
  bool _closing = false;

  /// Replaces the account, e.g. after a re-login.
  void setAccount(TiebaAccount newAccount) => account = newAccount;

  /// Current connection state.
  BlcpStatus get status {
    if (_status != BlcpStatus.closed && _socket == null) {
      _status = BlcpStatus.closed;
    }
    return _status;
  }

  /// Whether a request can currently be sent.
  bool get isOpen =>
      (_status == BlcpStatus.open || _status == BlcpStatus.loggedIn) &&
      _socket != null;

  /// Broadcast stream of server pushes.
  Stream<BlcpNotify> get notifications => _notifyController.stream;

  /// Pushes retained for consumers that attach after the connection opens.
  List<BlcpNotify> get pendingNotifications =>
      List<BlcpNotify>.unmodifiable(_pendingNotifies);

  /// Drops every retained push.
  void clearPendingNotifications() => _pendingNotifies.clear();

  /// Marks the session as fully logged in (after the IM login).
  void markLoggedIn() => _status = BlcpStatus.loggedIn;

  /// Sends a request and awaits the matching response.
  Future<BlcpResponse> send(BlcpRequest request) async {
    final socket = _socket;
    if (socket == null || !isOpen) {
      throw const BlcpConnectionException('BLCP connection is not open');
    }
    final completer = Completer<BlcpResponse>();
    _waiters[request.correlationId] = completer;
    try {
      socket.add(request.toBytes());
      await socket.flush();
      return await completer.future.timeout(config.readTimeout);
    } on TimeoutException {
      throw TimeoutException(
        'Timeout to read BLCP response for '
        'service=${request.serviceId} method=${request.methodId}',
        config.readTimeout,
      );
    } finally {
      _waiters.remove(request.correlationId);
    }
  }

  /// Sends a packet without waiting for a response.
  Future<void> sendNowait(BlcpPacket packet) async {
    final socket = _socket;
    if (socket == null || !isOpen) {
      throw const BlcpConnectionException('BLCP connection is not open');
    }
    socket.add(packet.toBytes());
    await socket.flush();
  }

  /// Establishes the TLS connection and starts dispatching frames.
  Future<void> connect() async {
    if (_socket != null) {
      await close();
    }
    _status = BlcpStatus.connecting;
    _parser = LcpFrameParser();
    try {
      final socket = await SecureSocket.connect(
        config.host,
        config.port,
        timeout: config.connectTimeout,
        onBadCertificate: config.allowBadCertificate ? (_) => true : null,
      );
      socket.setOption(SocketOption.tcpNoDelay, true);
      _socket = socket;
      _subscription = socket.listen(
        _onData,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: true,
      );
      _status = BlcpStatus.open;
    } on Object catch (error) {
      _status = BlcpStatus.closed;
      await close();
      throw BlcpConnectionException(
        'failed to connect to ${config.host}:${config.port}: $error',
      );
    }
  }

  /// Closes the connection and fails every pending request.
  Future<void> close() async {
    if (_closing) return;
    _closing = true;
    try {
      _status = BlcpStatus.closed;
      _heartbeatTimer?.cancel();
      _heartbeatTimer = null;

      final subscription = _subscription;
      _subscription = null;
      final socket = _socket;
      _socket = null;

      if (subscription != null) {
        try {
          await subscription.cancel();
        } on Object {
          // The socket may already be gone.
        }
      }
      if (socket != null) {
        try {
          await socket.close();
        } on Object {
          // Ignore transport errors while closing.
        }
        try {
          socket.destroy();
        } on Object {
          // Ignore transport errors while closing.
        }
      }

      _failWaiters(const BlcpConnectionException('BLCP connection closed'));
    } finally {
      _closing = false;
    }
  }

  /// Closes the connection and the push stream.
  Future<void> dispose() async {
    await close();
    if (!_notifyController.isClosed) {
      await _notifyController.close();
    }
  }

  /// Sends one LCM heartbeat without waiting for the response.
  Future<void> heartbeat() async {
    final correlationId = randomCorrelationId();
    final body = LcmBody.heartbeat(
      logId: correlationId,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    await sendNowait(
      BlcpRequest.create(
        BlcpServiceId.lcm.value,
        BlcpMethodId.heartbeat.value,
        body: body,
        correlationId: correlationId,
      ),
    );
  }

  /// Restarts the heartbeat timer.
  ///
  /// [intervalMs] is the interval requested by the server; a value of zero
  /// falls back to [BlcpConfig.heartbeatInterval].
  void startHeartbeat([int intervalMs = 0]) {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    _heartbeatInterval = intervalMs > 0
        ? Duration(milliseconds: intervalMs)
        : config.heartbeatInterval;
    if (_heartbeatInterval <= Duration.zero) return;
    _heartbeatTimer = Timer.periodic(_heartbeatInterval, (_) {
      unawaited(_heartbeatTick());
    });
  }

  /// Current heartbeat interval (exposed for diagnostics).
  Duration get heartbeatInterval => _heartbeatInterval;

  Future<void> _heartbeatTick() async {
    try {
      await heartbeat();
    } on Object {
      _status = BlcpStatus.closed;
      await close();
    }
  }

  void _onData(Uint8List chunk) {
    try {
      for (final frame in _parser.feed(chunk)) {
        final packet = BlcpPacket.fromFrame(frame);
        if (packet is BlcpResponse) {
          _onResponse(packet);
        } else if (packet is BlcpNotify) {
          _onNotify(packet);
        }
      }
    } on Object {
      _handleClosed('BLCP protocol error');
      unawaited(close());
    }
  }

  void _onError(Object error) {
    _handleClosed('BLCP connection error: $error');
    unawaited(close());
  }

  void _onDone() {
    _handleClosed('BLCP connection closed by peer');
  }

  void _onResponse(BlcpResponse response) {
    if (response.serviceId == BlcpServiceId.lcm.value &&
        response.methodId == BlcpMethodId.heartbeat.value) {
      final lcm = response.lcm;
      if (lcm != null && lcm.nextIntervalMs > 0) {
        startHeartbeat(lcm.nextIntervalMs.toInt());
      }
    }
    final waiter = _waiters.remove(response.correlationId);
    if (waiter != null && !waiter.isCompleted) {
      waiter.complete(response);
    }
  }

  void _onNotify(BlcpNotify notify) {
    _pendingNotifies.addLast(notify);
    while (_pendingNotifies.length > config.maxPendingNotifications) {
      _pendingNotifies.removeFirst();
    }
    if (!_notifyController.isClosed) {
      _notifyController.add(notify);
    }
  }

  void _handleClosed(String reason) {
    _status = BlcpStatus.closed;
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    _failWaiters(BlcpConnectionException(reason));
  }

  void _failWaiters(Object error) {
    if (_waiters.isEmpty) return;
    final waiters = _waiters.values.toList(growable: false);
    _waiters.clear();
    for (final waiter in waiters) {
      if (!waiter.isCompleted) {
        waiter.completeError(error);
      }
    }
  }
}
