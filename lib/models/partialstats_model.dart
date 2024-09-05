// To parse this JSON data, do
//
//     final partialStatsModel = partialStatsModelFromJson(jsonString);

import 'dart:convert';

PartialStatsModel partialStatsModelFromJson(String str) =>
    PartialStatsModel.fromJson(json.decode(str));

String partialStatsModelToJson(PartialStatsModel data) =>
    json.encode(data.toJson());

class PartialStatsModel {
  PartialStatsModel({
    this.booksId,
    this.bookName,
    this.noCompleted,
    this.noMissing,
    this.percentCompleted,
  });

  int? booksId;
  String? bookName;
  int? noCompleted;
  int? noMissing;
  double? percentCompleted;

  factory PartialStatsModel.fromJson(Map<String, dynamic> json) =>
      PartialStatsModel(
        booksId: json["BooksId"],
        bookName: json["BookName"],
        noCompleted: json["NoCompleted"],
        noMissing: json["NoMissing"],
        percentCompleted: json["PercentCompleted"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "BooksId": booksId,
        "BookName": bookName,
        "NoCompleted": noCompleted,
        "NoMissing": noMissing,
        "PercentCompleted": percentCompleted,
      };
}
