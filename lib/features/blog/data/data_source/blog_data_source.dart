import 'dart:io';

import 'package:supabase/supabase.dart';

import '../../../../core/error/server_exception.dart';
import '../models/blog_model.dart';

abstract class BlogDataSource {
  Future<BlogModel> uploadBlogs(BlogModel blogModel);

  Future<String> getImageUrl(
    BlogModel blogModel,
    File path,
  );

  Future<List<BlogModel>> getBlogs();
}

class BlogDataSourceImpl implements BlogDataSource {
  final SupabaseClient client;

  BlogDataSourceImpl({required this.client});

  @override
  Future<BlogModel> uploadBlogs(BlogModel blogModel) async {
    try {
      final response =
          await client.from('blogs').insert(blogModel.toJson()).select();
      return BlogModel.fromJson(response.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getBlogs() {
    // TODO: implement getBlogs
    throw UnimplementedError();
  }

  @override
  Future<String> getImageUrl(BlogModel blogModel, File path) async {
    try {
      final response = await client.storage.from('blogs').upload(
            blogModel.id,
            path,
          );
      final url = client.storage.from('blogs').getPublicUrl(blogModel.id);
      return url;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
