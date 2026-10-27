/// Result models of the chat login APIs.
library;

import '../core/utils.dart';

/// Result of the IM login (`login_blcp_im`).
class LoginImResult {
  const LoginImResult({this.triggerId = 0, this.uk = 0, this.bduk = ''});

  /// Chat session identifier, used as `origin_id` of chat room requests.
  final int triggerId;

  /// Chat account identifier, used as `uk` of chat room requests.
  final int uk;

  /// Chat account `bd_uid` (bduk) identifier.
  final String bduk;

  /// Parses the IM login payload.
  ///
  /// `trigger_id` is a list on the wire; its first element is used.
  factory LoginImResult.fromJson(Map<String, dynamic> data) {
    final trigger = data['trigger_id'];
    final triggerId = trigger is List && trigger.isNotEmpty
        ? parseInt(trigger.first)
        : 0;
    return LoginImResult(
      triggerId: triggerId,
      uk: parseInt(data['uk']),
      bduk: parseString(data['bd_uid']),
    );
  }

  @override
  String toString() =>
      'LoginImResult(triggerId: $triggerId, uk: $uk, bduk: $bduk)';
}
