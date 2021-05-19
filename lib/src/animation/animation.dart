import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class MyLogoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        LogoApp(
          isScale: false,
          imageUrl:
              'https://img1.baidu.com/it/u=1738731514,3938762464&fm=26&fmt=auto&gp=0.jpg',
        ),
        LogoApp(
          imageUrl:
              'https://img1.baidu.com/it/u=1741431004,2509692489&fm=26&fmt=auto&gp=0.jpg',
        ),
      ],
    );
  }
}

class LogoApp extends StatefulWidget {
  final String imageUrl;
  final bool isScale;

  LogoApp({
    this.imageUrl,
    this.isScale = true,
  });

  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  String get imageUrl => widget.imageUrl;

  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: widget.isScale ? Curves.easeOut : Curves.easeIn,
    );
    controller.forward();
  }

  Widget build(BuildContext context) {
    controller.reset();
    controller.forward();
    return AnimatedLogo(
      animation: animation,
      imageUrl: imageUrl,
      isScale: widget.isScale,
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedLogo extends AnimatedWidget {
  final String imageUrl;
  final bool isScale;

  static final _opacityTween = new Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = new Tween<double>(begin: 0.0, end: 300.0);
  static final _sizeBigTween = new Tween<double>(begin: 300.0, end: 0.0);

  AnimatedLogo({
    Key key,
    Animation<double> animation,
    this.imageUrl,
    this.isScale = true,
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
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height: tween.evaluate(animation),
          width: tween.evaluate(animation),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }
}
