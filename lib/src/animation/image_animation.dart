import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class ImageAnimation extends StatefulWidget {
  final double width;
  final double height;
  final ImagesAnimationEntry entry;
  final int animationSeconds;

  ImageAnimation({
    Key key,
    this.width,
    this.height,
    this.entry,
    this.animationSeconds = 3000,
  }) : super(key: key);

  @override
  _ImageAnimationState createState() => _ImageAnimationState();
}

class _ImageAnimationState extends State<ImageAnimation>
    with TickerProviderStateMixin {
  int get animationSeconds => widget.animationSeconds;

  double get width => widget.width;

  double get height => widget.height;

  ImagesAnimationEntry get entry => widget.entry;

  AnimationController _controller;
  Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: animationSeconds),
    )..forward();
    _animation = IntTween(
      begin: entry.startIndex,
      end: entry.endIndex,
    ).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: Key('imageAnimation_main_animatedBuilder'),
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        String name = sprintf('%05d', [_animation.value]);
        return Image.asset(
          '${entry.basePath}$name.png',
          width: width,
          height: height,
          gaplessPlayback: true,
        );
      },
    );
  }
}

class ImagesAnimationEntry {
  int startIndex = 0;
  int endIndex = 0;
  String basePath;

  ImagesAnimationEntry({
    this.startIndex,
    this.endIndex,
    this.basePath = 'assets/images/check_in/check',
  });
}
