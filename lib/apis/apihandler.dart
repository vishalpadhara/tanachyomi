import 'dart:convert';
import 'package:tanachyomi/apis/primitive_wrapper.dart';
import 'package:tanachyomi/apis/simple_http_post_parser.dart';
import 'package:tanachyomi/models/calendar_chapter_model.dart';
import 'package:tanachyomi/models/calendar_model.dart';
import 'package:tanachyomi/models/calendar_schedule_model.dart';
import 'package:tanachyomi/models/calendar_stats_model.dart';
import 'package:tanachyomi/models/chaptersListMoreModel.dart';
import '../models/achievementsStudyModel.dart';
import '../models/bookmark_list_model.dart';
import '../models/bookmodel.dart';
import '../models/bookstats_model.dart';
import '../models/chapter_verseses.dart';
import '../models/currentbook_stats_model.dart';
import '../models/dailychartmodel.dart';
import '../models/dashboardAllModel.dart';
import '../models/memberInfoModel.dart';
import '../models/newUserInfoModel.dart';
import '../models/this_week_model.dart';
import '../models/list_chapters_model.dart';
import '../models/list_of_chapters_in_book.dart';
import '../models/partialstats_model.dart';
import '../models/torahmodel.dart';
import '../models/verses_chapter_model.dart';
import '../models/verses_model.dart';
import 'api_config.dart';

class ApiHandler {
  static Future<dynamic> generalPostAPICall(
      ReferenceWrapper reference, String finalUrl) async {
    dynamic parameter;
    try {
      if (reference.shouldIParse) {
        parameter = jsonEncode(reference.requestParam);
      } else {
        parameter = reference.requestParam;
      }
    } catch (e) {
      print('error occurred ${e}');
    }

    Map<String, dynamic>? result = await SimpleHttpParser.callPostRawForFullUrl(
        strJson: parameter, url: finalUrl);

    if (result!["isError"] == true) {
      reference.isError = true;
    } else {
      try {
        var value = jsonDecode(result["value"]);
        reference.responseParam = value;
      } catch (e) {
        reference.isError = true;
      }
      reference.isLoading = false;
    }
    return reference;
  }

  static Future<dynamic> generalGetAPICall(
      ReferenceWrapper reference, String finalUrl) async {
    Map<String, dynamic>? result =
        await SimpleHttpParser.callGetRawForFullUrl(url: finalUrl);

    if (result!["isError"] == true) {
      reference.isError = true;
    } else {
      try {
        var value = jsonDecode(result["value"]);
        reference.responseParam = value;
      } catch (e) {
        reference.isError = true;
      }
      reference.isLoading = false;
    }
    return reference;
  }

  static Future<dynamic> getBookmarkList(ReferenceWrapper reference) async {
    await generalPostAPICall(
        reference, ApiConfig.getFinalNewBaseUrl(ApiConfig.BookmarksList));

    BookmarkListModel bookmarkListModel = new BookmarkListModel();
    bookmarkListModel.neviim = List<Neviim>.from(reference.responseParam["data"]
            ["Neviim"]!
        .map((x) => Neviim.fromJson(x)));
    bookmarkListModel.torah = List<Torah>.from(reference.responseParam["data"]
            ["Torah"]!
        .map((x) => Torah.fromJson(x)));

    List<Torah> torah = [];
    for (int i = 0; i < bookmarkListModel!.torah!.length; i++) {
      torah.add(
        Torah(
          bookName: bookmarkListModel.torah![i].bookName,
          bookTitle: bookmarkListModel.torah![i].bookTitle,
          chapterName: bookmarkListModel.torah![i].chapterName,
          chapterTitle: bookmarkListModel.torah![i].chapterTitle,
          chapterSubTitle: bookmarkListModel.torah![i].chapterSubTitle,
          subChapter: bookmarkListModel.torah![i].subChapter,
          chaptersId: bookmarkListModel.torah![i].chaptersId,
          fileUrl: bookmarkListModel.torah![i].fileUrl,
          rootUrl: bookmarkListModel.torah![i].rootUrl,
          isCompleted: bookmarkListModel.torah![i].isCompleted,
          isBookmark: bookmarkListModel.torah![i].isBookmark,
        ),
      );
    }
    for (int i = 0; i < bookmarkListModel!.neviim!.length; i++) {
      torah.add(
        Torah(
          bookName: bookmarkListModel.neviim![i].bookName,
          bookTitle: bookmarkListModel.neviim![i].bookTitle,
          chapterName: bookmarkListModel.neviim![i].chapterName,
          chapterTitle: bookmarkListModel.neviim![i].chapterTitle,
          chapterSubTitle: bookmarkListModel.neviim![i].chapterSubTitle,
          subChapter: bookmarkListModel.neviim![i].subChapter,
          chaptersId: bookmarkListModel.neviim![i].chaptersId,
          fileUrl: bookmarkListModel.neviim![i].fileUrl,
          rootUrl: bookmarkListModel.neviim![i].rootUrl,
          isCompleted: bookmarkListModel.neviim![i].isCompleted,
          isBookmark: bookmarkListModel.neviim![i].isBookmark,
        ),
      );
    }
    reference.responseParam = torah;
    return reference;
  }

