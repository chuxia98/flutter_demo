part of 'my_bloc.dart';

abstract class MyEvent extends Equatable {}

class MyTitleChanged extends MyEvent {
  final String title;

  MyTitleChanged({
    this.title = '',
  });

  @override
  List<Object> get props => [title];
}
