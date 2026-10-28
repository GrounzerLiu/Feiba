import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';

/// Container transform for a forum card expanding into a forum page.
class ForumOpenContainer extends StatelessWidget {
  const ForumOpenContainer({
    super.key,
    required this.closedBuilder,
    required this.openBuilder,
    this.closedRadius = 18,
  });

  final Widget Function(BuildContext context, VoidCallback open) closedBuilder;
  final WidgetBuilder openBuilder;
  final double closedRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 320),
      transitionType: ContainerTransitionType.fadeThrough,
      closedColor: theme.colorScheme.surface,
      openColor: theme.scaffoldBackgroundColor,
      middleColor: theme.scaffoldBackgroundColor,
      closedElevation: 0,
      openElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(closedRadius),
      ),
      openShape: const RoundedRectangleBorder(),
      closedBuilder: (context, open) => closedBuilder(context, open),
      openBuilder: (context, _) => openBuilder(context),
    );
  }
}
