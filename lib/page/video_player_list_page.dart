import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/bloc/bloc.dart';

class VideoplayerListPage extends StatelessWidget {
  const VideoplayerListPage();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VideoListBloc>(create: (_) => VideoListBloc()),
      ],
      child: _ContentPage(),
    );
  }
}

class _ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
