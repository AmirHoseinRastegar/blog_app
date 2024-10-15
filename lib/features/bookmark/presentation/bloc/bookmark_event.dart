part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkEvent {}


class ToggleBookmarkEvent extends BookmarkEvent {
  final BookMarkEntity bookMarkEntity;
  ToggleBookmarkEvent(this.bookMarkEntity);
}

class LoadBookmarksEvent extends BookmarkEvent {}