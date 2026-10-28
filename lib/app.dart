import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'core/theme_controller.dart';
import 'ui/main_shell.dart';
import 'ui/theme.dart';

class FeibaApp extends StatelessWidget {
  const FeibaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeController.instance,
      builder: (context, _) => MaterialApp(
        title: 'Feiba',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(Brightness.light),
        darkTheme: buildAppTheme(Brightness.dark),
        themeMode: ThemeController.instance.mode,
        builder: (context, child) {
          final theme = Theme.of(context);
          final dark = theme.brightness == Brightness.dark;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: dark
                  ? Brightness.light
                  : Brightness.dark,
              systemNavigationBarColor: theme.scaffoldBackgroundColor,
              systemNavigationBarContrastEnforced: false,
              systemNavigationBarIconBrightness: dark
                  ? Brightness.light
                  : Brightness.dark,
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: const MainShell(),
      ),
    );
  }
}