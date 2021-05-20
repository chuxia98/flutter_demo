import 'package:bloc/bloc.dart';

class MyCubit extends Cubit<int> {
  final int index;
  MyCubit({this.index = 0}) : super(index);

  void increment({int count}) => emit(count + 1);
}
