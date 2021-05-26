import 'package:flutter/material.dart';

class RotationAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _MedalAnimation();
  }
}

class _MedalAnimation extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<_MedalAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1450),
      vsync: this,
    );
    // animation = new Tween(begin: 0.0, end: 10.0).animate(controller);
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  Widget build(BuildContext context) {
    return RotationTransition(
      turns: animation,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Image.asset(
          'assets/images/medals/spin_00024.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
