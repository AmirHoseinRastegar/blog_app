import 'package:blog_app/core/error/failure.dart';

import 'package:fpdart/src/either.dart';

import '../../../../core/usecase/interface_usecase.dart';
import '../entities/auth_user_entity.dart';
import '../repository/auth_repository.dart';

class SessionUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  SessionUseCase({required this.repository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    final userData = await repository.getCurrentUser();
    return userData;
  }
}
