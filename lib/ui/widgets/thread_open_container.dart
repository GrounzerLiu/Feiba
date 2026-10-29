import 'package:material_ui/material_ui.dart';

/// Opens a thread card with the platform's default page transition.
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
    void open() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (childContext) => openBuilder(childContext),
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: open,
      child: closedBuilder(context, open),
    );
  }
}
