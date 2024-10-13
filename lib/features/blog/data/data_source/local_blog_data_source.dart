import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/blog/domain/entites/hive_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../models/blog_model.dart';

abstract interface class LocalBlogDataSource {
  void uploadBlogs({required List<BlogEntity> blogs});

  List<BlogEntity> loadBlogs();


  bool isBookMarked({required BlogEntity blog});
}

class LocalBlogDataSourceImpl implements LocalBlogDataSource {
  final Box box;

  LocalBlogDataSourceImpl(this.box);

  @override
  List<BlogEntity> loadBlogs() {
    return HiveManager.getBlogs();
  }

  @override
  void uploadBlogs({required List<BlogEntity> blogs}) {
    HiveManager.uploadBlogs(blogs: blogs);
  }



  @override
  bool isBookMarked({required BlogEntity blog}) {
    return HiveManager.isBookMarked(blog: blog);
  }

// @override
// List<BlogModel> loadBlogs() {
//   List<BlogModel> blog = [];
//   box.read(() {
//     for (int i = 0; i < box.length; i++) {
//       blog.add(BlogModel.fromJson(box.get(i.toString())));
//     }
//   });
//   print(blog);
//
//   return blog;
// }
//
// @override
// void uploadBlogs({required List<BlogModel> blogs}) {
//   box.clear();
//   box.write(() {
//
//   for(int i=0; i<blogs.length; i++){
//
//     box.put(i.toString(), blogs[i].toJson());}
//   });
//
// }
}
