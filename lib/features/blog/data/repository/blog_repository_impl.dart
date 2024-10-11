import 'dart:io';

import 'package:blog_app/core/connection_checker/connection_checker.dart';
import 'package:blog_app/core/error/server_exception.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entites/blog_entity.dart';
import '../../domain/repository/blog_repository.dart';
import '../data_source/blog_data_source.dart';
import '../data_source/local_blog_data_source.dart';
import '../models/blog_model.dart';

class BlogRepositoryImpl implements BlogRepository {
  final ConnectionChecker connectionChecker;
  final BlogDataSource dataSource;
  final LocalBlogDataSource localDataSource;

  BlogRepositoryImpl(
      this.connectionChecker, this.dataSource, this.localDataSource);

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required String posterId,
    required String title,
    required String content,
    required File image,
    required List<String> topics,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return Left(Failure('No internet connection'));
      }
      final blogModel = BlogModel(
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
        id: const Uuid().v1(),
      );
      final imageUrl = await dataSource.getImageUrl(blogModel, image);

      final blogModel2 = blogModel.copyWith(imageUrl: imageUrl);

      final result = await dataSource.uploadBlogs(blogModel2);

      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return right(localDataSource.loadBlogs());
      }
      final blogsUploaded = await dataSource.getAllBlogs();
      localDataSource.uploadBlogs(blogs: blogsUploaded);
      return Right(blogsUploaded);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }


}
