/// Tieba chat websocket core.
///
/// Ported from `aiotieba/core/websocket/core.py` (Unlicense).
///
/// The core owns the socket and dispatches every binary frame by command id:
/// frames without a registered callback complete a pending [WsResponse];
/// frames with one (e.g. server pushes) are handed to that callback.
library;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import '../account.dart';
import '../constants.dart';
import 'enums.dart';
import 'handshake.dart';
import 'helper.dart';
import 'msgid.dart';

/// Callback signature for a websocket command.
typedef WsCallback = FutureOr<void> Function(
  WsCore core,
  Uint8List data,
  int reqId,
);

/// Configuration of a [WsCore].
class WsConfig {
  const WsConfig({
    this.url = defaultWsUrl,
    this.userAgent = defaultWsUserAgent,
    this.extensions = 'im_version=2.3',
    this.acceptEncoding = 'gzip',
    this.cookie,
    this.extraHeaders = const <String, String>{},
    this.readTimeout = const Duration(seconds: 8),
    this.heartbeat = const Duration(seconds: 180),
  });

  /// Websocket URL.
  final String url;

  /// User-Agent header value.
  final String userAgent;

  /// `Sec-WebSocket-Extensions` value.
  final String extensions;

  /// `Accept-Encoding` value.
  final String acceptEncoding;

  /// Optional `Cookie` header.
  final String? cookie;

  /// Extra handshake headers.
  final Map<String, String> extraHeaders;

  /// How long [WsResponse.read] waits before timing out.
  final Duration readTimeout;

  /// Websocket ping interval; [Duration.zero] disables pings.
  final Duration heartbeat;
}

/// One pending websocket response.
class WsResponse {
  WsResponse(this.reqId, this.readTimeout);

  /// Request id sent with the frame.
  final int reqId;

  /// How long [read] waits.
  final Duration readTimeout;

  final Completer<Uint8List> _completer = Completer<Uint8List>();
  bool _cancelled = false;

  /// Whether the response already arrived (or failed).
  bool get isCompleted => _completer.isCompleted;

  /// Waits for and returns the response payload.
  Future<Uint8List> read() async {
    if (_cancelled) {
      throw StateError('websocket response was cancelled');
    }
    try {
      return await _completer.future.timeout(readTimeout);
    } on TimeoutException {
      throw TimeoutException('Timeout to read websocket response', readTimeout);
    }
  }

  /// Marks the response as cancelled; a later [read] throws.
  void cancel() {
    _cancelled = true;
  }

  /// Completes with [data].
  void complete(Uint8List data) {
    if (!_completer.isCompleted) _completer.complete(data);
  }

  /// Completes with [error].
  void completeError(Object error) {
    if (!_completer.isCompleted) _completer.completeError(error);
  }

  /// Marks a failure as observed so it cannot become an unhandled error when
  /// no caller ever awaits [read].
  void silence() {
    if (!_completer.isCompleted) return;
    unawaited(_completer.future.then<void>((_) {}, onError: (Object _) {}));
  }
}

/// Response bookkeeping keyed by request id.
class WsWaiter {
  WsWaiter(this.readTimeout)
    : _reqId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  /// Read timeout applied to new responses.
  final Duration readTimeout;

  final Map<int, WsResponse> _waiters = <int, WsResponse>{};
  int _reqId;

  /// Creates a response slot with the next request id.
  WsResponse newResponse() {
    final id = ++_reqId;
    final response = WsResponse(id, readTimeout);
    _waiters[id] = response;
    return response;
  }

  /// Completes the response for [reqId] with [data].
  void setDone(int reqId, Uint8List data) {
    final response = _waiters.remove(reqId);
    response?.complete(data);
  }

  /// Drops the response for [reqId].
  void remove(int reqId) {
    _waiters.remove(reqId);
  }

  /// Fails every pending response.
  void failAll(Object error) {
    if (_waiters.isEmpty) return;
    final responses = _waiters.values.toList(growable: false);
    _waiters.clear();
    for (final response in responses) {
      response
        ..completeError(error)
        ..silence();
    }
  }
}

