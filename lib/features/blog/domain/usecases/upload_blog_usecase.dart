import 'dart:io';

import 'package:blog_app/core/error/failure.dart';

import 'package:fpdart/src/either.dart';

import '../../../../core/usecase/interface_usecase.dart';
import '../entites/blog_entity.dart';
import '../repository/blog_repository.dart';

class UploadBlogUseCase implements UseCase<BlogEntity, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlogUseCase(this.blogRepository);

  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    final result = await blogRepository.uploadBlog(
      posterId: params.posterId,
      title: params.title,
      content: params.content,
      image: params.image,
      topics: params.topics,
    );

    return result;
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
    required this.posterId,
  });
}
