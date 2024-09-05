// To parse this JSON data, do
//
//     final calendarChapterModel = calendarChapterModelFromJson(jsonString);

import 'dart:convert';

CalendarChapterModel calendarChapterModelFromJson(String str) =>
    CalendarChapterModel.fromJson(json.decode(str));

String calendarChapterModelToJson(CalendarChapterModel data) =>
    json.encode(data.toJson());

class CalendarChapterModel {
  int id;
  bool isDeleted;
  String changedOn;
  int tokensIdChangedBy;
  int booksId;
  String bookTitle;
  String name;
  String title;
  String subTitle;
  String subChapter;
  String chapterUrl;
  int filesIdAudio;
  String referenceEnglish;
  String referenceHebrew;
  String rootUrl;
  String fileUrl;
  int previousChaptersId;
  int nextChaptersId;

  CalendarChapterModel({
    required this.id,
    required this.isDeleted,
    required this.changedOn,
    required this.tokensIdChangedBy,
    required this.booksId,
    required this.bookTitle,
    required this.name,
    required this.title,
    required this.subTitle,
    required this.subChapter,
    required this.chapterUrl,
    required this.filesIdAudio,
    required this.referenceEnglish,
    required this.referenceHebrew,
    required this.rootUrl,
    required this.fileUrl,
    required this.previousChaptersId,
    required this.nextChaptersId,
  });

  factory CalendarChapterModel.fromJson(Map<String, dynamic> json) =>
      CalendarChapterModel(
        id: json["Id"] ?? 0,
        isDeleted: json["IsDeleted"] ?? false,
        changedOn: json["ChangedOn"] ?? "",
        tokensIdChangedBy: json["TokensId_ChangedBy"] ?? 0,
        booksId: json["BooksId"] ?? 0,
        bookTitle: json["BookTitle"] ?? "",
        name: json["Name"] ?? "",
        title: json["Title"] ?? "",
        subTitle: json["SubTitle"] ?? "",
        subChapter: json["SubChapter"] ?? "",
        chapterUrl: json["ChapterUrl"] ?? "",
        filesIdAudio: json["FilesId_Audio"] ?? "",
        referenceEnglish: json["ReferenceEnglish"] ?? "",
        referenceHebrew: json["ReferenceHebrew"] ?? "",
        rootUrl: json["RootUrl"] ?? "",
        fileUrl: json["FileUrl"] ?? "",
        previousChaptersId: json["PreviousChaptersId"] ?? 0,
        nextChaptersId: json["NextChaptersId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IsDeleted": isDeleted,
        "ChangedOn": changedOn,
        "TokensId_ChangedBy": tokensIdChangedBy,
        "BooksId": booksId,
        "BookTitle": bookTitle,
        "Name": name,
        "Title": title,
        "SubTitle": subTitle,
        "SubChapter": subChapter,
        "ChapterUrl": chapterUrl,
        "FilesId_Audio": filesIdAudio,
        "ReferenceEnglish": referenceEnglish,
        "ReferenceHebrew": referenceHebrew,
        "RootUrl": rootUrl,
        "FileUrl": fileUrl,
        "PreviousChaptersId": previousChaptersId,
        "NextChaptersId": nextChaptersId,
      };
}
