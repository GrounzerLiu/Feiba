/// Account state shared by the whole app.
///
/// Deliberately free of Flutter dependencies so it can be used from pure Dart
/// tools (e.g. `tool/smoke.dart`). Persistence is injected by the app layer
/// through [onPersist].
class Session {
  Session._();

  static final Session instance = Session._();

  String? bduss;
  String? stoken;
  String? userName;

  /// Set when the platform preferences store cannot be used (e.g. a
  /// restricted AppData directory). Login then only lives for this run.
  String? persistenceError;

  /// Set by the app layer (see `session_store.dart`).
  Future<void> Function(Session session)? onPersist;

  bool get isLoggedIn => (bduss?.isNotEmpty ?? false);

  Future<void> save({
    required String bduss,
    String? stoken,
    String? userName,
  }) async {
    this.bduss = bduss.trim();
    this.stoken = (stoken ?? '').trim().isEmpty ? null : stoken!.trim();
    if (userName != null) this.userName = userName;
    await onPersist?.call(this);
  }

  Future<void> clear() async {
    bduss = null;
    stoken = null;
    userName = null;
    await onPersist?.call(this);
  }
}
