import 'package:flutter/material.dart';
import 'package:flutter_demo/page/page.dart';

class BugTestPage extends StatelessWidget {
  const BugTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final body = Scaffold(
      appBar: AppBar(
        title: Text('BUG ??'),
      ),
      body: Column(
        children: [
          TextField(),
          VideoItem(
            url: 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: MaterialButton(
              color: Colors.yellow,
              height: 44,
              child: Center(
                child: Text('Button'.toUpperCase()),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );

    return body;
  }
}
