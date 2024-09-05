// To parse this JSON data, do
//
//     final dashboardAllModel = dashboardAllModelFromJson(jsonString);

import 'dart:convert';

import 'package:tanachyomi/models/partialstats_model.dart';
import 'package:tanachyomi/models/torahmodel.dart';

import 'achievementsStudyModel.dart';
import 'dailychartmodel.dart';

DashboardAllModel dashboardAllModelFromJson(String str) =>
    DashboardAllModel.fromJson(json.decode(str));

String dashboardAllModelToJson(DashboardAllModel data) =>
    json.encode(data.toJson());

class DashboardAllModel {
  DashboardAllModel({
    this.achievementsAliyas,
    this.bookStats,
    this.currentBookStats,
    this.dailyChart,
    this.partialStats,
    this.torah,
    this.achievementsStudyModel,
  });

  List<dynamic>? achievementsAliyas;
  List<BookStat>? bookStats;
  List<CurrentBookStat>? currentBookStats;
  List<DailyChartModel>? dailyChart;
  List<PartialStatsModel>? partialStats;
  List<TorahModel>? torah;
  List<AchievementsStudyModel>? achievementsStudyModel;

  factory DashboardAllModel.fromJson(Map<String, dynamic> json) =>
      DashboardAllModel(
        achievementsAliyas: json["AchievementsAliyas"] == null
            ? []
            : List<dynamic>.from(json["AchievementsAliyas"]!.map((x) => x)),
        bookStats: json["BookStats"] == null
            ? []
            : List<BookStat>.from(
                json["BookStats"]!.map((x) => BookStat.fromJson(x))),
        currentBookStats: json["CurrentBookStats"] == null
            ? []
            : List<CurrentBookStat>.from(json["CurrentBookStats"]!
                .map((x) => CurrentBookStat.fromJson(x))),
        dailyChart: json["DailyChart"] == null
            ? []
            : List<DailyChartModel>.from(
                json["BookStats"]!.map((x) => DailyChartModel.fromJson(x))),
        partialStats: json["PartialStats"] == null
            ? []
            : List<PartialStatsModel>.from(json["PartialStats"]!
                .map((x) => PartialStatsModel.fromJson(x))),
        torah: json["Torah"] == null
            ? []
            : List<TorahModel>.from(
                json["Torah"]!.map((x) => TorahModel.fromJson(x))),
        achievementsStudyModel: json["AchievementsStudy"] == null
            ? []
            : List<AchievementsStudyModel>.from(json["AchievementsStudy"]!
                .map((x) => AchievementsStudyModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "AchievementsAliyas": achievementsAliyas == null
            ? []
            : List<dynamic>.from(achievementsAliyas!.map((x) => x)),
        "BookStats": bookStats == null
            ? []
            : List<dynamic>.from(bookStats!.map((x) => x.toJson())),
        "CurrentBookStats": currentBookStats == null
            ? []
            : List<dynamic>.from(currentBookStats!.map((x) => x.toJson())),
        "DailyChart": dailyChart == null
            ? []
            : List<dynamic>.from(dailyChart!.map((x) => x)),
        "PartialStats": partialStats == null
            ? []
            : List<dynamic>.from(partialStats!.map((x) => x.toJson())),
        "Torah": torah == null
            ? []
            : List<dynamic>.from(torah!.map((x) => x.toJson())),
        "AchievementsStudy": achievementsStudyModel == null
            ? []
            : List<dynamic>.from(
                achievementsStudyModel!.map((x) => x.toJson())),
      };
}

class BookStat {
  BookStat({
    this.typeOfBook,
    this.noCompleted,
    this.noMissing,
    this.noTotal,
    this.percentCompleted,
  });

  String? typeOfBook;
  int? noCompleted;
  int? noMissing;
  int? noTotal;
  int? percentCompleted;

  factory BookStat.fromJson(Map<String, dynamic> json) => BookStat(
        typeOfBook: json["TypeOfBook"],
        noCompleted: json["NoCompleted"],
        noMissing: json["NoMissing"],
        noTotal: json["NoTotal"],
        percentCompleted: json["PercentCompleted"],
      );

  Map<String, dynamic> toJson() => {
        "TypeOfBook": typeOfBook,
        "NoCompleted": noCompleted,
        "NoMissing": noMissing,
        "NoTotal": noTotal,
        "PercentCompleted": percentCompleted,
      };
}

class CurrentBookStat {
  CurrentBookStat({
    this.bookName,
    this.lastDate,
    this.noCompleted,
    this.noMissing,
    this.percentCompleted,
    this.chapterTitle,
    this.chapterId,
  });

  String? bookName;
  String? lastDate;
  int? noCompleted;
  int? noMissing;
  double? percentCompleted;
  String? chapterTitle;
  int? chapterId;

  factory CurrentBookStat.fromJson(Map<String, dynamic> json) =>
      CurrentBookStat(
        bookName: json["BookName"] ?? "",
        lastDate: json["LastDate"] ?? "",
        noCompleted: json["NoCompleted"] ?? "",
        noMissing: json["NoMissing"] ?? "",
        percentCompleted: json["PercentCompleted"]?.toDouble() ?? 0,
        chapterTitle: json["ChapterTitle"] ?? "",
        chapterId: json["ChapterId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "BookName": bookName,
        "LastDate": lastDate,
        "NoCompleted": noCompleted,
        "NoMissing": noMissing,
        "PercentCompleted": percentCompleted,
        "ChapterTitle": chapterTitle,
        "ChapterId": chapterId,
      };
}
