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
      String name, String email, String password) async {
    try {
      final response = await remoteDataSource.signUp(name, email, password);
      return right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async{

    try {
      final response =await remoteDataSource.signIn(email, password);
      return right(response);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
