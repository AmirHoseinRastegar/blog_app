import '../../domain/entities/bookmark_entity.dart';

class BookMarkModel extends BookMarkEntity {
  BookMarkModel(
      {required super.title,
      required super.id,
      required super.posterId,
      required super.content,
      required super.imageUrl,
      required super.topics,
      required super.updatedAt});
}
