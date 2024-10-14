part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkEvent {}

 class BookmarkAddToBookMarkEvent extends BookmarkEvent{

  final String title;
  final String content;
  final String posterId;
  final String imageUrl;
  final List<String> topics;

  BookmarkAddToBookMarkEvent(this.title, this.content, this.posterId, this.imageUrl, this.topics);
}
