import 'package:bloc/bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);
  int selectedIndex = 0;

  void changeIndex(int index) {
    emit(selectedIndex = index);
  }
}
