import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_demo/src/src.dart';

class MyLogoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32 * 2;

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: width,
            height: width,
            color: Colors.white,
            child: Container(
              width: 200,
              height: 200,
              child: FutureBuilder(
                future: Future.delayed(Duration(seconds: 1), () => true),
                builder: (context, snap) {
                  if (snap.hasData) {
                    return Stack(
                      children: [
                        ImageAnimation(
                          entry: ImagesAnimationEntry(
                            startIndex: 0,
                            endIndex: 84,
                            basePath: 'assets/images/medals/spin_',
                          ),
                          animationSeconds: 2450,
                        ),
                        AnimationScale(),
                        // ScaleAnimation(),
                        ImageAnimation(
                          entry: ImagesAnimationEntry(
                            startIndex: 0,
                            endIndex: 84,
                            basePath: 'assets/images/cover/cover_',
                          ),
                          animationSeconds: 2450,
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: CachedNetworkImage(
                      imageUrl: darkURL,
                      width: 200,
                      height: 200,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimationScale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MedalAnimation(imageUrl: darkURL),
        MedalAnimation(
          isScale: false,
          imageUrl: lightURL,
        ),
      ],
    );
  }
}

class MedalAnimation extends StatefulWidget {
  final String imageUrl;
  final bool isScale;

  MedalAnimation({
    this.imageUrl,
    this.isScale = true,
  });

  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<MedalAnimation>
    with SingleTickerProviderStateMixin {
  String get imageUrl => widget.imageUrl;

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
      curve: widget.isScale ? Curves.easeOut : Curves.easeIn,
    );
    controller.forward();
  }

  Widget build(BuildContext context) {
    return AnimatedScaleImage(
      animation: animation,
      isScale: widget.isScale,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
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
  final bool isScale;
  final Widget child;

  static final _opacityTween = Tween<double>(begin: 1.0, end: 1.0);
  static final _incrementTween = Tween<double>(begin: 0.0, end: 200.0);
  static final _decrementTween = Tween<double>(begin: 200.0, end: 0.0);

  AnimatedScaleImage({
    Key key,
    Animation<double> animation,
    this.isScale = true,
    @required this.child,
  }) : super(
          key: key,
          listenable: animation,
        );

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final tween = isScale ? _decrementTween : _incrementTween;
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
