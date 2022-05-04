// To parse this JSON data, do
//
//     final bookListModel = bookListModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'book_list_model.g.dart';

BookListModel? bookListModelFromJson(String? str) {
  try {
    return BookListModel.fromJson(json.decode(str!));
  } on Exception catch (e) {
    print('json decode error -$e');
    return null;
  }
}

String bookListModelToJson(BookListModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class BookListModel {
  BookListModel({
    this.output,
  });

  @HiveField(0)
  Output? output;

  factory BookListModel.fromJson(Map<String, dynamic> json) => BookListModel(
        output: json["output"] == null ? null : Output.fromJson(json["output"]),
      );

  Map<String, dynamic> toJson() => {
        "output": output == null ? null : output!.toJson(),
      };
}

@HiveType(typeId: 1)
class Output {
  Output({
    this.result,
  });

  @HiveField(0)
  Result? result;

  factory Output.fromJson(Map<String, dynamic> json) => Output(
        result: json["Result"] == null ? null : Result.fromJson(json["Result"]),
      );

  Map<String, dynamic> toJson() => {
        "Result": result == null ? null : result!.toJson(),
      };
}

@HiveType(typeId: 2)
class Result {
  Result({
    this.status,
    this.bookDet,
  });

  @HiveField(0)
  String? status;

  @HiveField(1)
  List<BookDet>? bookDet;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"] == null ? null : json["status"],
        bookDet: json["BookDet"] == null
            ? []
            : List<BookDet>.from(
                json["BookDet"].map((x) => BookDet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "BookDet": bookDet == null
            ? null
            : List<dynamic>.from(bookDet!.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 3)
class BookDet {
  BookDet({
    this.id,
    this.contentType,
    this.contentCode,
    this.name,
    this.imagePath,
    this.fileType,
    this.status,
  });

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? contentType;

  @HiveField(2)
  String? contentCode;

  @HiveField(3)
  String? name;

  @HiveField(4)
  String? imagePath;

  @HiveField(5)
  String? fileType;

  @HiveField(6)
  String? status;

  factory BookDet.fromJson(Map<String, dynamic> json) => BookDet(
        id: json["id"] == null ? null : json["id"],
        contentType: json["content_type"] == null ? '' : json["content_type"],
        contentCode: json["content_code"] == null ? '' : json["content_code"],
        name: json["name"] == null ? null : json["name"],
        imagePath: json["image_path"] == null ? null : json["image_path"],
        fileType: json["file_type"] == null ? null : json["file_type"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "content_type": contentType == null ? null : contentType,
        "content_code": contentCode == null ? null : contentCode,
        "name": name == null ? null : name,
        "image_path": imagePath == null ? null : imagePath,
        "file_type": fileType == null ? null : fileType,
        "status": status == null ? null : status,
      };
}
