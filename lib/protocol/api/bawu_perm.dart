import 'dart:convert';

import '../core/http_core.dart';
import '../models/bawu_enums.dart';
import '../models/bawu_perm.dart';
import '_common.dart';
import 'bawu_common.dart';

/// The permissions that can be granted, in the order the server expects them,
/// paired with the numeric `perm` id used by the permission API.
const List<(BawuPermType, int)> _permIds = <(BawuPermType, int)>[
  (BawuPermType.unblock, 4),
  (BawuPermType.unblockAppeal, 5),
  (BawuPermType.recover, 3),
  (BawuPermType.recoverAppeal, 2),
];

/// Fetches the permissions already granted to one forum moderator.
///
/// [portrait] must be the user portrait; resolve it with the user-info API
/// first when only an id is available.
Future<BawuPerm> fetchBawuPerm(
  TiebaHttpCore http, {
  required int fid,
  required String portrait,
}) async {
  final json = await http.webGetJson(
    '/mo/q/getAuthToolPerm',
    query: <String, String>{'forum_id': '$fid', 'portrait': portrait},
  );
  ensureWebOk(json);
  return BawuPerm.fromJson(requireWebData(json));
}

/// Replaces the permissions granted to one forum moderator.
///
/// Pass the complete desired permission set; a permission that is not part of
/// [perms] is switched off.
Future<void> setBawuPerm(
  TiebaHttpCore http, {
  required int fid,
  required String portrait,
  BawuPermType perms = BawuPermType.none,
}) async {
  final settings = <Map<String, int>>[
    for (final (perm, id) in _permIds)
      <String, int>{'switch': perms.contains(perm) ? 1 : 0, 'perm': id},
  ];
  final json = await http.webPostForm(
    '/mo/q/setAuthToolPerm',
    <MapEntry<String, String>>[
      MapEntry<String, String>('forum_id', '$fid'),
      MapEntry<String, String>('auth_user_portrait', portrait),
      MapEntry<String, String>('perm_setting', jsonEncode(settings)),
    ],
  );
  ensureWebOk(json);
}
