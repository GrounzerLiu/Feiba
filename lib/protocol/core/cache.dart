import 'dart:collection';

/// In-memory fid/fname cache, mirroring aiotieba's 128-entry LRU.
class ForumInfoCache {
  ForumInfoCache._();

  static const int _maxSize = 128;
  static final LinkedHashMap<int, String> _fnameById =
      LinkedHashMap<int, String>();
  static final LinkedHashMap<String, int> _fidByName =
      LinkedHashMap<String, int>();

  static String? getFname(int fid) {
    final fname = _fnameById.remove(fid);
    if (fname == null) return null;
    _fnameById[fid] = fname;
    return fname;
  }

  static int? getFid(String fname) {
    final fid = _fidByName.remove(fname);
    if (fid == null) return null;
    _fidByName[fname] = fid;
    return fid;
  }

  static void put({required int fid, required String fname}) {
    if (fid == 0 || fname.isEmpty) return;
    _fnameById.remove(fid);
    _fidByName.remove(fname);
    _fnameById[fid] = fname;
    _fidByName[fname] = fid;
    while (_fnameById.length > _maxSize) {
      final oldestFid = _fnameById.keys.first;
      final oldestName = _fnameById.remove(oldestFid);
      if (oldestName != null) _fidByName.remove(oldestName);
    }
    while (_fidByName.length > _maxSize) {
      final oldestName = _fidByName.keys.first;
      final oldestFid = _fidByName.remove(oldestName);
      if (oldestFid != null) _fnameById.remove(oldestFid);
    }
  }

  static int get length => _fnameById.length;

  static void clear() {
    _fnameById.clear();
    _fidByName.clear();
  }
}
