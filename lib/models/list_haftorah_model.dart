// To parse this JSON data, do
//
//     final listHaftorahModel = listHaftorahModelFromJson(jsonString);

import 'dart:convert';

ListHaftorahModel listHaftorahModelFromJson(String str) =>
    ListHaftorahModel.fromJson(json.decode(str));

String listHaftorahModelToJson(ListHaftorahModel data) =>
    json.encode(data.toJson());

class ListHaftorahModel {
  ListHaftorahModel({
    this.booksId,
    this.membersId,
  });

  String? booksId;
  String? membersId;

  factory ListHaftorahModel.fromJson(Map<String, dynamic> json) =>
      ListHaftorahModel(
        booksId: json["BooksId"],
        membersId: json["MembersId"],
      );

  Map<String, dynamic> toJson() => {
        "BooksId": booksId,
        "MembersId": membersId,
      };
}
