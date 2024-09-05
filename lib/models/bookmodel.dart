// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

List<BookModel> bookModelFromJson(String str) =>
    List<BookModel>.from(json.decode(str).map((x) => BookModel.fromJson(x)));

String bookModelToJson(List<BookModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookModel {
  BookModel({
    required this.id,
    required this.isDeleted,
    required this.changedOn,
    required this.tokensIdChangedBy,
    required this.name,
    required this.typeOfBook,
    required this.title,
  });

  int id;
  bool isDeleted;
  String changedOn;
  int tokensIdChangedBy;
  String name;
  String typeOfBook;
  String title;

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["Id"] ?? 0,
        isDeleted: json["IsDeleted"] ?? false,
        changedOn: json["ChangedOn"] ?? "",
        tokensIdChangedBy: json["TokensId_ChangedBy"] ?? 0,
        name: json["Name"] ?? "",
        typeOfBook: json["TypeOfBook"] ?? "",
        title: json["Title"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IsDeleted": isDeleted,
        "ChangedOn": changedOn,
        "TokensId_ChangedBy": tokensIdChangedBy,
        "Name": name,
        "Title": title,
        "TypeOfBook": typeOfBook,
      };
}
