import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class BookmarkRepository {
  Future<Either<Failure,BlogEntity>> addBookmark({required String posterId,
      required String title,
      required String content,
      required File image,
      required List<String> topics,});
  Future<Either<Failure,void>> removeBookmark(String id);
  Future<Either<Failure,List<BookMarkEntity>>> getAllBookmarks();
  Future<Either<Failure,bool>> isBookmarked(String id);
}