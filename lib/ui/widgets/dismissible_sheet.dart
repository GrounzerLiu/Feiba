import 'package:material_ui/material_ui.dart';

/// A bottom-sheet body with one resting height and a continuous close gesture.
///
/// The sheet can be dragged from its resting height all the way to the bottom;
/// when it gets close to zero the modal route is popped once. There is no
/// intermediate detent, so dragging down never snaps back to the opening size
/// before closing.
class DismissibleSheet extends StatefulWidget {
  const DismissibleSheet({
    super.key,
    required this.initialSize,
    required this.builder,
  });

  final double initialSize;
  final Widget Function(BuildContext context, ScrollController controller)
  builder;

  @override
  State<DismissibleSheet> createState() => _DismissibleSheetState();
}

class _DismissibleSheetState extends State<DismissibleSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onExtentChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onExtentChanged)
      ..dispose();
    super.dispose();
  }

  void _onExtentChanged() {
    if (_closing || !_controller.isAttached) return;
    if (_controller.size > 0.05) return;
    _closing = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Only pop our own modal sheet. If the route already went away (for
      // example because the framework dismissed it), popping again would
      // also remove the page underneath.
      if (ModalRoute.of(context)?.isCurrent != true) return;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: widget.initialSize,
      minChildSize: 0,
      maxChildSize: widget.initialSize,
      expand: false,
      snap: true,
      snapAnimationDuration: const Duration(milliseconds: 220),
      builder: widget.builder,
    );
  }
}