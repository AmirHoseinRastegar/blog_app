import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../models/blog_model.dart';

abstract interface class LocalBlogDataSource {
  void uploadBlogs({required List<BlogModel> blogs});

  List<BlogModel> loadBlogs();
}

class LocalBlogDataSourceImpl implements LocalBlogDataSource {
  final Box box;

  LocalBlogDataSourceImpl(this.box);

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        blogs.add(BlogModel.fromJson(box.get(i.toString())));
      }
    });
    return blogs;
  }

  @override
  void uploadBlogs({required List<BlogModel> blogs}) {
    box.clear();
    box.write(() {

    for(int i=0; i<blogs.length; i++){

      box.put(i.toString(), blogs[i].toJson());}
    });

  }
}
