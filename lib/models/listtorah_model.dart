// To parse this JSON data, do
//
//     final listTorahModel = listTorahModelFromJson(jsonString);

import 'dart:convert';

ListTorahModel listTorahModelFromJson(String str) =>
    ListTorahModel.fromJson(json.decode(str));

String listTorahModelToJson(ListTorahModel data) => json.encode(data.toJson());

class ListTorahModel {
  ListTorahModel({
    this.id,
    this.name,
    this.title,
    this.typeOfBook,
  });

  int? id;
  String? name;
  String? title;
  String? typeOfBook;

  factory ListTorahModel.fromJson(Map<String, dynamic> json) => ListTorahModel(
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
