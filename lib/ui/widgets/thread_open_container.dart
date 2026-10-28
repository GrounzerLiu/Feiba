import 'package:animations/animations.dart';
import 'package:material_ui/material_ui.dart';

/// Material container-transform wrapper for expanding a thread card into its
/// detail page, equivalent to Compose shared bounds.
class ThreadOpenContainer extends StatelessWidget {
  const ThreadOpenContainer({
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
