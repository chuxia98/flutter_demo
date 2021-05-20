import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

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
            color: Colors.red,
            child: Container(
              width: 200,
              height: 200,
              child: FutureBuilder(
                future: Future.delayed(
                  Duration(seconds: 2),
                  () => true,
                ),
                builder: (context, snap) {
                  if (snap.hasData) {
                    return AnimationScale();
                  }
                  return Center(
                    child: Image.asset(
                      'assets/images/medal_level_3_normal.png',
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
        LogoApp(
          imageUrl:
              'https://img1.baidu.com/it/u=1741431004,2509692489&fm=26&fmt=auto&gp=0.jpg',
          imagePath: 'assets/images/medal_level_3_normal.png',
        ),
        LogoApp(
          isScale: false,
          imageUrl:
              'https://img1.baidu.com/it/u=1738731514,3938762464&fm=26&fmt=auto&gp=0.jpg',
          imagePath: 'assets/images/medal_level_3.png',
        ),
      ],
    );
  }
}

class LogoApp extends StatefulWidget {
  final String imageUrl;
  final String imagePath;
  final bool isScale;

  LogoApp({
    this.imageUrl,
    this.imagePath,
    this.isScale = true,
  });

  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  String get imageUrl => widget.imageUrl;
  String get imagePath => widget.imagePath;

  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1450),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: widget.isScale ? Curves.easeOut : Curves.easeIn,
    );
    controller.forward();
  }

  Widget build(BuildContext context) {
    // controller.reset();
    // controller.forward();
    return AnimatedLogo(
      animation: animation,
      isScale: widget.isScale,
      child: imagePath.isNotEmpty
          ? Image.asset(imagePath)
          : CachedNetworkImage(
              imageUrl: imageUrl,
            ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  final bool isScale;
  final Widget child;

  static final _opacityTween = new Tween<double>(begin: 1.0, end: 1.0);
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 200.0);
  static final _sizeBigTween = new Tween<double>(begin: 200.0, end: 0.0);

  AnimatedLogo({
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
    final tween = isScale ? _sizeBigTween : _sizeTween;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation) ?? 0.1,
        child: new Container(
          height: tween.evaluate(animation),
          width: tween.evaluate(animation),
          child: child,
        ),
      ),
    );
  }
}
