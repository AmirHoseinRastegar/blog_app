import 'package:hive_flutter/adapters.dart';
part'blog_entity.g.dart';
@HiveType(typeId: 0)
class BlogEntity {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String posterId;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final String imageUrl;
  @HiveField(5)
  final List<String> topics;
  @HiveField(6)
  final DateTime updatedAt;
  @HiveField(7)
  final String? name;

  BlogEntity(
      {required this.title,
      required this.id,
      required this.posterId,
      required this.content,
      required this.imageUrl,
      required this.topics,
      required this.updatedAt,
      this.name});
}
