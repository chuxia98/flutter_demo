part of 'video_list_bloc.dart';

abstract class VideoListState extends Equatable {
  const VideoListState();
  
  @override
  List<Object> get props => [];
}

class VideoListInitial extends VideoListState {}
