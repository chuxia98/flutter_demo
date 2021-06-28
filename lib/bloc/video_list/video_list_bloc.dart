import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_list_event.dart';
part 'video_list_state.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState> {
  VideoListBloc() : super(VideoListInitial());

  @override
  Stream<VideoListState> mapEventToState(
    VideoListEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
