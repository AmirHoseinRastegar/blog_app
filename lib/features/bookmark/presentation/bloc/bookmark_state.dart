part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkState extends Equatable {}

final class BookmarkInitial extends BookmarkState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class BookMarkLoading extends BookmarkState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class BookMarkLoaded extends BookmarkState {
  final List<BookMarkEntity> bookmarks;

  BookMarkLoaded(this.bookmarks);

  @override
  // TODO: implement props
  List<Object?> get props => [bookmarks];
}

class BookmarkToggled extends BookmarkState {
  final bool isBookmarked;

  BookmarkToggled(this.isBookmarked);

  @override
  // TODO: implement props
  List<Object?> get props => [isBookmarked];
}

final class BookMarkError extends BookmarkState {
  final String message;

  BookMarkError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
