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
      // body: MyLogoApp(),
      body: Container(
        child: IconButton(
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
      ),
    );
  }
}
