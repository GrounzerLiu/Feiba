import '../core/enums.dart';
import '../core/utils.dart';

/// Helpers shared by the `uinfo_*` model variants.

/// Returns whether a `vipInfo` payload represents an active membership.
///
/// Mirrors aiotieba's `vipinfo2bool`: the membership is valid only when
/// `v_status` is non-zero and `e_time` (seconds) is still in the future.
bool vipInfoToBool(dynamic vipInfo) {
  if (vipInfo is! Map) return false;
  if (parseInt(vipInfo['v_status']) == 0) return false;
  final endTime = parseInt(vipInfo['e_time']);
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  return endTime > now;
}

/// Maps the textual gender used by the panel endpoint to [Gender].
Gender genderFromText(String sex) {
  if (sex == 'male') return Gender.male;
  if (sex == 'female') return Gender.female;
  return Gender.unknown;
}
