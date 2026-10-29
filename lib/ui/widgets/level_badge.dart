import 'package:material_ui/material_ui.dart';

/// Tieba level ranges use distinct colors.
Color tiebaLevelColor(int level) {
  if (level >= 16) return const Color(0xFFD94F4F);
  if (level >= 13) return const Color(0xFFD98035);
  if (level >= 10) return const Color(0xFF8A6BE8);
  if (level >= 7) return const Color(0xFF4C8DFF);
  if (level >= 4) return const Color(0xFF3FAE8F);
  return const Color(0xFF8A8F98);
}

class LevelBadge extends StatelessWidget {
  const LevelBadge({super.key, required this.level, this.fontSize = 10});
  final int level;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = tiebaLevelColor(level);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Lv.$level',
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
