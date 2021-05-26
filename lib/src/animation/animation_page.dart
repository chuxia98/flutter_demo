import 'package:flutter/material.dart';
import 'package:flutter_demo/src/animation/image_animation.dart';
import 'package:flutter_demo/src/animation/rotation_animation.dart';

import 'animation.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              IconButton(
                icon: Icon(Icons.point_of_sale),
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.3),
                    pageBuilder: (context, a, b) {
                      return PageView.builder(
                        itemBuilder: (context, index) {
                          return MyLogoApp();
                        },
                        itemCount: 3,
                      );
                    },
                  );
                },
              ),
              Container(
                height: 300,
                color: Colors.red.withOpacity(0.3),
                child: RotationAnimation(),
              ),
              Container(
                height: 300,
                child: AnimationScale(),
              ),
              ImageAnimation(
                entry: ImagesAnimationEntry(
                  startIndex: 0,
                  endIndex: 84,
                  basePath: 'assets/images/medals/spin_',
                ),
                animationSeconds: 2450,
              )
            ],
          ),
        ),
      ),
    );
  }
}
