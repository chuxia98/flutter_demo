import 'package:flutter/material.dart';

class OpacityAnimation extends StatefulWidget {
  final Widget? child;
  final Duration? duration;
  final double begin;
  final double end;

  OpacityAnimation({
    this.child,
    this.duration,
    this.begin = 1.0,
    this.end = 0.0,
  });

  @override
  _OpacityAnimationState createState() => _OpacityAnimationState();
}

class _OpacityAnimationState extends State<OpacityAnimation> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration ?? const Duration(milliseconds: 350),
      vsync: this,
      reverseDuration: const Duration(milliseconds: 850),
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
      Future.delayed(Duration(seconds: 1), () {
        controller.reverse();
      });
    } else if (status == AnimationStatus.dismissed) {
      controller.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedOpacity(
      animation: animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _AnimatedOpacity extends AnimatedWidget {
  final Widget? child;

  _AnimatedOpacity({
    Key? key,
    required Animation<double> animation,
    @required this.child,
  }) : super(
          key: key,
          listenable: animation,
        );

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: animation.value,
        child: child,
      ),
    );
  }
}
