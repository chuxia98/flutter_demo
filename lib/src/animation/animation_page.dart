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
              barrierColor: Colors.orange.withOpacity(0.1),
              pageBuilder: (context, a, b) {
                return MyLogoApp();
              },
            );
          },
        ),
      ),
    );
  }
}
