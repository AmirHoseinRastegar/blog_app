import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';

import 'package:fpdart/src/either.dart';

import '../../../../core/usecase/interface_usecase.dart';
import '../../../auth/domain/entities/auth_user_entity.dart';
import '../entites/blog_entity.dart';

class GetAllBlogsUseCase implements UseCase<List<BlogEntity>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogsUseCase({required this.blogRepository});

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async{
  return await blogRepository.getAllBlogs();
  }

}