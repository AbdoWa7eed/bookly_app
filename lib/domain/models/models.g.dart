// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookInfoModelAdapter extends TypeAdapter<BookInfoModel> {
  @override
  final int typeId = 0;

  @override
  BookInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookInfoModel(
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as double,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BookInfoModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.averageRating)
      ..writeByte(5)
      ..write(obj.language)
      ..writeByte(6)
      ..write(obj.imageLink)
      ..writeByte(7)
      ..write(obj.previewLink)
      ..writeByte(8)
      ..write(obj.pageCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
