// To parse this JSON data, do
//
//     final torahModel = torahModelFromJson(jsonString);

import 'dart:convert';

TorahModel torahModelFromJson(String str) =>
    TorahModel.fromJson(json.decode(str));

String torahModelToJson(TorahModel data) => json.encode(data.toJson());

class TorahModel {
  TorahModel({
    this.booksId,
    this.bookName,
    this.noCompleted,
    this.noMissing,
    this.noTotal,
    this.percentCompleted,
  });

  int? booksId;
  String? bookName;
  int? noCompleted;
  int? noMissing;
  int? noTotal;
  int? percentCompleted;

  factory TorahModel.fromJson(Map<String, dynamic> json) => TorahModel(
        booksId: json["BooksId"],
        bookName: json["BookName"],
        noCompleted: json["NoCompleted"],
        noMissing: json["NoMissing"],
        noTotal: json["NoTotal"],
        percentCompleted: json["PercentCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "BooksId": booksId,
        "BookName": bookName,
        "NoCompleted": noCompleted,
        "NoMissing": noMissing,
        "NoTotal": noTotal,
        "PercentCompleted": percentCompleted,
      };
}
