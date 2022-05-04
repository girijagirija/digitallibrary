// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookListModelAdapter extends TypeAdapter<BookListModel> {
  @override
  final int typeId = 0;

  @override
  BookListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookListModel(
      output: fields[0] as Output?,
    );
  }

  @override
  void write(BinaryWriter writer, BookListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.output);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OutputAdapter extends TypeAdapter<Output> {
  @override
  final int typeId = 1;

  @override
  Output read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Output(
      result: fields[0] as Result?,
    );
  }

  @override
  void write(BinaryWriter writer, Output obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutputAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResultAdapter extends TypeAdapter<Result> {
  @override
  final int typeId = 2;

  @override
  Result read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Result(
      status: fields[0] as String?,
      bookDet: (fields[1] as List?)?.cast<BookDet>(),
    );
  }

  @override
  void write(BinaryWriter writer, Result obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.bookDet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BookDetAdapter extends TypeAdapter<BookDet> {
  @override
  final int typeId = 3;

  @override
  BookDet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookDet(
      id: fields[0] as String?,
      contentType: fields[1] as String?,
      contentCode: fields[2] as String?,
      name: fields[3] as String?,
      imagePath: fields[4] as String?,
      fileType: fields[5] as String?,
      status: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BookDet obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.contentType)
      ..writeByte(2)
      ..write(obj.contentCode)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.fileType)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookDetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
