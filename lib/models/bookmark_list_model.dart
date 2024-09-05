// To parse this JSON data, do
//
//     final bookmarkListModel = bookmarkListModelFromJson(jsonString);

import 'dart:convert';

Future<BookmarkListModel> bookmarkListModelFromJson(String str) async {
  return BookmarkListModel.fromJson(json.decode(str));
}

String bookmarkListModelToJson(BookmarkListModel data) =>
    json.encode(data.toJson());

class BookmarkListModel {
  BookmarkListModel({
    this.neviim,
    this.torah,
  });

  List<Neviim>? neviim;
  List<Torah>? torah;

  factory BookmarkListModel.fromJson(Map<String, dynamic> json) =>
      BookmarkListModel(
        neviim: json["Neviim"] == null
            ? []
            : List<Neviim>.from(json["Neviim"]!.map((x) => Neviim.fromJson(x))),
        torah: json["Torah"] == null
            ? []
            : List<Torah>.from(json["Torah"]!.map((x) => Torah.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Neviim": neviim == null
            ? []
            : List<dynamic>.from(neviim!.map((x) => x.toJson())),
        "Torah": torah == null
            ? []
            : List<dynamic>.from(torah!.map((x) => x.toJson())),
      };
}

class Neviim {
  Neviim({
    this.bookName,
    this.bookTitle,
    this.chapterName,
    this.chapterTitle,
    this.chapterSubTitle,
    this.subChapter,
    this.chaptersId,
    this.originalAudioFile,
    this.fileUrl,
    this.rootUrl,
    this.guid,
    this.booksId,
    this.isCompleted,
    this.isBookmark,
    this.membersId,
  });

  String? bookName;
  String? bookTitle;
  String? chapterName;
  String? chapterTitle;
  String? chapterSubTitle;
  String? subChapter;
  int? chaptersId;
  String? originalAudioFile;
  String? fileUrl;
  String? rootUrl;
  String? guid;
  int? booksId;
  bool? isCompleted;
  bool? isBookmark;
  int? membersId;

  factory Neviim.fromJson(Map<String, dynamic> json) => Neviim(
        bookName: json["BookName"],
        bookTitle: json["BookTitle"],
        chapterName: json["ChapterName"],
        chapterTitle: json["ChapterTitle"],
        chapterSubTitle: json["ChapterSubTitle"],
        subChapter: json["SubChapter"],
        chaptersId: json["ChaptersId"],
        originalAudioFile: json["OriginalAudioFile"],
        fileUrl: json["FileUrl"],
        rootUrl: json["RootUrl"],
        guid: json["Guid"],
        booksId: json["BooksId"],
        isCompleted: json["IsCompleted"],
        isBookmark: json["IsBookmark"],
        membersId: json["MembersId"],
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
        "MembersId": membersId,
      };
}

class Torah {
  Torah({
    this.bookName,
    this.bookTitle,
    this.chapterName,
    this.chapterTitle,
    this.chapterSubTitle,
    this.subChapter,
    this.chaptersId,
    this.fileUrl,
    this.rootUrl,
    this.isCompleted,
    this.isBookmark,
  });

  String? bookName;
  String? bookTitle;
  String? chapterName;
  String? chapterTitle;
  String? chapterSubTitle;
  String? subChapter;
  int? chaptersId;
  String? fileUrl;
  String? rootUrl;
  bool? isCompleted;
  bool? isBookmark;

  factory Torah.fromJson(Map<String, dynamic> json) => Torah(
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
