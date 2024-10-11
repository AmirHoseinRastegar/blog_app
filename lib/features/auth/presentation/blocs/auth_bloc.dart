import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/usecases/auth_signin_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/auth_signup_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../core/cubit/presist_user_login_cubit/persist_login_cubit.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/usecases/session_usecase.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStates> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;
  final PersistLoginCubit persistLoginCubit;
  final SessionUseCase sessionUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc(this.signUpUseCase, this.loginUseCase, this.persistLoginCubit,
      this.sessionUseCase, this.signOutUseCase)
      : super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUpEvent>(_onSignUp);
    on<AuthLoginEvent>(_onLogin);
    on<IsUserLoggedInEvent>(_onIsUserLoggedIn);
    on<AuthSignOutEvent>(_onSignOut);
  }

  void _onSignUp(AuthSignUpEvent event, Emitter<AuthStates> emit) async {
    final user = await signUpUseCase.call(
      SignUpParams(
          name: event.name, email: event.email, password: event.password),
    );
    user.fold(
      (l) => emit(
        AuthError(l.message),
      ),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onLogin(AuthLoginEvent event, Emitter<AuthStates> emit) async {
    final user = await loginUseCase.call(
      LoginParams(email: event.email, password: event.password),
    );
    user.fold(
      (l) => emit(
        AuthError(l.message),
      ),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onIsUserLoggedIn(
      IsUserLoggedInEvent event, Emitter<AuthStates> emit) async {
    final result = await sessionUseCase.call(NoParams());
    result.fold(
      (l) => emit(
        AuthError(l.message),
      ),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthStates> emit) {
    persistLoginCubit.userSession(user);
    emit(AuthSuccess(user));
  }

  FutureOr<void> _onSignOut(
      AuthSignOutEvent event, Emitter<AuthStates> emit) async {
    final signOut = await signOutUseCase.call(NoParams());
    signOut.fold(
      (l) => emit(
        AuthError(l.message),
      ),
      (r) => emit(AuthSignOutSuccess()),
    );
  }
}
