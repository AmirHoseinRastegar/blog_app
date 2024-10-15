import 'package:bloc/bloc.dart';
import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/use_cases/get_all_bookmarks_usecase.dart';
import '../../domain/use_cases/toggle_bookmark_usecase.dart';

part 'bookmark_event.dart';

part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final ToggleBookmarkUseCase toggleBookmark;
  final GetBookmarksUseCase getBookmarks;

  BookmarkBloc(this.toggleBookmark, this.getBookmarks)
      : super(BookmarkInitial()) {
    on<BookmarkEvent>((event, emit) async {
      if (event is ToggleBookmarkEvent) {
        emit(BookMarkLoading());
        final isBookmarked = toggleBookmark.repository
            .isBookmarked(event.bookMarkEntity.posterId)
            .getOrElse((_) => false);

        final result = isBookmarked
            ? await toggleBookmark.repository
                .removeBookmark(event.bookMarkEntity.posterId)
            : await toggleBookmark.repository.addBookmark(event.bookMarkEntity);
        result.fold(
          (l) => emit(
            BookMarkError(l.message),
          ),
          (_) => emit(
            BookmarkToggled(!isBookmarked),
          ),
        );
      } else if (event is LoadBookmarksEvent) {
        emit(BookMarkLoading());
        final result = await getBookmarks();
        result.fold(
          (l) => emit(
            BookMarkError(l.message),
          ),
          (r) => emit(
            BookMarkLoaded(r),
          ),
        );
      }
    });
  }
}
