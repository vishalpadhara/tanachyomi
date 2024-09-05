// To parse this JSON data, do
//
//     final dailyChartModel = dailyChartModelFromJson(jsonString);

import 'dart:convert';

DailyChartModel dailyChartModelFromJson(String str) =>
    DailyChartModel.fromJson(json.decode(str));

String dailyChartModelToJson(DailyChartModel data) =>
    json.encode(data.toJson());

class DailyChartModel {
  DailyChartModel({
    this.studyDate,
    this.noOfMinutesAudio,
    this.noOfMinutesRead,
  });

  String? studyDate;
  int? noOfMinutesAudio;
  int? noOfMinutesRead;

  factory DailyChartModel.fromJson(Map<String, dynamic> json) =>
      DailyChartModel(
        studyDate: json["StudyDate"],
        noOfMinutesAudio: json["NoOfMinutesAudio"],
        noOfMinutesRead: json["NoOfMinutesRead"],
      );

  Map<String, dynamic> toJson() => {
        "StudyDate": studyDate,
        "NoOfMinutesAudio": noOfMinutesAudio,
        "NoOfMinutesRead": noOfMinutesRead,
      };
}
