import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class BookmarkRepository {
  Either<Failure, bool> isBookmarked(String posterId);
  Future<Either<Failure, void>> addBookmark(BookMarkEntity blog);
  Future<Either<Failure, void>> removeBookmark(String posterId);
  Future<Either<Failure, List<BookMarkEntity>>> getBookmarks();
}

