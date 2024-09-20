import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'obsecure_password_state.dart';

class ObscurePasswordCubit extends Cubit<bool> {
  ObscurePasswordCubit() : super(true);
  bool isObscured=true;
  void  isObscuredPassword(bool obscure){
    emit(!state);


  }
}
