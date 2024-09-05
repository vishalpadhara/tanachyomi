// To parse this JSON data, do
//
//     final listTorahModel = listTorahModelFromJson(jsonString);

import 'dart:convert';

ListHaftorahBookModel listTorahModelFromJson(String str) =>
    ListHaftorahBookModel.fromJson(json.decode(str));

String listTorahModelToJson(ListHaftorahBookModel data) =>
    json.encode(data.toJson());

class ListHaftorahBookModel {
  ListHaftorahBookModel({
    this.id,
    this.name,
    this.title,
    this.typeOfBook,
  });

  int? id;
  String? name;
  String? title;
  String? typeOfBook;

  factory ListHaftorahBookModel.fromJson(Map<String, dynamic> json) =>
      ListHaftorahBookModel(
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