/// Core container for the chat websocket.
class WsCore {
  WsCore({
    required this.account,
    this.clientVersion = TiebaConstants.latestVersion,
    this.config = const WsConfig(),
  });

  /// Account used to derive the AES key.
  TiebaAccount account;

  /// Client version reported by `upload_ws_sec`.
  final String clientVersion;

  /// Connection settings.
  final WsConfig config;

  /// Message id bookkeeping; recreated on every [connect].
  MsgIdManager midManager = MsgIdManager();

  final Map<int, WsCallback> _callbacks = <int, WsCallback>{};

  WebSocket? _socket;
  StreamSubscription<dynamic>? _subscription;
  WsWaiter? _waiter;
  WsStatus _status = WsStatus.closed;

  /// Current connection state.
  WsStatus get status {
    if (_status != WsStatus.closed) {
      final socket = _socket;
      if (socket == null || socket.closeCode != null) {
        _status = WsStatus.closed;
      }
    }
    return _status;
  }

  /// Replaces the account.
  void setAccount(TiebaAccount newAccount) => account = newAccount;

  /// Registers a callback for command [cmd].
  void registerCallback(int cmd, WsCallback callback) {
    _callbacks[cmd] = callback;
  }

  /// Removes the callback registered for [cmd].
  void unregisterCallback(int cmd) {
    _callbacks.remove(cmd);
  }

  /// Marks the connection as open after `upload_ws_sec` succeeded.
  void markOpen() => _status = WsStatus.open;

  /// Establishes the websocket connection.
  Future<void> connect() async {
    await close();
    _status = WsStatus.connecting;
    _waiter = WsWaiter(config.readTimeout);
    midManager = MsgIdManager();

    final handshake = WsHandshake(
      url: config.url,
      userAgent: config.userAgent,
      extensions: config.extensions,
      acceptEncoding: config.acceptEncoding,
      cookie: config.cookie,
      extraHeaders: config.extraHeaders,
    );

    try {
      final socket = await handshake.connect();
      socket.pingInterval = config.heartbeat;
      _socket = socket;
      _subscription = socket.listen(
        _onMessage,
        onDone: _onDone,
        onError: _onError,
        cancelOnError: true,
      );
    } on Object {
      _status = WsStatus.closed;
      await close();
      rethrow;
    }
  }

  /// Closes the connection and fails every pending response.
  Future<void> close() async {
    _status = WsStatus.closed;

    final socket = _socket;
    _socket = null;
    final subscription = _subscription;
    _subscription = null;
    final waiter = _waiter;
    _waiter = null;

    waiter?.failAll(StateError('websocket connection closed'));

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
    }
  }

  /// Sends [data] and returns the response slot for the server reply.
  Future<WsResponse> send(
    Uint8List data,
    int cmd, {
    bool compress = false,
    bool encrypt = true,
  }) {
    final waiter = _waiter;
    final socket = _socket;
    if (waiter == null || socket == null || socket.closeCode != null) {
      throw StateError('websocket connection is not open');
    }
    final response = waiter.newResponse();
    final payload = packWsBytes(
      account,
      data,
      cmd,
      response.reqId,
      compress: compress,
      encrypt: encrypt,
    );
    try {
      socket.add(payload);
    } on Object {
      waiter.remove(response.reqId);
      response.cancel();
      rethrow;
    }
    return Future<WsResponse>.value(response);
  }

  void _onMessage(dynamic message) {
    if (message is! List<int>) return;
    try {
      final frame = parseWsBytes(account, Uint8List.fromList(message));
      final callback = _callbacks[frame.cmd];
      if (callback == null) {
        _waiter?.setDone(frame.reqId, frame.data);
        return;
      }
      unawaited(() async {
        try {
          await callback(this, frame.data, frame.reqId);
        } on Object {
          // A failing push callback must not tear down the dispatcher.
        }
      }());
    } on Object catch (error) {
      _status = WsStatus.closed;
      _waiter?.failAll(error);
      unawaited(close());
    }
  }

  void _onError(Object error) {
    _status = WsStatus.closed;
    _waiter?.failAll(error);
    unawaited(close());
  }

  void _onDone() {
    _status = WsStatus.closed;
    _waiter?.failAll(StateError('websocket connection closed by peer'));
  }
}
