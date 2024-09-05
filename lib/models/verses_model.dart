// To parse this JSON data, do
//
//     final parashaListOfBookModel = parashaListOfBookModelFromJson(jsonString);

import 'dart:convert';

VersesModel parashaListOfBookModelFromJson(String str) =>
    VersesModel.fromJson(json.decode(str));

String parashaListOfBookModelToJson(VersesModel data) =>
    json.encode(data.toJson());

class VersesModel {
  VersesModel({
    required this.versesId,
    required this.name,
    required this.name1,
    required this.title,
    required this.subTitle,
    required this.chapterNo,
    required this.verseNo,
    required this.verseEnglish,
    required this.verseHebrew,
  });

  int versesId;
  String name;
  String name1;
  String title;
  String subTitle;
  int chapterNo;
  int verseNo;
  String verseEnglish;
  String verseHebrew;

  factory VersesModel.fromJson(Map<String, dynamic> json) => VersesModel(
        versesId: json["VersesId"],
        name: json["Name"],
        name1: json["Name1"],
        title: json["Title"],
        subTitle: json["SubTitle"],
        chapterNo: json["ChapterNo"],
        verseNo: json["VerseNo"],
        verseEnglish: json["VerseEnglish"],
        verseHebrew: json["VerseHebrew"],
      );

  Map<String, dynamic> toJson() => {
        "VersesId": versesId,
        "Name": name,
        "Name1": name1,
        "Title": title,
        "SubTitle": subTitle,
        "ChapterNo": chapterNo,
        "VerseNo": verseNo,
        "VerseEnglish": verseEnglish,
        "VerseHebrew": verseHebrew,
      };
}
