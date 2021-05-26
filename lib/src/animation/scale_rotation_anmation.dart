import 'package:flutter/material.dart';

class ScaleRotationAnimation extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<ScaleRotationAnimation>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2450),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    // controller.addListener(() {
    //   if (controller.isCompleted) {
    //   }
    // });

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
    return AnimatedScaleImage(
      animation: animation,
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

class AnimatedScaleImage extends AnimatedWidget {
  final Widget child;

  static final _opacityTween = Tween<double>(begin: 1.0, end: 1.0);
  static final _incrementTween = Tween<double>(begin: 200.0, end: 200.0);
  static final _decrementTween = Tween<double>(begin: 200.0, end: 0.0);

  AnimatedScaleImage({
    Key key,
    Animation<double> animation,
    @required this.child,
  }) : super(
          key: key,
          listenable: animation,
        );

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final tween = true ? _decrementTween : _incrementTween;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          height: tween.evaluate(animation),
          width: tween.evaluate(animation),
          child: child,
        ),
      ),
    );
  }
}