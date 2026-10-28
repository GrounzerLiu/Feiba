import 'package:flutter/physics.dart';
import 'package:material_ui/material_ui.dart';

/// A small Material 3 Expressive shape-morph surface.
///
/// The rest and pressed polygons are official [MaterialShapes]. Pressing
/// animates the border with a spring simulation, which is the motion model
/// used by the Material 3 Expressive shape sample.
class MorphingShape extends StatefulWidget {
  const MorphingShape({
    super.key,
    required this.child,
    required this.color,
    this.size = 64,
    this.restShape,
    this.pressedShape,
    this.onTap,
  });

  final Widget child;
  final Color color;
  final double size;
  final RoundedPolygon? restShape;
  final RoundedPolygon? pressedShape;
  final VoidCallback? onTap;

  @override
  State<MorphingShape> createState() => _MorphingShapeState();
}

class _MorphingShapeState extends State<MorphingShape>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController.unbounded(
    vsync: this,
  );
  late final ShapeBorderTween _shape = ShapeBorderTween(
    begin: MaterialShapeBorder(
      shape: widget.restShape ?? MaterialShapes.cookie9Sided,
    ),
    end: MaterialShapeBorder(
      shape: widget.pressedShape ?? MaterialShapes.circle,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(double target) {
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = target;
      return;
    }
    _controller.animateWith(
      SpringSimulation(
        SpringDescription.withDampingRatio(
          ratio: 0.72,
          stiffness: 380,
          mass: 1,
        ),
        _controller.value,
        target,
        0,
        snapToEnd: true,
      ),
    );
  }

  void _press() => _animateTo(1);
  void _release() => _animateTo(0);

  @override
  Widget build(BuildContext context) {
    final surface = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _press(),
      onTapUp: (_) => _release(),
      onTapCancel: _release,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: widget.color,
                shape: _shape.evaluate(_controller) ?? _shape.begin!,
              ),
              child: Center(child: child),
            ),
          );
        },
        child: widget.child,
      ),
    );
    return widget.onTap == null
        ? ExcludeSemantics(child: surface)
        : Semantics(button: true, child: surface);
  }
}
