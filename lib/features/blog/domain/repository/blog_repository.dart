import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String posterId,
    required String title,
    required String content,
    required File image,
    required List<String> topics,
  });

  Future<Either<Failure, List<BlogEntity>>> getAllBlogs();
}
