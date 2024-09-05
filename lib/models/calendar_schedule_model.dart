// To parse this JSON data, do
//
//     final calendarScheduleModel = calendarScheduleModelFromJson(jsonString);

import 'dart:convert';

CalendarScheduleModel calendarScheduleModelFromJson(String str) =>
    CalendarScheduleModel.fromJson(json.decode(str));

String calendarScheduleModelToJson(CalendarScheduleModel data) =>
    json.encode(data.toJson());

class CalendarScheduleModel {
  int chaptersId;
  int indexNo;
  String studyScheduleDate;
  String title;
  String subChapter;
  int previousChaptersId;
  int nextChaptersId;
  bool isStarted;
  bool isCompleted;

  CalendarScheduleModel({
    required this.chaptersId,
    required this.indexNo,
    required this.studyScheduleDate,
    required this.title,
    required this.subChapter,
    required this.previousChaptersId,
    required this.nextChaptersId,
    required this.isStarted,
    required this.isCompleted,
  });

  factory CalendarScheduleModel.fromJson(Map<String, dynamic> json) =>
      CalendarScheduleModel(
        chaptersId: json["ChaptersId"] ?? 0,
        indexNo: json["IndexNo"] ?? 0,
        studyScheduleDate: json["StudyScheduleDate"] ?? "",
        title: json["Title"] ?? "",
        subChapter: json["SubChapter"] ?? "",
        previousChaptersId: json["PreviousChaptersId"] ?? 0,
        nextChaptersId: json["NextChaptersId"],
        isStarted: json["IsStarted"] ?? false,
        isCompleted: json["IsCompleted"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "ChaptersId": chaptersId,
        "IndexNo": indexNo,
        "StudyScheduleDate": studyScheduleDate,
        "Title": title,
        "SubChapter": subChapter,
        "PreviousChaptersId": previousChaptersId,
        "NextChaptersId": nextChaptersId,
        "IsStarted": isStarted,
        "IsCompleted": isCompleted,
      };
}
