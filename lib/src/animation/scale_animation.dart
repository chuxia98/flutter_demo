import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ScaleAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MedalAnimationV2(
      fromChild: Center(
        child: CachedNetworkImage(
          imageUrl: 'http://baidu.bmw.123.png',
          placeholder: (context, _) {
            return Image.asset(
              'assets/images/medal_placeholder.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            );
          },
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

class MedalAnimationV2 extends StatefulWidget {
  final Widget fromChild;
  final Widget toChild;

  MedalAnimationV2({
    this.fromChild,
    this.toChild,
  });

  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<MedalAnimationV2>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    );
    controller.forward();
  }

  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: widget.fromChild,
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