  static markChapterComplete(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.ChaptersCompleted),
    );
    return reference;
  }

  static chaptersUpdateTime(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.ChaptersUpdateTime),
    );
    return reference;
  }

  static callApiForWeekContent(ReferenceWrapper reference) async {
    await generalGetAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.ParashaThisWeek),
    );
    Map data = reference.responseParam["data"];
    List chapinfo = data["ThisWeek"];
    List<ThisWeekModel> bookdata =
        chapinfo.map((e) => ThisWeekModel.fromJson(e)).toList();
    reference.responseParam = bookdata;
    return reference;
  }

  static callApiCurrentBookStats(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.DashboardCurrentBookStats),
    );
    Map data = reference.responseParam["data"];
    List result = data["Result"];

    reference.responseParam =
        result.map((e) => CurrentBookStatsModel.fromJson(e)).toList();
    return reference;
  }

  static callApiDashboardPartialStats(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.DashboardPartialStats),
    );
    Map data = reference.responseParam["data"];
    List result = data["Result"];

    reference.responseParam =
        result.map((e) => PartialStatsModel.fromJson(e)).toList();
    return reference;
  }

  static callApiDashboardTorah(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.DashboardTorah),
    );
    Map data = reference.responseParam["data"];
    List result = data["Result"];

    reference.responseParam =
        result.map((e) => TorahModel.fromJson(e)).toList();
    return reference;
  }

  static callApiDashboardDailyChart(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.DashboardDailyChart),
    );
    Map data = reference.responseParam["data"];
    List result = data["Result"];

    reference.responseParam =
        result.map((e) => DailyChartModel.fromJson(e)).toList();
    return reference;
  }

  static callApiDashboardTanachAchievements(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.DashboardTanachAchievements),
    );
    Map data = reference.responseParam["data"];
    List result = data["Result"];

    reference.responseParam =
        result.map((e) => DailyChartModel.fromJson(e)).toList();
    return reference;
  }

  static saveUpdatedDate(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.DashboardTanachUpdateDate),
    );
    Map data = reference.responseParam["data"];
    List result = data["Result"];

    reference.responseParam =
        result.map((e) => DailyChartModel.fromJson(e)).toList();
    return reference;
  }

  static saveStartDate(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.MemberSaveSettings),
    );
    Map data = reference.responseParam["data"];
    List result = data["Result"];

    reference.responseParam =
        result.map((e) => DailyChartModel.fromJson(e)).toList();
    return reference;
  }

  static callApiDashboardBookStats(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.DashboardBookStats),
    );
    Map data = reference.responseParam["data"];
    List result = data["Result"];

    reference.responseParam =
        result.map((e) => BookStatsModel.fromJson(e)).toList();
    return reference;
  }

  static callApiLibraryBooksListTorah(ReferenceWrapper reference) async {
    await generalGetAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.LibraryBooksListTorah),
    );
    Map data = reference.responseParam["data"];
    List result = data["Books"];

    reference.responseParam = result.map((e) => BookModel.fromJson(e)).toList();
    return reference;
  }

  static callApiParashaListHaftorah(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.LibraryParashaListHaftorah),
    );
    Map data = reference.responseParam["data"];

    ChaptersInBookModel chapter = ChaptersInBookModel();
    List chapters = data["Chapters"];
    var listOfChaptersModel =
        chapters.map((e) => ListOfChaptersModel.fromJson(e));
    try {
      chapter.listOfChaptersModel = listOfChaptersModel.toList();
    } catch (e) {
      print('ds');
    }

    List book = data["Book"];

    try {
      var bookModel = book.map((e) => BookModel.fromJson(e));
      chapter.bookModel = bookModel.toList();
    } catch (e) {
      print('ds');
    }

    reference.responseParam = chapter;
    return reference;
  }

  static callApiParashaList(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.LibraryParashaList),
    );
    Map data = reference.responseParam["data"];

    ChaptersInBookModel chapter = ChaptersInBookModel();
    List chapters = data["Chapters"];
    var listOfChaptersModel =
        chapters.map((e) => ListOfChaptersModel.fromJson(e));
    try {
      chapter.listOfChaptersModel = listOfChaptersModel.toList();
    } catch (e) {
      print('ds');
    }

    List book = data["Book"];

    try {
      var bookModel = book.map((e) => BookModel.fromJson(e));
      chapter.bookModel = bookModel.toList();
    } catch (e) {
      print('ds');
    }

    reference.responseParam = chapter;
    return reference;
  }

  static callApiDashboardAll(ReferenceWrapper reference) async {
    try {
      await generalPostAPICall(
        reference,
        ApiConfig.getFinalNewBaseUrl(ApiConfig.DashboardAll),
      );
      Map data = reference.responseParam["data"];
      List achievementsStudy = data["AchievementsStudy"];
      List achievementsAliyas = data["AchievementsAliyas"];
      List bookStats = data["BookStats"];
      List currentBookStats = data["CurrentBookStats"];
      List dailyChart = data["DailyChart"];
      List partialStats = data["PartialStats"];
      List torah = data["Torah"];

      DashboardAllModel dashboardAll = DashboardAllModel();

      dashboardAll.achievementsAliyas = achievementsAliyas;

      dashboardAll.bookStats =
          bookStats.map((e) => BookStat.fromJson(e)).toList();

      dashboardAll.dailyChart =
          dailyChart.map((e) => DailyChartModel.fromJson(e)).toList();

      dashboardAll.partialStats =
          partialStats.map((e) => PartialStatsModel.fromJson(e)).toList();

      dashboardAll.torah = torah.map((e) => TorahModel.fromJson(e)).toList();

      dashboardAll.currentBookStats =
          currentBookStats.map((e) => CurrentBookStat.fromJson(e)).toList();

      dashboardAll.achievementsStudyModel = achievementsStudy
          .map((e) => AchievementsStudyModel.fromJson(e))
          .toList();

      reference.responseParam = dashboardAll;
    } catch (e) {
      print('object');
    }
    return reference;
  }

  static callApiForParashaListVerses(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.ParashaListVerses),
    );
    Map data = reference.responseParam["data"];
    ChapterVerses chapter = ChapterVerses();
    for (var element
        in (data["Chapter"].map((e) => ChapterModel.fromJson(e))).toList()) {
      chapter.versesChapterModel.add(element);
    }
    var d = (data["Verses"].map((e) => VersesModel.fromJson(e))).toList();
    for (var element in d) {
      chapter.versesInChapter.add(element);
    }

    reference.responseParam = chapter;
    return reference;
  }

  static callApiForBookmarksAdd(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.BookmarksAdd),
    );

    return reference;
  }

  static callApiLibraryBooksListProphets(ReferenceWrapper reference) async {
    await generalGetAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.LibraryBooksListProphets),
    );
    Map data = reference.responseParam["data"];
    List result = data["Books"];

    reference.responseParam = result.map((e) => BookModel.fromJson(e)).toList();
    return reference;
  }

  static callApiLibraryBooksListWritings(ReferenceWrapper reference) async {
    await generalGetAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.LibraryBooksListWritings),
    );

    Map data = reference.responseParam["data"];
    List result = data["Books"];

    reference.responseParam = result.map((e) => BookModel.fromJson(e)).toList();
    return reference;
  }

  static callApiLibraryBooksListHafTorah(ReferenceWrapper reference) async {
    await generalGetAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.LibraryBooksListHaftorah),
    );
    Map data = reference.responseParam["data"];
    List result = data["Books"];

    reference.responseParam = result.map((e) => BookModel.fromJson(e)).toList();
    return reference;
  }

  static callApiForChaptersListMore(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.ChaptersListMore),
    );
    Map data = reference.responseParam["data"];

    reference.responseParam =
        data["Chapters"].map((e) => ChaptersListMoreModel.fromJson(e)).toList();

    return reference;
  }

  static callApiForChaptersList(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.ChaptersList),
    );
    Map data = reference.responseParam["data"];

    ChaptersInBookModel chapter = ChaptersInBookModel();
    List chapters = data["Chapters"];
    var listOfChaptersModel =
        chapters.map((e) => ListOfChaptersModel.fromJson(e));
    try {
      chapter.listOfChaptersModel = listOfChaptersModel.toList();
    } catch (e) {
      print('ds');
    }

    List book = data["Book"];

    try {
      var bookModel = book.map((e) => BookModel.fromJson(e));
      chapter.bookModel = bookModel.toList();
    } catch (e) {
      print('ds');
    }

    reference.responseParam = chapter;
    return reference;
  }

  static callApiBooksListExceptTorah(ReferenceWrapper reference) async {
    await generalGetAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.SettingsBooksListExceptTorah),
    );
    Map data = reference.responseParam["data"];
    List result = data["Books"];

    reference.responseParam = result.map((e) => BookModel.fromJson(e)).toList();
    return reference;
  }

  static callApiMemberGet(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.SettingsMemberGet),
    );
    Map data = reference.responseParam["data"];

    reference.responseParam = MemberInfoModel.fromJson(data["MemberInfo"]);
    return reference;
  }

  static callApiMemberSaveSettings(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.SettingsMemberSaveSettings),
    );
    Map data = reference.responseParam["data"];
    Map result = data["MemberInfo"];

    reference.responseParam = NewUserInfoModel.fromJson(result);

    return reference;
  }

  static callApiForSocialAuthenticate(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.MEMBERS_SocialAuthenticate),
    );
    Map data = reference.responseParam["data"];
    Map result = data["MemberInfo"];

    reference.responseParam = NewUserInfoModel.fromJson(result);

    return reference;
  }

  static callApiMemberListCalendar(ReferenceWrapper reference) async {
    await generalPostAPICall(
      reference,
      ApiConfig.getFinalNewBaseUrl(ApiConfig.MemberListCalendar),
    );

    Map data = reference.responseParam["data"];
    List calendarSchedule = data["CalendarSchedule"];
    List previousChapter = data["PreviousChapter"];
    List nextChapter = data["NextChapter"];
    List currentChapter = data["CurrentChapter"];
    List calendarStats = data["CalendarStats"];

    List<CalendarScheduleModel> calendarScheduleList =
        calendarSchedule.map((e) => CalendarScheduleModel.fromJson(e)).toList();
    List<CalendarChapterModel> previousChapterList =
        previousChapter.map((e) => CalendarChapterModel.fromJson(e)).toList();
    List<CalendarChapterModel> nextChapterList =
        nextChapter.map((e) => CalendarChapterModel.fromJson(e)).toList();
    List<CalendarChapterModel> currentChapterList =
        currentChapter.map((e) => CalendarChapterModel.fromJson(e)).toList();
    List<CalendarStatsModel> calendarStatsList =
        calendarStats.map((e) => CalendarStatsModel.fromJson(e)).toList();

    CalendarModel calendarModel = CalendarModel();
    calendarModel.calendarSchedule = calendarScheduleList;
    calendarModel.previousChapter = previousChapterList;
    calendarModel.nextChapter = nextChapterList;
    calendarModel.currentChapter = currentChapterList;
    calendarModel.calendarStats = calendarStatsList;
    reference.responseParam = calendarModel;
    return reference;
  }
}
