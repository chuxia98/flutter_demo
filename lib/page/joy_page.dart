import 'package:flutter/material.dart';
import 'package:joy_ui/joy_ui.dart';

class JoyPage extends StatelessWidget {
  const JoyPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joy'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            JoyListItem.tags(
              title: 'this is title',
              tags: [
                JoyTag.regular(
                  text: 'text',
                  size: JoyTagSize.normal,
                  weight: JoyTagWeight.light,
                ),
              ],
            ),
            JoyListItem.loading(title: 'title'),
            JoyListItem(
              title: 'Tpoic',
              leadingTag: JoyTag.regular(
                text: 'text',
                size: JoyTagSize.small,
                weight: JoyTagWeight.light,
              ),
              subtitle: '评论 100',
            ),
          ],
        ),
      ),
    );
  }
}
