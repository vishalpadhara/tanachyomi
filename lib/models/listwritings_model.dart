// To parse this JSON data, do
//
//     final listTorahModel = listTorahModelFromJson(jsonString);

import 'dart:convert';

ListWritingsModel listTorahModelFromJson(String str) =>
    ListWritingsModel.fromJson(json.decode(str));

String listTorahModelToJson(ListWritingsModel data) =>
    json.encode(data.toJson());

class ListWritingsModel {
  ListWritingsModel({
    this.id,
    this.name,
    this.title,
    this.typeOfBook,
  });

  int? id;
  String? name;
  String? title;
  String? typeOfBook;

  factory ListWritingsModel.fromJson(Map<String, dynamic> json) =>
      ListWritingsModel(
        id: json["Id"],
        name: json["Name"],
        title: json["Title"],
        typeOfBook: json["TypeOfBook"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Title": title,
        "TypeOfBook": typeOfBook,
      };
}
