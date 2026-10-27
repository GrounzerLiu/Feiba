import '../core/exceptions.dart';
import '../core/http_core.dart';
import '../models/uinfo_panel.dart';
import '_common.dart';

/// Fetches the lightweight user panel by user name or portrait.
///
/// [nameOrPortrait] is treated as a portrait when it starts with `tb.`,
/// matching aiotieba's `is_portrait`.
Future<UserInfoPanel> fetchUserPanel(
  TiebaHttpCore http, {
  required String nameOrPortrait,
}) async {
  final isPortrait = nameOrPortrait.startsWith('tb.');
  final json = await http.webGetJson(
    '/home/get/panel',
    query: <String, String>{isPortrait ? 'id' : 'un': nameOrPortrait},
  );
  ensureWebOk(json);
  final data = json['data'];
  if (data is! Map) {
    throw const TiebaFormatException('panel data is missing');
  }
  return UserInfoPanel.fromJson(data.cast<String, dynamic>());
}
