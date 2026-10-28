import 'package:material_ui/material_ui.dart';

/// Feiba brand blue, derived from the Tieba visual language.
const Color kSeedColor = Color(0xFF4477E0);
const Color kBrandBlue = Color(0xFF4477E0);
const Color kBrandBlueDark = Color(0xFF6E9BFF);
const Color kLightBackground = Color(0xFFF3F6FA);
const Color kDarkBackground = Color(0xFF0D131B);

ThemeData buildAppTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final base = ColorScheme.fromSeed(
    seedColor: kSeedColor,
    brightness: brightness,
  );
  final scheme = base.copyWith(
    primary: isDark ? kBrandBlueDark : kBrandBlue,
    onPrimary: Colors.white,
    primaryContainer: isDark
        ? const Color(0xFF1E3159)
        : const Color(0xFFE7EEFF),
    onPrimaryContainer: isDark
        ? const Color(0xFFD9E5FF)
        : const Color(0xFF1B2A4A),
    secondary: isDark ? const Color(0xFF9AA8BF) : const Color(0xFF6D7A8F),
    surface: isDark ? const Color(0xFF141C26) : Colors.white,
    onSurface: isDark ? const Color(0xFFE7EDF5) : const Color(0xFF1B2433),
    surfaceContainerHighest: isDark
        ? const Color(0xFF222C39)
        : const Color(0xFFF0F3F8),
    outlineVariant: isDark ? const Color(0xFF2B3746) : const Color(0xFFE8EDF4),
    error: isDark ? const Color(0xFFFFB4AB) : const Color(0xFFBA1A1A),
  );

  final textTheme = ThemeData(brightness: brightness).textTheme.copyWith(
    headlineSmall: const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.6,
      height: 1.15,
    ),
    titleLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
    ),
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 1.3,
    ),
    titleSmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.35,
    ),
    bodyLarge: const TextStyle(fontSize: 15, height: 1.55),
    bodyMedium: const TextStyle(fontSize: 14, height: 1.55),
    bodySmall: const TextStyle(fontSize: 12, height: 1.45),
    labelLarge: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
    labelMedium: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: const TextStyle(fontSize: 11, height: 1.3),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: isDark ? kDarkBackground : kLightBackground,
    canvasColor: isDark ? kDarkBackground : kLightBackground,
    textTheme: textTheme,
    splashFactory: InkSparkle.splashFactory,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
      },
    ),
    iconButtonTheme: IconButtonThemeData(
      variant: StyleVariant.material3Expressive,
      style: IconButton.styleFrom(
        sizeVariant: ButtonSizeVariant.small,
        iconButtonWidth: IconButtonWidthVariant.standard,
        shapeVariant: ButtonShapeVariant.round,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: isDark ? kDarkBackground : kLightBackground,
      foregroundColor: scheme.onSurface,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: textTheme.titleLarge?.copyWith(color: scheme.onSurface),
    ),
    navigationBarTheme: NavigationBarThemeData(
      height: 68,
      elevation: 0,
      backgroundColor: isDark ? const Color(0xFF111923) : Colors.white,
      indicatorColor: scheme.primary.withValues(alpha: 0.13),
      surfaceTintColor: Colors.transparent,
    ),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant,
      thickness: 1,
      space: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark ? const Color(0xFF1A2431) : const Color(0xFFF1F4F9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: scheme.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: scheme.error),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: isDark
          ? const Color(0xFF1A2431)
          : const Color(0xFFF0F3F8),
      side: BorderSide.none,
      shape: const StadiumBorder(),
      labelStyle: textTheme.labelMedium?.copyWith(color: scheme.onSurface),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      showCheckmark: false,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: textTheme.labelLarge,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(color: scheme.outlineVariant),
        textStyle: textTheme.labelLarge,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: textTheme.labelLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      backgroundColor: isDark
          ? const Color(0xFF263241)
          : const Color(0xFF253043),
      contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: scheme.primary,
      strokeWidth: 2.4,
    ),
  );
}

/// A subtle tonal surface used by cards and sheets.
Color surfaceTintFor(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  return scheme.brightness == Brightness.dark
      ? const Color(0xFF182230)
      : const Color(0xFFFFFFFF);
}
