import 'package:shared_preferences/shared_preferences.dart';

import 'session.dart';

/// Bridges [Session] to SharedPreferences (Flutter-only).
class SessionStore {
  SessionStore._();

  static const String _kBduss = 'bduss';
  static const String _kStoken = 'stoken';
  static const String _kUserName = 'user_name';

  /// Loads persisted credentials into [Session].
  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final session = Session.instance;
    session.bduss = prefs.getString(_kBduss);
    session.stoken = prefs.getString(_kStoken);
    session.userName = prefs.getString(_kUserName);
    session.onPersist = (s) async {
      final p = await SharedPreferences.getInstance();
      if (s.bduss == null || s.bduss!.isEmpty) {
        await p.remove(_kBduss);
      } else {
        await p.setString(_kBduss, s.bduss!);
      }
      if (s.stoken == null || s.stoken!.isEmpty) {
        await p.remove(_kStoken);
      } else {
        await p.setString(_kStoken, s.stoken!);
      }
      if (s.userName == null || s.userName!.isEmpty) {
        await p.remove(_kUserName);
      } else {
        await p.setString(_kUserName, s.userName!);
      }
    };
  }
}
