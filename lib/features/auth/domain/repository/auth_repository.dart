import 'package:blog_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUp(
      {required String name, required String email, required String password});

  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserEntity>> getCurrentUser();
}
