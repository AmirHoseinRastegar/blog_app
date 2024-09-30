part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class GetAllBlogsEvent extends BlogEvent {}

class UploadBlogsEvent extends BlogEvent {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;

  UploadBlogsEvent(
      {required this.title,
        required this.content,
        required this.posterId,
        required this.image,
        required this.topics});
}

class DeleteBlogEvent extends BlogEvent {}
