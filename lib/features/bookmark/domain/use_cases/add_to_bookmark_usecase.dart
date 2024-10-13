import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/interface_usecase.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:blog_app/features/bookmark/domain/repository/bookmark_repository.dart';
import 'package:fpdart/src/either.dart';

class AddToBookMarksUseCase
    implements UseCase<BlogEntity, AddToBookMarksParams> {
  final BookmarkRepository repository;

  AddToBookMarksUseCase(this.repository);

  @override
  Future<Either<Failure, BlogEntity>> call(params) {
    return repository.addBookmark(
        posterId: params.posterId,
        title: params.title,
        content: params.content,
        image: params.image,
        topics: params.topics);
  }
}

class AddToBookMarksParams {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;

  AddToBookMarksParams(
      this.title, this.content, this.posterId, this.image, this.topics);
}
