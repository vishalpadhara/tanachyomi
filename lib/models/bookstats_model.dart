// To parse this JSON data, do
//
//     final bookStatsModel = bookStatsModelFromJson(jsonString);

import 'dart:convert';

BookStatsModel bookStatsModelFromJson(String str) =>
    BookStatsModel.fromJson(json.decode(str));

String bookStatsModelToJson(BookStatsModel data) => json.encode(data.toJson());

class BookStatsModel {
  BookStatsModel({
    this.typeOfBook,
    this.noCompleted,
    this.noMissing,
    this.noTotal,
    this.percentCompleted,
  });

  String? typeOfBook;
  int? noCompleted;
  int? noMissing;
  int? noTotal;
  int? percentCompleted;

  factory BookStatsModel.fromJson(Map<String, dynamic> json) => BookStatsModel(
        typeOfBook: json["TypeOfBook"],
        noCompleted: json["NoCompleted"],
        noMissing: json["NoMissing"],
        noTotal: json["NoTotal"],
        percentCompleted: json["PercentCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "TypeOfBook": typeOfBook,
        "NoCompleted": noCompleted,
        "NoMissing": noMissing,
        "NoTotal": noTotal,
        "PercentCompleted": percentCompleted,
      };
}
