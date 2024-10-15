part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkState {}

final class BookmarkInitial extends BookmarkState {}

final class BookMarkLoading extends BookmarkState {}

final class BookMarkLoaded extends BookmarkState {
  final List<BookMarkEntity> bookmarks;

  BookMarkLoaded(this.bookmarks);
}

final class BookMarkError extends BookmarkState {
  final String message;

  BookMarkError(this.message);
}
