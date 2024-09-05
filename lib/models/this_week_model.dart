// To parse this JSON data, do
//
//     final HomeScreenModel = HomeScreenModelFromJson(jsonString);

import 'dart:convert';

List<ThisWeekModel> HomeScreenModelFromJson(String str) =>
    List<ThisWeekModel>.from(
        json.decode(str).map((x) => ThisWeekModel.fromJson(x)));

String HomeScreenModelToJson(List<ThisWeekModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ThisWeekModel {
  ThisWeekModel({
    required this.bookName,
    required this.bookTitle,
    required this.chapterName,
    required this.chapterTitle,
    required this.chapterSubTitle,
    required this.subChapter,
    required this.chaptersId,
    required this.fileUrl,
    required this.rootUrl,
    required this.isCompleted,
    required this.isBookmark,
  });

  String bookName;
  String bookTitle;
  String chapterName;
  String chapterTitle;
  String chapterSubTitle;
  String subChapter;
  int chaptersId;
  String fileUrl;
  String rootUrl;
  bool isCompleted;
  bool isBookmark;

  factory ThisWeekModel.fromJson(Map<String, dynamic> json) => ThisWeekModel(
        bookName: json["BookName"],
        bookTitle: json["BookTitle"],
        chapterName: json["ChapterName"],
        chapterTitle: json["ChapterTitle"],
        chapterSubTitle: json["ChapterSubTitle"],
        subChapter: json["SubChapter"],
        chaptersId: json["ChaptersId"],
        fileUrl: json["FileUrl"],
        rootUrl: json["RootUrl"],
        isCompleted: json["IsCompleted"],
        isBookmark: json["IsBookmark"],
      );

  Map<String, dynamic> toJson() => {
        "BookName": bookName,
        "BookTitle": bookTitle,
        "ChapterName": chapterName,
        "ChapterTitle": chapterTitle,
        "ChapterSubTitle": chapterSubTitle,
        "SubChapter": subChapter,
        "ChaptersId": chaptersId,
        "FileUrl": fileUrl,
        "RootUrl": rootUrl,
        "IsCompleted": isCompleted,
        "IsBookmark": isBookmark,
      };
}
