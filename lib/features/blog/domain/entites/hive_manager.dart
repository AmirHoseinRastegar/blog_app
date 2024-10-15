import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

class HiveManager {
  static const boxName= 'blogs';
  static final box = Hive.box<BlogEntity>(boxName);
  ValueListenable<Box<BlogEntity>> get listenable {
 return Hive.box<BlogEntity>(boxName).listenable();
}
  // static final box2 = Hive.box<BlogEntity>('bookmarks');

  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<BlogEntity>(BlogEntityAdapter());
    Hive.registerAdapter<BookMarkEntity>(BookMarkEntityAdapter());
    await Hive.openBox<BlogEntity>('blogs');
    await Hive.openBox<BookMarkEntity>('bookMarks');
  }

  static void uploadBlogs({required List<BlogEntity> blogs}) {
    for (int i = 0; i < blogs.length; i++) {
      box.put(blogs[i].id, blogs[i]);
    }
  }

  static List<BlogEntity> getBlogs() {
    return box.values.toList();
  }

  static addToBookmark({required BlogEntity blog}) {
    box.put(blog.id, blog);
  }

  static bool isBookMarked({required BlogEntity blog}) {
    return box.containsKey(blog.id);
  }

  static void removeBookmark({required BlogEntity blog}) {
    box.delete(blog.id);
  }
}
