// To parse this JSON data, do
//
//     final listTorahModel = listTorahModelFromJson(jsonString);

import 'dart:convert';

ListProphetsModel listTorahModelFromJson(String str) =>
    ListProphetsModel.fromJson(json.decode(str));

String listTorahModelToJson(ListProphetsModel data) =>
    json.encode(data.toJson());

class ListProphetsModel {
  ListProphetsModel({
    this.id,
    this.name,
    this.title,
    this.typeOfBook,
  });

  int? id;
  String? name;
  String? title;
  String? typeOfBook;

  factory ListProphetsModel.fromJson(Map<String, dynamic> json) =>
      ListProphetsModel(
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
