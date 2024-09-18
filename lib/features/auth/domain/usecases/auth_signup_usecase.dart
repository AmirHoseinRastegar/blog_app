import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';

import 'package:fpdart/src/either.dart';

import '../../../../core/usecase/interface_usecase.dart';

class SignUpUseCase implements UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(params) async {
    final user =
        await repository.signUp(params.email, params.name, params.password);
    return user;
  }
}

class SignUpParams {
  final String email;
  final String name;
  final String password;

  SignUpParams(
      {required this.name, required this.email, required this.password});
}
