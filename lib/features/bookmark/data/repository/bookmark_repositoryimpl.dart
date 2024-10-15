import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/bookmark/data/data_source/local_bookmark_data_source.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/adapters.dart';

import '../../domain/repository/bookmark_repository.dart';

class BookMarkRepositoryImpl implements BookmarkRepository {
  final Box<BookMarkEntity> box;


  BookMarkRepositoryImpl(this.box,);





  @override
  Future<Either<Failure, void>> addBookmark(BookMarkEntity bookMarkEntity) async {
    try {
      await box.clear();
      await box.put(bookMarkEntity.id, bookMarkEntity);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to add bookmark'));
    }
  }

  @override
  Future<Either<Failure, List<BookMarkEntity>>> getBookmarks() async{
    try {
      final bookmarks = box.values.toList();
      return Right(bookmarks);
    } catch (e) {
      return Left(Failure('Failed to retrieve bookmarks'));
    }
  }

  @override
  Either<Failure, bool> isBookmarked(String posterId) {
    try {
      return Right(box.containsKey(posterId));
    } catch (e) {
      return Left(Failure('Failed to check bookmark status'));
    }
  }

  @override
  Future<Either<Failure, void>> removeBookmark(String posterId) async{
    try {
      await box.delete(posterId);
      return const Right(null);
    } catch (e) {
      return Left(Failure('Failed to remove bookmark'));
    }
  }
}
