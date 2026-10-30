import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A thread remembered locally so guests can keep reading history and
/// favorites without an account.
@immutable
class LocalThread {
  const LocalThread({
    required this.tid,
    required this.title,
    required this.forumName,
    this.authorName,
    this.visitedAt = 0,
    this.favoritedAt = 0,
  });

  factory LocalThread.fromJson(Map<String, dynamic> json) {
    return LocalThread(
      tid: (json['tid'] as num?)?.toInt() ?? 0,
      title: (json['title'] ?? '').toString(),
      forumName: (json['forum'] ?? '').toString(),
      authorName: json['author']?.toString(),
      visitedAt: (json['visitedAt'] as num?)?.toInt() ?? 0,
      favoritedAt: (json['favoritedAt'] as num?)?.toInt() ?? 0,
    );
  }

  final int tid;
  final String title;
  final String forumName;
  final String? authorName;
  final int visitedAt;
  final int favoritedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'tid': tid,
    'title': title,
    'forum': forumName,
    'author': authorName,
    'visitedAt': visitedAt,
    'favoritedAt': favoritedAt,
  };

  LocalThread copyWith({
    String? title,
    String? forumName,
    String? authorName,
    int? visitedAt,
    int? favoritedAt,
  }) {
    return LocalThread(
      tid: tid,
      title: title ?? this.title,
      forumName: forumName ?? this.forumName,
      authorName: authorName ?? this.authorName,
      visitedAt: visitedAt ?? this.visitedAt,
      favoritedAt: favoritedAt ?? this.favoritedAt,
    );
  }
}

/// Small local-only library used in guest mode.
///
/// SharedPreferences is optional: when the platform data directory is not
/// writable the library still works in memory for the current run.
class LocalLibrary extends ChangeNotifier {
  LocalLibrary._();

  static final LocalLibrary instance = LocalLibrary._();

  static const String _historyKey = 'library_history_v1';
  static const String _favoritesKey = 'library_favorites_v1';
  static const String _followedForumsKey = 'library_followed_forums_v1';
  static const String _searchesKey = 'library_recent_searches_v1';
  static const String _forumVisitsKey = 'library_forum_visits_v1';
  static const String _forumPalettesKey = 'library_forum_palettes_v1';
  static const String _forumAvatarsKey = 'library_forum_avatars_v1';
  static const String _forumAvatarBytesKey = 'library_forum_avatar_bytes_v1';
  static const int _historyLimit = 50;
  static const int _favoriteLimit = 100;
  static const int _recentForumLimit = 40;

  SharedPreferences? _prefs;
  final List<LocalThread> _history = <LocalThread>[];
  final List<LocalThread> _favorites = <LocalThread>[];
  final Set<String> _followedForums = <String>{};
  final List<String> _recentSearches = <String>[];
  final Map<String, int> _forumVisits = <String, int>{};
  final Map<String, List<int>> _forumPalettes = <String, List<int>>{};
  final Map<String, String> _forumAvatars = <String, String>{};
  final Map<String, String> _forumAvatarBytes = <String, String>{};
  bool _loaded = false;

  List<LocalThread> get history => List<LocalThread>.unmodifiable(_history);
  List<LocalThread> get favorites => List<LocalThread>.unmodifiable(_favorites);
  bool get loaded => _loaded;
  int get historyCount => _history.length;
  int get favoriteCount => _favorites.length;
  List<String> get followedForums => List<String>.unmodifiable(_followedForums);
  List<String> get recentSearches => List<String>.unmodifiable(_recentSearches);

  int? forumVisitedAt(String name) => _forumVisits[name.trim()];

  List<int>? forumPalette(String avatarUrl) =>
      _forumPalettes['url:$avatarUrl'] ?? _forumPalettes[avatarUrl];

  List<int>? forumPaletteByName(String forumName) =>
      _forumPalettes['name:${forumName.trim()}'];

  String? forumAvatar(String forumName) =>
      _forumAvatars[forumName.trim()];

  Uint8List? forumAvatarBytes(String forumName) {
    final raw = _forumAvatarBytes[forumName.trim()];
    if (raw == null || raw.isEmpty) return null;
    try {
      return base64Decode(raw);
    } catch (_) {
      return null;
    }
  }

  Future<void> setForumAvatarBytes(
    String forumName,
    Uint8List bytes,
  ) async {
    final name = forumName.trim();
    if (name.isEmpty || bytes.isEmpty) return;
    _forumAvatarBytes[name] = base64Encode(bytes);
    if (_forumAvatarBytes.length > 50) {
      _forumAvatarBytes.remove(_forumAvatarBytes.keys.first);
    }
    await _persistStringMap(_forumAvatarBytesKey, _forumAvatarBytes);
  }

  Future<void> setForumAvatar(String forumName, String avatarUrl) async {
    final name = forumName.trim();
    if (name.isEmpty || avatarUrl.isEmpty) return;
    _forumAvatars[name] = avatarUrl;
    if (_forumAvatars.length > 100) {
      _forumAvatars.remove(_forumAvatars.keys.first);
    }
    await _persistStringMap(_forumAvatarsKey, _forumAvatars);
  }

