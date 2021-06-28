import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/src/src.dart';
import 'package:joy_ui/joy_ui.dart';
import 'package:startup_configuration/startup_configuration.dart';

import 'test/test.dart';
import 'page/page.dart';

void main() {
  runApp(_BlocProvider());
}

class _BlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => JoyThemeBloc(
                  brand: Brand.bmw,
                )),
      ],
      child: BlocBuilder<JoyThemeBloc, JoyThemeState>(
        builder: (c, s) {
          return MyApp();
        },
      ),
    );
  }
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
    final string = 'lesson my name is tom/vA/ hhh';

    final exp = new RegExp(r"/.*/");
    final sources = exp.allMatches(string);

    if (sources.isNotEmpty) {
      sources.map((e) {
        print('[---] ${e.group(0)}');
      });

      final text = sources.first.group(0);
      final array = string.split(text);

      print(array);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _ListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final route = MaterialPageRoute(builder: (_) => NewsScreen());
          Navigator.of(context).push(route);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  final Map<String, Widget> items = const {
    'bloc use': const MyBlocPage(),
    'animation': const AnimationPage(),
    'dismissible': const DismissiblePage(),
    'joy': const JoyPage(),
    'Videoplayer List': const VideoplayerListPage(),
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
          tileColor: index % 2 == 0 ? Colors.amber[100] : Colors.red[100],
          leading: Container(
            padding: EdgeInsets.all(10),
            width: 100,
            alignment: Alignment.centerLeft,
            child: Text(key),
          ),
        );
      },
    );
  }
}
