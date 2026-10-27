/// Exceptions raised by the BLCP control/session protocol.
///
/// Ported from `aiotieba/core/blcp/exception.py` (Unlicense).
library;

/// Base class for every BLCP failure.
class BlcpException implements Exception {
  const BlcpException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// The received packet does not respect the LCP framing rules.
class BlcpProtocolException extends BlcpException {
  const BlcpProtocolException(super.message);
}

/// A BLCP login (LCM, IM or cloud control) was rejected.
class BlcpLoginException extends BlcpException {
  const BlcpLoginException(super.message);
}

/// The BLCP connection could not be established or was lost.
class BlcpConnectionException extends BlcpException {
  const BlcpConnectionException(super.message);
}
