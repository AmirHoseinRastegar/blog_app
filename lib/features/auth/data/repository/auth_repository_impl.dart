import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await remoteDataSource.signUp(
          name: name, email: email, password: password);
      return right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(
      String email, String password) async {
    try {
      final response = await remoteDataSource.signIn(email, password);
      return right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final session = await remoteDataSource.getCurrentUserSession();
      if (session == null) {
        return left(Failure('user not logged in'));
      }
      return right(session);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
