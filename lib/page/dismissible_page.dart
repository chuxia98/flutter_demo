import 'package:flutter/material.dart';

import '../src/src.dart';

class DismissiblePage extends StatelessWidget {
  const DismissiblePage({
    this.items = const [1, 2, 3],
  });

  final List items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dismissible'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return AppDismissible(
            key: Key('index'),
            listItem: Container(
              height: 74,
              color: index % 2 == 0 ? Colors.lightBlue : Colors.purple,
            ),
            slidableKey: Key('$index'),
            removeAction: ActionConfiguration(
              label: 'remove',
              performAction: () {
                print('----');
                items.removeAt(index);
              },
            ),
          );
        },
      ),
    );
  }
}
