// To parse this JSON data, do
//
//     final achievementsStudyModel = achievementsStudyModelFromJson(jsonString);

import 'dart:convert';

List<AchievementsStudyModel> achievementsStudyModelFromJson(String str) =>
    List<AchievementsStudyModel>.from(
        json.decode(str).map((x) => AchievementsStudyModel.fromJson(x)));

String achievementsStudyModelToJson(List<AchievementsStudyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AchievementsStudyModel {
  AchievementsStudyModel({
    required this.typeOfBook,
    required this.bookName,
    required this.noTotal,
  });

  String typeOfBook;
  String bookName;
  int noTotal;

  factory AchievementsStudyModel.fromJson(Map<String, dynamic> json) =>
      AchievementsStudyModel(
        typeOfBook: json["TypeOfBook"],
        bookName: json["BookName"],
        noTotal: json["NoTotal"],
      );

  Map<String, dynamic> toJson() => {
        "TypeOfBook": typeOfBook,
        "BookName": bookName,
        "NoTotal": noTotal,
      };
}