  Future<void> setForumPalette(
    String avatarUrl,
    List<int> colors, {
    String? forumName,
  }) async {
    if (avatarUrl.isEmpty || colors.length < 2) return;
    _forumPalettes['url:$avatarUrl'] = colors;
    final name = forumName?.trim() ?? '';
    if (name.isNotEmpty) _forumPalettes['name:$name'] = colors;
    if (_forumPalettes.length > 100) {
      _forumPalettes.remove(_forumPalettes.keys.first);
    }
    await _persistIntListMap(_forumPalettesKey, _forumPalettes);
  }

  List<String> get recentForums {
    final visits = <String, int>{..._forumVisits};
    for (final item in _history) {
      if (item.forumName.isEmpty) continue;
      visits.putIfAbsent(item.forumName, () => item.visitedAt);
    }
    final entries = visits.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .take(20)
        .map((entry) => entry.key)
        .toList(growable: false);
  }

  Future<void> load() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _history
        ..clear()
        ..addAll(_decode(_prefs!.getString(_historyKey)));
      _favorites
        ..clear()
        ..addAll(_decode(_prefs!.getString(_favoritesKey)));
      _followedForums
        ..clear()
        ..addAll(_decodeStrings(_prefs!.getString(_followedForumsKey)));
      _recentSearches
        ..clear()
        ..addAll(_decodeStrings(_prefs!.getString(_searchesKey)));
      _forumVisits
        ..clear()
        ..addAll(_decodeIntMap(_prefs!.getString(_forumVisitsKey)));
      _forumPalettes
        ..clear()
        ..addAll(_decodeIntListMap(_prefs!.getString(_forumPalettesKey)));
      _forumAvatars
        ..clear()
        ..addAll(_decodeStringMap(_prefs!.getString(_forumAvatarsKey)));
      _forumAvatarBytes
        ..clear()
        ..addAll(_decodeStringMap(_prefs!.getString(_forumAvatarBytesKey)));
    } catch (_) {
      // In-memory mode: browsing still works in this run.
    }
    _loaded = true;
    notifyListeners();
  }

  bool isFavorite(int tid) => _favorites.any((item) => item.tid == tid);

  bool isForumFollowed(String name) => _followedForums.contains(name);

  Future<void> recordForumVisit(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    _forumVisits[trimmed] = DateTime.now().millisecondsSinceEpoch;
    if (_forumVisits.length > _recentForumLimit) {
      final oldest = _forumVisits.entries.toList()
        ..sort((a, b) => a.value.compareTo(b.value));
      for (final entry in oldest.take(_forumVisits.length - _recentForumLimit)) {
        _forumVisits.remove(entry.key);
      }
    }
    notifyListeners();
    await _persistIntMap(_forumVisitsKey, _forumVisits);
  }

  Future<void> recordSearch(String keyword) async {
    final value = keyword.trim();
    if (value.isEmpty) return;
    _recentSearches.remove(value);
    _recentSearches.insert(0, value);
    if (_recentSearches.length > 8) {
      _recentSearches.removeRange(8, _recentSearches.length);
    }
    notifyListeners();
    await _persistStrings(_searchesKey, _recentSearches);
  }

  Future<void> clearSearches() async {
    _recentSearches.clear();
    notifyListeners();
    await _persistStrings(_searchesKey, <String>{});
    await _persistIntMap(_forumVisitsKey, _forumVisits);
  }

  Future<bool> toggleForumFollow(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return false;
    final followed = !_followedForums.remove(trimmed);
    if (followed) _followedForums.add(trimmed);
    notifyListeners();
    await _persistStrings(_followedForumsKey, _followedForums);
    return followed;
  }

  LocalThread? thread(int tid) {
    for (final item in _favorites) {
      if (item.tid == tid) return item;
    }
    for (final item in _history) {
      if (item.tid == tid) return item;
    }
    return null;
  }

  Future<void> recordThread({
    required int tid,
    required String title,
    required String forumName,
    String? authorName,
  }) async {
    if (tid == 0) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    final old = thread(tid);
    final entry = LocalThread(
      tid: tid,
      title: title.trim().isEmpty ? '无标题' : title.trim(),
      forumName: forumName.trim(),
      authorName: authorName,
      visitedAt: now,
      favoritedAt: old?.favoritedAt ?? 0,
    );
    _history.removeWhere((item) => item.tid == tid);
    _history.insert(0, entry);
    if (_history.length > _historyLimit) {
      _history.removeRange(_historyLimit, _history.length);
    }
    notifyListeners();
    await _persist(_historyKey, _history);
  }

  Future<bool> toggleFavorite({
    required int tid,
    required String title,
    required String forumName,
    String? authorName,
  }) async {
    if (tid == 0) return false;
    final index = _favorites.indexWhere((item) => item.tid == tid);
    if (index >= 0) {
      _favorites.removeAt(index);
      notifyListeners();
      await _persist(_favoritesKey, _favorites);
      return false;
    }
    final now = DateTime.now().millisecondsSinceEpoch;
    _favorites.insert(
      0,
      LocalThread(
        tid: tid,
        title: title.trim().isEmpty ? '无标题' : title.trim(),
        forumName: forumName.trim(),
        authorName: authorName,
        visitedAt: now,
        favoritedAt: now,
      ),
    );
    if (_favorites.length > _favoriteLimit) {
      _favorites.removeRange(_favoriteLimit, _favorites.length);
    }
    notifyListeners();
    await _persist(_favoritesKey, _favorites);
    return true;
  }

  Future<void> removeHistory(int tid) async {
    _history.removeWhere((item) => item.tid == tid);
    notifyListeners();
    await _persist(_historyKey, _history);
  }

  Future<void> removeFavorite(int tid) async {
    _favorites.removeWhere((item) => item.tid == tid);
    notifyListeners();
    await _persist(_favoritesKey, _favorites);
  }

  Future<void> clearHistory() async {
    _history.clear();
    notifyListeners();
    await _persist(_historyKey, _history);
  }

  Future<void> clearAll() async {
    _history.clear();
    _favorites.clear();
    _followedForums.clear();
    _recentSearches.clear();
    _forumVisits.clear();
    notifyListeners();
    await _persist(_historyKey, _history);
    await _persist(_favoritesKey, _favorites);
    await _persistStrings(_followedForumsKey, _followedForums);
    await _persistStrings(_searchesKey, <String>{});
  }

  List<LocalThread> _decode(String? raw) {
    if (raw == null || raw.isEmpty) return const <LocalThread>[];
    try {
      final value = jsonDecode(raw);
      if (value is! List) return const <LocalThread>[];
      return value
          .whereType<Map>()
          .map((item) => LocalThread.fromJson(item.cast<String, dynamic>()))
          .where((item) => item.tid != 0)
          .toList(growable: false);
    } catch (_) {
      return const <LocalThread>[];
    }
  }

  List<String> _decodeStrings(String? raw) {
    if (raw == null || raw.isEmpty) return const <String>[];
    try {
      final value = jsonDecode(raw);
      if (value is! List) return const <String>[];
      return value
          .whereType<String>()
          .where((item) => item.isNotEmpty)
          .toList();
    } catch (_) {
      return const <String>[];
    }
  }

  Map<String, String> _decodeStringMap(String? raw) {
    if (raw == null || raw.isEmpty) return <String, String>{};
    try {
      final value = jsonDecode(raw);
      if (value is! Map) return <String, String>{};
      return value.map(
        (key, dynamic item) => MapEntry(key.toString(), item.toString()),
      );
    } catch (_) {
      return <String, String>{};
    }
  }

  Future<void> _persistStringMap(
    String key,
    Map<String, String> value,
  ) async {
    final prefs = _prefs;
    if (prefs == null) return;
    try {
      await prefs.setString(key, jsonEncode(value));
    } catch (_) {
      // Storage is optional.
    }
  }

  Map<String, List<int>> _decodeIntListMap(String? raw) {
    if (raw == null || raw.isEmpty) return <String, List<int>>{};
    try {
      final value = jsonDecode(raw);
      if (value is! Map) return <String, List<int>>{};
      final result = <String, List<int>>{};
      value.forEach((key, dynamic item) {
        if (item is List) {
          result[key.toString()] = item
              .whereType<num>()
              .map((number) => number.toInt())
              .toList(growable: false);
        }
      });
      return result;
    } catch (_) {
      return <String, List<int>>{};
    }
  }

  Future<void> _persistIntListMap(
    String key,
    Map<String, List<int>> value,
  ) async {
    final prefs = _prefs;
    if (prefs == null) return;
    try {
      await prefs.setString(key, jsonEncode(value));
    } catch (_) {
      // Storage is optional.
    }
  }

  Map<String, int> _decodeIntMap(String? raw) {
    if (raw == null || raw.isEmpty) return const <String, int>{};
    try {
      final value = jsonDecode(raw);
      if (value is! Map) return const <String, int>{};
      final result = <String, int>{};
      for (final entry in value.entries) {
        final key = entry.key.toString();
        final number = entry.value;
        if (key.isNotEmpty && number is num) {
          result[key] = number.toInt();
        }
      }
      return result;
    } catch (_) {
      return const <String, int>{};
    }
  }

  Future<void> _persistIntMap(String key, Map<String, int> value) async {
    final prefs = _prefs;
    if (prefs == null) return;
    try {
      await prefs.setString(key, jsonEncode(value));
    } catch (_) {
      // Keep the in-memory copy; a restricted AppData directory is not fatal.
    }
  }

  Future<void> _persistStrings(String key, Iterable<String> value) async {
    final prefs = _prefs;
    if (prefs == null) return;
    try {
      await prefs.setString(key, jsonEncode(value.toList()));
    } catch (_) {
      // Keep the in-memory copy; a restricted AppData directory is not fatal.
    }
  }

  Future<void> _persist(String key, List<LocalThread> value) async {
    final prefs = _prefs;
    if (prefs == null) return;
    try {
      await prefs.setString(
        key,
        jsonEncode(value.map((item) => item.toJson()).toList()),
      );
    } catch (_) {
      // Keep the in-memory copy; a restricted AppData directory is not fatal.
    }
  }
}