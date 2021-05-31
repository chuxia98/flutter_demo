import 'package:flutter/material.dart';

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
                color: Colors.green.withOpacity(0.3),
                width: 240,
                height: 240,
                child: OpacityAnimation(
                  child: RotationAnimation(
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.asset(
                        'assets/images/spin.png',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              ImageAnimation(
                entry: ImagesAnimationEntry(
                  startIndex: 0,
                  endIndex: 84,
                  basePath: 'assets/images/medals/spin_',
                ),
                animationSeconds: 2450,
                isRepeat: true,
              ),
              Container(
                height: 300,
                child: AnimationScale(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
