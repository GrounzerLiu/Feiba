/// Base class for protocol-layer failures.
class TiebaException implements Exception {
  const TiebaException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// The server returned a non-zero error code.
class TiebaServerException extends TiebaException {
  const TiebaServerException(this.code, this.serverMessage)
    : super('server error $code: $serverMessage');

  final int code;
  final String serverMessage;
}

/// HTTP status was not 200 or the response was empty.
class TiebaHttpException extends TiebaException {
  const TiebaHttpException(this.statusCode, this.reason)
    : super('http $statusCode: $reason');

  final int statusCode;
  final String reason;
}

/// A response body could not be decoded.
class TiebaFormatException extends TiebaException {
  const TiebaFormatException(super.message);
}

/// An argument was outside the range accepted by the protocol.
class TiebaValueException extends TiebaException {
  const TiebaValueException(super.message);
}
