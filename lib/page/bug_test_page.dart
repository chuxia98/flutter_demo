import 'package:flutter/material.dart';
import 'package:flutter_demo/page/page.dart';

class BugTestPage extends StatelessWidget {
  const BugTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUG'),
      ),
      body: Column(
        children: [
          TextField(),
          VideoItem(
            url:
                'https://mybmwclub-media-int.bmw-emall.cn/mybmw-public/community/moment/55126f00-3d00-41c6-8f5e-32a75be4ff9d.mp4', // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          ),
        ],
      ),
    );
  }
}
