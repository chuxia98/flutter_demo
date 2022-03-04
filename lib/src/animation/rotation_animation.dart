import 'package:flutter/material.dart';

class RotationAnimation extends StatefulWidget {
  final Widget? child;
  final Duration? duration;

  RotationAnimation({
    this.child,
    this.duration,
  });

  _RotationAnimationState createState() => new _RotationAnimationState();
}

class _RotationAnimationState extends State<RotationAnimation> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration ?? const Duration(milliseconds: 1500),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );
    animation.addStatusListener(animationListener);
    controller.forward();
  }

  void animationListener(AnimationStatus status) {
    if (!mounted) return;
    if (status == AnimationStatus.completed) {
      controller.stop();
    } else if (status == AnimationStatus.dismissed) {
      controller.forward();
    }
  }

  Widget build(BuildContext context) {
    return RotationTransition(
      turns: animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
