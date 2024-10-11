part of 'auth_bloc.dart';

@immutable
sealed class AuthStates {}

final class AuthInitial extends AuthStates {}

final class AuthLoading extends AuthStates {}

final class AuthSignOutSuccess extends AuthStates {}

final class AuthSuccess extends AuthStates {
  final UserEntity user;

  AuthSuccess(this.user);
}

final class AuthError extends AuthStates {
  final String message;

  AuthError(this.message);
}
