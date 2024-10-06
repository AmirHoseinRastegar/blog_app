import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/entities/auth_user_entity.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/blog_model.dart';
import '../../../domain/usecases/upload_blog_usecase.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase uploadBlogUseCase;
  final GetAllBlogsUseCase getAllBlogUseCase;

  BlogBloc(this.uploadBlogUseCase, this.getAllBlogUseCase)
      : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<UploadBlogsEvent>(_uploadBlogs);
    on<GetAllBlogsEvent>(_onGetAllBlogs);
  }

  void _uploadBlogs(UploadBlogsEvent event, Emitter<BlogState> emit) async {
    final result = await uploadBlogUseCase.call(UploadBlogParams(
      title: event.title,
      content: event.content,
      posterId: event.posterId,
      image: event.image,
      topics: event.topics,
    ));
    result.fold(
      (l) => emit(BlogError(message: l.message)),
      (r) => emit(
        BlogUploadSuccess(),
      ),
    );
  }

  void _onGetAllBlogs(GetAllBlogsEvent event, Emitter<BlogState> emit) async {
    final response = await getAllBlogUseCase.call(NoParams());
    response.fold(
      (l) => emit(BlogError(message: l.message)),
      (r) => emit(
        BlogGetAllBlogsSuccess(r),
      ),
    );
  }
}
