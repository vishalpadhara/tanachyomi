// To parse this JSON data, do
//
//     final listOfChaptersModel = listOfChaptersModelFromJson(jsonString);

import 'dart:convert';

List<ListOfChaptersModel> listOfChaptersModelFromJson(String str) =>
    List<ListOfChaptersModel>.from(
        json.decode(str).map((x) => ListOfChaptersModel.fromJson(x)));

String listOfChaptersModelToJson(List<ListOfChaptersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListOfChaptersModel {
  ListOfChaptersModel({
    required this.bookName,
    required this.bookTitle,
    required this.chapterName,
    required this.chapterTitle,
    required this.chapterSubTitle,
    required this.subChapter,
    required this.chaptersId,
    required this.originalAudioFile,
    required this.fileUrl,
    required this.rootUrl,
    required this.guid,
    required this.booksId,
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
  String originalAudioFile;
  String fileUrl;
  String rootUrl;
  String guid;
  int booksId;
  bool isCompleted;
  bool isBookmark;

  factory ListOfChaptersModel.fromJson(Map<String, dynamic> json) =>
      ListOfChaptersModel(
        bookName: json["BookName"] ?? "",
        bookTitle: json["BookTitle"] ?? "",
        chapterName: json["ChapterName"] ?? "",
        chapterTitle: json["ChapterTitle"] ?? "",
        chapterSubTitle: json["ChapterSubTitle"] ?? "",
        subChapter: json["SubChapter"] ?? "",
        chaptersId: json["ChaptersId"] ?? 0,
        originalAudioFile: json["OriginalAudioFile"] ?? "",
        fileUrl: json["FileUrl"] ?? "",
        rootUrl: json["RootUrl"] ?? "",
        guid: json["Guid"] ?? "",
        booksId: json["BooksId"] ?? 0,
        isCompleted: json["IsCompleted"] ?? false,
        isBookmark: json["IsBookmark"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "BookName": bookName,
        "BookTitle": bookTitle,
        "ChapterName": chapterName,
        "ChapterTitle": chapterTitle,
        "ChapterSubTitle": chapterSubTitle,
        "SubChapter": subChapter,
        "ChaptersId": chaptersId,
        "OriginalAudioFile": originalAudioFile,
        "FileUrl": fileUrl,
        "RootUrl": rootUrl,
        "Guid": guid,
        "BooksId": booksId,
        "IsCompleted": isCompleted,
        "IsBookmark": isBookmark,
      };
}
