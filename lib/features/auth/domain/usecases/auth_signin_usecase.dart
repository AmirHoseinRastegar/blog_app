import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';

import 'package:fpdart/src/either.dart';

import '../../../../core/usecase/interface_usecase.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    final user = await repository.signIn(params.email, params.password);
    return user;
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
