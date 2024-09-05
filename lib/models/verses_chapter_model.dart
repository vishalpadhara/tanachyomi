// To parse this JSON data, do
//
//     final chapterModel = chapterModelFromJson(jsonString);

import 'dart:convert';

List<ChapterModel> chapterModelFromJson(String str) {
  return List<ChapterModel>.from(
      json.decode(str).map((x) => ChapterModel.fromJson(x)));
}

String chapterModelToJson(List<ChapterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChapterModel {
  ChapterModel({
    required this.id,
    required this.isDeleted,
    required this.changedOn,
    required this.tokensIdChangedBy,
    required this.booksId,
    required this.name,
    required this.subChapter,
    required this.chapterUrl,
    required this.filesIdAudio,
    required this.referenceEnglish,
    required this.referenceHebrew,
    required this.fileUrl,
    required this.rootUrl,
    required this.subTitle,
    required this.previousChaptersId,
    required this.nextChaptersId,
  });

  int id;
  bool isDeleted;
  String changedOn;
  int tokensIdChangedBy;
  int booksId;
  String name;
  String subChapter;
  String chapterUrl;
  int filesIdAudio;
  String referenceEnglish;
  String referenceHebrew;
  String fileUrl;
  String rootUrl;
  String subTitle;
  int previousChaptersId;
  int nextChaptersId;

  factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
        id: json["Id"],
        isDeleted: json["IsDeleted"],
        changedOn: json["ChangedOn"],
        tokensIdChangedBy: json["TokensId_ChangedBy"],
        booksId: json["BooksId"],
        name: json["Name"],
        subChapter: json["SubChapter"],
        chapterUrl: json["ChapterUrl"],
        filesIdAudio: json["FilesId_Audio"],
        referenceEnglish: json["ReferenceEnglish"],
        referenceHebrew: json["ReferenceHebrew"],
        fileUrl: json["FileUrl"],
        rootUrl: json["RootUrl"],
        subTitle: json["SubTitle"],
        previousChaptersId: json["PreviousChaptersId"],
        nextChaptersId: json["NextChaptersId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IsDeleted": isDeleted,
        "ChangedOn": changedOn,
        "TokensId_ChangedBy": tokensIdChangedBy,
        "BooksId": booksId,
        "Name": name,
        "SubChapter": subChapter,
        "ChapterUrl": chapterUrl,
        "FilesId_Audio": filesIdAudio,
        "ReferenceEnglish": referenceEnglish,
        "ReferenceHebrew": referenceHebrew,
        "FileUrl": fileUrl,
        "RootUrl": rootUrl,
        "SubTitle": subTitle,
        "PreviousChaptersId": previousChaptersId,
        "NextChaptersId": nextChaptersId,
      };
}
