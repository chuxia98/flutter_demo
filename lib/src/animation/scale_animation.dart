import 'package:flutter/material.dart';

class ScaleAnimation extends StatefulWidget {
  final Widget? child;
  final Duration? duration;
  final double begin;
  final double end;

  ScaleAnimation({
    Key? key,
    @required this.child,
    this.duration,
    this.begin = 0.0,
    this.end = 1.0,
  }) : super(key: key);

  @override
  _ScaleAnimationState createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration ?? const Duration(milliseconds: 750),
      vsync: this,
    );
    final curve = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );
    animation = Tween(begin: widget.begin, end: widget.end).animate(curve);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
