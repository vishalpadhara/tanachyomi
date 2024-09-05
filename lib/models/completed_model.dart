// To parse this JSON data, do
//
//     final updateTimeModel = updateTimeModelFromJson(jsonString);

import 'dart:convert';

CompletedModel completedModelFromJson(String str) =>
    CompletedModel.fromJson(json.decode(str));

String completedModelToJson(CompletedModel data) => json.encode(data.toJson());

class CompletedModel {
  CompletedModel({this.membersId, this.chaptersId});

  int? membersId;
  int? chaptersId;

  factory CompletedModel.fromJson(Map<String, dynamic> json) => CompletedModel(
      membersId: json["MembersId"], chaptersId: json["ChaptersId"]);

  Map<String, dynamic> toJson() =>
      {"MembersId": membersId, "ChaptersId": chaptersId};
}
