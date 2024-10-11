import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/usecase/interface_usecase.dart';
import '../repository/auth_repository.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}
