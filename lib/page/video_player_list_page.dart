import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

const _urls = [
  'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1280_10MG.mp4',
  'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4',
  'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1920_18MG.mp4',
  'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
  'https://samplelib.com/lib/download/mp4/sample-5s.mp4',
  'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4'
];

class PlayerReloadCubit extends Cubit<String> {
  PlayerReloadCubit() : super('');

  void reload(String url) => emit(url);
}

Map<String, CustomPlayerModel> players = {};

class CustomPlayerModel {
  final String? url;

  CustomPlayerModel({
    this.url,
  }) {
    _controller = VideoPlayerController.network(url ?? '');
    _initialize = _controller?.initialize();
  }

  Future? _initialize;
  VideoPlayerController? _controller;
  bool _isDisposed = false;

  Future? get initialize => _initialize;
  VideoPlayerController? get controller => _controller;
  bool get isDisposed => _isDisposed;

  bool get isPlaying => _controller?.value.isPlaying ?? false;

  Future<void> play() async {
    _controller?.play();
  }

  Future<void>? pause() => _controller?.pause();

  Future<void> dispose() async {
    _isDisposed = true;
    await _controller?.dispose();
  }
}

class VideoplayerListPage extends StatelessWidget {
  const VideoplayerListPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerReloadCubit>(
      create: (context) => PlayerReloadCubit(),
      child: _ContentPage(),
    );
  }
}

class _ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List'),
      ),
      body: BlocBuilder<PlayerReloadCubit, String>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: _urls.length,
            itemBuilder: (context, index) {
              return VideoItem(url: _urls[index]);
            },
          );
        },
      ),
    );
  }
}

class VideoItem extends StatefulWidget {
  final String url;

  const VideoItem({
    required this.url,
  });

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  String get url => widget.url;

  CustomPlayerModel? model;

  @override
  void dispose() {
    model?.dispose();
    players.remove(url);
    super.dispose();
  }

  @override
  void deactivate() {
    model?.pause();
    super.deactivate();
  }

  @override
  void initState() {
    super.initState();

    if (!players.containsKey(url) && model != null) {
      model = CustomPlayerModel(url: url);
      players[url] = model!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
        aspectRatio: 16 / 9.0,
        child: FutureBuilder(
          future: model?.initialize,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: _.randColor,
                    child: VideoPlayer(model!.controller!),
                  ),
                  (model?.isPlaying ?? false)
                      ? PlayButton(
                          iconData: Icons.pause,
                          onTap: () async {
                            await model?.pause();
                            context.read<PlayerReloadCubit>().reload(url);
                          },
                        )
                      : PlayButton(
                          onTap: () async {
                            players.forEach((key, current) async {
                              await current.pause();
                            });
                            await model?.play();
                            context.read<PlayerReloadCubit>().reload(url);
                          },
                        ),
                ],
              );
            }
            return _VideoLoading();
          },
        ),
      ),
      padding: EdgeInsets.only(bottom: 100),
    );
  }
}

class _VideoLoading extends StatelessWidget {
  const _VideoLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _.randColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  final Function()? onTap;
  final IconData? iconData;

  const PlayButton({
    this.onTap,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(iconData ?? Icons.play_arrow),
      ),
      onPressed: onTap,
    );
  }
}

extension _ on Colors {
  static Color get randColor {
    final r = Random().nextInt(255);
    final g = Random().nextInt(255);
    final b = Random().nextInt(255);
    return Color.fromRGBO(r, g, b, 1);
  }
}
