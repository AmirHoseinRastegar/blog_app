import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/usecases/auth_signin_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/auth_signup_usecase.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/auth_user_entity.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc(this.signUpUseCase, this.loginUseCase) : super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthLoginEvent>(_onLogin);
  }

  void _onSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final user = await signUpUseCase.call(
      SignUpParams(
          name: event.name, email: event.email, password: event.password),
    );
    user.fold(
      (l) => emit(
        AuthError(l.message),
      ),
      (r) => emit(
        AuthSuccess(r),
      ),
    );
  }

  void _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final user = await loginUseCase.call(
      LoginParams(email: event.email, password: event.password),
    );
    user.fold(
      (l) => emit(
        AuthError(l.message),
      ),
      (r) => emit(
        AuthSuccess(r),
      ),
    );
  }
}
