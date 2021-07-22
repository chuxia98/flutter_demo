// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';

class MyCubit extends Cubit<int> {
  final int index;
  MyCubit({this.index = 0}) : super(index);

  void increment({int count = 0}) => emit(count + 1);
}
