import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            _JoyIconTag(
              text: 'text',
              iconData: Icons.add,
            ),
          ],
        ),
      ),
    );
  }
}

class _JoyIconTag extends StatelessWidget {
  final String? text;
  final IconData? iconData;

  _JoyIconTag({
    this.text,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: Colors.white,
            size: 16,
          ),
          Text(
            text ?? '',
            style: TextStyle(color: Colors.white),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
