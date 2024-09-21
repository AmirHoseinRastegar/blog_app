part of 'persist_login_cubit.dart';

@immutable
sealed class PersistLoginState {}

final class PersistLoginInitial extends PersistLoginState {}
final class IsLoggedIn extends PersistLoginState {
  final UserEntity user;

  IsLoggedIn({required this.user});
}
