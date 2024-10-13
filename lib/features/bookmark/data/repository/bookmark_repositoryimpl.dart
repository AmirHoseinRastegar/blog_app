import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/bookmark/data/data_source/local_bookmark_data_source.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../blog/data/models/blog_model.dart';
import '../../domain/repository/bookmark_repository.dart';

class BookMarkRepositoryImpl implements BookmarkRepository {
  final BookmarkLocalDataSource localDataSource;

  BookMarkRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<BookMarkEntity>>> getAllBookmarks() async {
    try {
      final res = await localDataSource.getAllBookmarks();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isBookmarked(String id) async {
    try {
      final res = await localDataSource.isBookmarked(id);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeBookmark(String id) async {
    try {
      final res = await localDataSource.removeBookmark(id);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BlogEntity>> addBookmark(
      {required String posterId,
      required String title,
      required String content,
      required File image,
      required List<String> topics}) async {
    try {
      final blogModel = BlogModel(
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
        id: const Uuid().v1(),
      );
      final bookMarkModel = BlogModel(
          title: '',
          content: content,
          imageUrl: '',
          topics: topics,
          posterId: posterId,
          updatedAt: DateTime.now(),
          id: const Uuid().v1());

      final result = localDataSource.addToBookmark(blog: bookMarkModel);

      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
