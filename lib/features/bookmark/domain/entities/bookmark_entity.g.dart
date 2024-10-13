// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookMarkEntityAdapter extends TypeAdapter<BookMarkEntity> {
  @override
  final int typeId = 1;

  @override
  BookMarkEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookMarkEntity(
      title: fields[0] as String,
      id: fields[1] as String,
      posterId: fields[2] as String,
      content: fields[3] as String,
      imageUrl: fields[4] as String,
      topics: (fields[5] as List).cast<String>(),
      updatedAt: fields[6] as DateTime,
      name: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookMarkEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.posterId)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.topics)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookMarkEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
