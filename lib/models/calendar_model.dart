import 'package:tanachyomi/models/calendar_chapter_model.dart';
import 'package:tanachyomi/models/calendar_schedule_model.dart';
import 'package:tanachyomi/models/calendar_stats_model.dart';

class CalendarModel {
  List<CalendarScheduleModel>? calendarSchedule;
  List<CalendarChapterModel>? previousChapter;
  List<CalendarChapterModel>? nextChapter;
  List<CalendarChapterModel>? currentChapter;
  List<CalendarStatsModel>? calendarStats;
}
