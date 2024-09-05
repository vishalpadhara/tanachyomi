// To parse this JSON data, do
//
//     final currentBookStatsModel = currentBookStatsModelFromJson(jsonString);

import 'dart:convert';

CurrentBookStatsModel currentBookStatsModelFromJson(String str) =>
    CurrentBookStatsModel.fromJson(json.decode(str));

String currentBookStatsModelToJson(CurrentBookStatsModel data) =>
    json.encode(data.toJson());

class CurrentBookStatsModel {
  CurrentBookStatsModel({
    this.bookName,
    this.lastDate,
    this.noCompleted,
    this.noMissing,
    this.percentCompleted,
    this.chapterTitle,
    this.chapterId,
  });

  String? bookName;
  String? lastDate;
  int? noCompleted;
  int? noMissing;
  double? percentCompleted;
  String? chapterTitle;
  int? chapterId;

  factory CurrentBookStatsModel.fromJson(Map<String, dynamic> json) =>
      CurrentBookStatsModel(
        bookName: json["BookName"],
        lastDate: json["LastDate"],
        noCompleted: json["NoCompleted"],
        noMissing: json["NoMissing"],
        percentCompleted: json["PercentCompleted"]?.toDouble(),
        chapterTitle: json["ChapterTitle"],
        chapterId: json["ChapterId"],
      );

  Map<String, dynamic> toJson() => {
        "BookName": bookName,
        "LastDate": lastDate,
        "NoCompleted": noCompleted,
        "NoMissing": noMissing,
        "PercentCompleted": percentCompleted,
        "ChapterTitle": chapterTitle,
        "ChapterId": chapterId,
      };
}
