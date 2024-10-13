import 'package:blog_app/features/blog/domain/entites/hive_manager.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../blog/data/models/blog_model.dart';
import '../../../blog/domain/entites/blog_entity.dart';

abstract class BookmarkLocalDataSource {
  BlogModel addToBookmark({required BlogEntity blog});

  bool isBookMarked({required BlogEntity blog});

  Future<void> removeBookmark(String id);

  Future<List<BookMarkEntity>> getAllBookmarks();

  Future<bool> isBookmarked(String id);
}

class BookmarkLocalDataSourceImpl implements BookmarkLocalDataSource {
  final Box<BookMarkEntity> box;

  BookmarkLocalDataSourceImpl({
    required this.box,
  });
  //
  // @override
  // Future<void> addBookmark(BookMarkEntity bookmark) async {
  //   await box.put(bookmark.id, bookmark);
  // }

  @override
  Future<List<BookMarkEntity>> getAllBookmarks() async {
    return box.values.cast<BookMarkEntity>().toList();
  }

  @override
  Future<bool> isBookmarked(String id) async {
    return box.containsKey(id);
  }

  @override
  Future<void> removeBookmark(String id) async {
    await box.delete(id);
  }

  @override
  BlogModel addToBookmark({required BlogEntity blog}) {
   return HiveManager.addToBookmark(blog: blog);
  }

  @override
  bool isBookMarked({required BlogEntity blog}) {
    return HiveManager.isBookMarked(blog: blog);
  }
}
