import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/blog/domain/entites/blog_entity.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../domain/use_cases/add_to_bookmark_usecase.dart';

part 'bookmark_event.dart';

part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final AddToBookMarksUseCase addToBookMarksUseCase;

  BookmarkBloc(this.addToBookMarksUseCase) : super(BookmarkInitial()) {
    on<BookmarkAddToBookMarkEvent>((event, emit) async {
      emit(BookmarkLoading());

      final bookmark = await addToBookMarksUseCase.call(AddToBookMarksParams(
        event.title,
        event.content,
        event.posterId,
        event.imageUrl,
        event.topics,
      ));
      bookmark.fold(
        (l) => emit(BookmarkError(l.message)),
        (r) => emit(BookmarkLoaded(r)),
      );
    });
  }
}
