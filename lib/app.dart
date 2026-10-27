import 'package:flutter/material.dart';

import 'ui/home_page.dart';
import 'ui/theme.dart';

class FeibaApp extends StatelessWidget {
  const FeibaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feiba',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(Brightness.light),
      darkTheme: buildAppTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
