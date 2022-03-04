import 'package:flutter/material.dart';

class ScaleRotationAnimation extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<ScaleRotationAnimation> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  void initState() {
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

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedScaleImage extends AnimatedWidget {
  final Widget? child;

  static final _opacityTween = Tween<double>(begin: 1.0, end: 1.0);
  static final _decrementTween = Tween<double>(begin: 200.0, end: 0.0);

  AnimatedScaleImage({
    Key? key,
    required Animation<double> animation,
    required this.child,
  }) : super(
          key: key,
          listenable: animation,
        );

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final tween = _decrementTween;
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
