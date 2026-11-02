import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:media_kit/media_kit.dart';

import 'app.dart';
import 'core/local_library.dart';
import 'core/session_store.dart';
import 'core/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await SessionStore.load();
  await LocalLibrary.instance.load();
  unawaited(LocalLibrary.instance.preloadForumAvatarBytes());
  await ThemeController.instance.load();
  runApp(const FeibaApp());
}