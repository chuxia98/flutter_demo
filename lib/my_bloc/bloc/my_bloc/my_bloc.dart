import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_event.dart';
part 'my_state.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(MyInitial());

  @override
  Stream<MyState> mapEventToState(MyEvent event) async* {
    if (event is MyTitleChanged) {
      yield MyTitleChangeSuccess(title: event.title);
    }
  }
}
