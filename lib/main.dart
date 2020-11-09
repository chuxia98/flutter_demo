import 'package:flutter/material.dart';

import 'my_bloc/my_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  final Map<String, Widget> items = const {
    'bloc use': const MyBlocPage(),
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final key = items.keys.toList()[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {
            final page = items[key];
            final route = MaterialPageRoute(builder: (_) => page);
            Navigator.of(context).push(route);
          },
          leading: Container(
            padding: EdgeInsets.all(10),
            color: index % 2 == 0 ? Colors.amber[100] : Colors.red[100],
            alignment: Alignment.centerLeft,
            child: Text(key),
          ),
        );
      },
    );
  }
}
