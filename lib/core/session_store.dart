import 'package:shared_preferences/shared_preferences.dart';

import 'session.dart';

/// Bridges [Session] to SharedPreferences (Flutter-only).
class SessionStore {
  SessionStore._();

  static const String _kBduss = 'bduss';
  static const String _kStoken = 'stoken';
  static const String _kUserName = 'user_name';

  /// Loads persisted credentials into [Session].
  ///
  /// A denied AppData directory must not prevent the app from starting. In
  /// that case credentials remain in memory for this run and
  /// [Session.persistenceError] explains the limitation.
  static Future<void> load() async {
    final session = Session.instance;
    try {
      final prefs = await SharedPreferences.getInstance();
      session.bduss = prefs.getString(_kBduss);
      session.stoken = prefs.getString(_kStoken);
      session.userName = prefs.getString(_kUserName);
      session.onPersist = (s) async {
        try {
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
        } catch (error) {
          session.persistenceError = '无法写入应用数据目录，登录只在本次运行有效';
        }
      };
    } catch (error) {
      session.persistenceError = '无法读取应用数据目录，登录只在本次运行有效';
      session.onPersist = null;
    }
  }
}
