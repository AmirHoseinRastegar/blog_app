import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../features/auth/domain/entities/auth_user_entity.dart';

part 'persist_login_state.dart';

class PersistLoginCubit extends Cubit<PersistLoginState> {
  PersistLoginCubit() : super(PersistLoginInitial());


  void userSession( UserEntity? user) {
    if(user==null){
      emit(PersistLoginInitial());
    }
    else{
      emit(IsLoggedIn(user:user));
    }
  }
}
