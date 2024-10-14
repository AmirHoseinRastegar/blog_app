part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkState {}

final class BookmarkInitial extends BookmarkState {}

final class BookmarkLoading extends BookmarkState {}

final class BookmarkLoaded extends BookmarkState {

  final BlogEntity bookmark;

  BookmarkLoaded(this.bookmark);
}

final class BookmarkError extends BookmarkState {

  final String message;

  BookmarkError(this.message);
}
