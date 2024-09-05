// To parse this JSON data, do
//
//     final calendarStatsModel = calendarStatsModelFromJson(jsonString);

import 'dart:convert';

CalendarStatsModel calendarStatsModelFromJson(String str) =>
    CalendarStatsModel.fromJson(json.decode(str));

String calendarStatsModelToJson(CalendarStatsModel data) =>
    json.encode(data.toJson());

class CalendarStatsModel {
  String dateLearning;
  int learningTime;
  int audioTime;

  CalendarStatsModel({
    required this.dateLearning,
    required this.learningTime,
    required this.audioTime,
  });

  factory CalendarStatsModel.fromJson(Map<String, dynamic> json) =>
      CalendarStatsModel(
        dateLearning: json["DateLearning"],
        learningTime: json["LearningTime"],
        audioTime: json["AudioTime"],
      );

  Map<String, dynamic> toJson() => {
        "DateLearning": dateLearning,
        "LearningTime": learningTime,
        "AudioTime": audioTime,
      };
}
