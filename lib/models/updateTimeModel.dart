import 'dart:convert';

UpdateTimeModel updateTimeModelFromJson(String str) =>
    UpdateTimeModel.fromJson(json.decode(str));

String updateTimeModelToJson(UpdateTimeModel data) =>
    json.encode(data.toJson());

class UpdateTimeModel {
  UpdateTimeModel({
    this.membersId,
    this.chaptersId,
    this.noOfSecondsAudio,
    this.noOfSecondsRead,
  });

  int? membersId;
  int? chaptersId;
  int? noOfSecondsAudio;
  int? noOfSecondsRead;

  factory UpdateTimeModel.fromJson(Map<String, dynamic> json) =>
      UpdateTimeModel(
        membersId: json["MembersId"],
        chaptersId: json["ChaptersId"],
        noOfSecondsAudio: json["NoOfSecondsAudio"],
        noOfSecondsRead: json["NoOfSecondsRead"],
      );

  Map<String, dynamic> toJson() => {
        "MembersId": membersId,
        "ChaptersId": chaptersId,
        "NoOfSecondsAudio": noOfSecondsAudio,
        "NoOfSecondsRead": noOfSecondsRead,
      };
}
