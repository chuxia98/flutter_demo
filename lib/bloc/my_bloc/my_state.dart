part of 'my_bloc.dart';

abstract class MyState extends Equatable {
  @override
  List<Object> get props => [];
}

class MyInitial extends MyState {}

class MyTitleChangeSuccess extends MyState {
  final String title;

  MyTitleChangeSuccess({
    this.title = '',
  });

  @override
  List<Object> get props => [title];
}
