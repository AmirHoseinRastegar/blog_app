import 'package:hive_flutter/adapters.dart';

part 'bookmark_entity.g.dart';

@HiveType(typeId: 1)
class BookMarkEntity {
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

  BookMarkEntity(
      {required this.title,
      required this.id,
      required this.posterId,
      required this.content,
      required this.imageUrl,
      required this.topics,
      required this.updatedAt,
      this.name});

}
