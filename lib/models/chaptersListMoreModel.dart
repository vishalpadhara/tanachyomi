// To parse this JSON data, do
//
//     final chaptersListMoreModel = chaptersListMoreModelFromJson(jsonString);

import 'dart:convert';

ChaptersListMoreModel chaptersListMoreModelFromJson(String str) =>
    ChaptersListMoreModel.fromJson(json.decode(str));

String chaptersListMoreModelToJson(ChaptersListMoreModel data) =>
    json.encode(data.toJson());

class ChaptersListMoreModel {
  int chaptersId;
  String typeOfResource;
  String title;
  String subTitle;
  String urlLink;

  ChaptersListMoreModel({
    required this.chaptersId,
    required this.typeOfResource,
    required this.title,
    required this.subTitle,
    required this.urlLink,
  });

  factory ChaptersListMoreModel.fromJson(Map<String, dynamic> json) =>
      ChaptersListMoreModel(
        chaptersId: json["ChaptersId"],
        typeOfResource: json["TypeOfResource"],
        title: json["Title"],
        subTitle: json["SubTitle"],
        urlLink: json["UrlLink"],
      );

  Map<String, dynamic> toJson() => {
        "ChaptersId": chaptersId,
        "TypeOfResource": typeOfResource,
        "Title": title,
        "SubTitle": subTitle,
        "UrlLink": urlLink,
      };
}
