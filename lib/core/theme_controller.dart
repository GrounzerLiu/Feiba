import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App-wide appearance preference, persisted locally.
class ThemeController extends ChangeNotifier {
  ThemeController._();

  static final ThemeController instance = ThemeController._();

  static const String _key = 'theme_mode_v1';

  ThemeMode _mode = ThemeMode.system;
  SharedPreferences? _prefs;
  bool _loaded = false;

  ThemeMode get mode => _mode;
  bool get loaded => _loaded;

  String get label => switch (_mode) {
    ThemeMode.system => '跟随系统',
    ThemeMode.light => '浅色',
    ThemeMode.dark => '深色',
  };

  IconData get icon => switch (_mode) {
    ThemeMode.system => Icons.brightness_auto_rounded,
    ThemeMode.light => Icons.light_mode_rounded,
    ThemeMode.dark => Icons.dark_mode_rounded,
  };

  Future<void> load() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _mode = _fromName(_prefs!.getString(_key));
    } catch (_) {
      // Keep the default when local preferences are unavailable.
    }
    _loaded = true;
    notifyListeners();
  }

  Future<void> setMode(ThemeMode mode) async {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
    final prefs = _prefs;
    if (prefs == null) return;
    try {
      await prefs.setString(_key, mode.name);
    } catch (_) {
      // The current run still uses the selected mode.
    }
  }

  ThemeMode _fromName(String? value) => switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
