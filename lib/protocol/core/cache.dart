/// In-memory fid/fname cache, mirroring aiotieba's ForumInfoCache.
class ForumInfoCache {
  ForumInfoCache._();

  static final Map<int, String> _fnameById = <int, String>{};
  static final Map<String, int> _fidByName = <String, int>{};

  static String? getFname(int fid) => _fnameById[fid];

  static int? getFid(String fname) => _fidByName[fname];

  static void put({required int fid, required String fname}) {
    if (fid == 0 || fname.isEmpty) return;
    _fnameById[fid] = fname;
    _fidByName[fname] = fid;
  }

  static void clear() {
    _fnameById.clear();
    _fidByName.clear();
  }
}
