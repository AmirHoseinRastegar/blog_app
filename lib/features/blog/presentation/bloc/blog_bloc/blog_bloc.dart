import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecases/upload_blog_usecase.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase uploadBlogUseCase;

  BlogBloc(this.uploadBlogUseCase) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<UploadBlogsEvent>(_uploadBlogs);
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
}
