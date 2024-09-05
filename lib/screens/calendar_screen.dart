import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanachyomi/apis/apihandler.dart';
import 'package:tanachyomi/apis/primitive_wrapper.dart';
import 'package:tanachyomi/models/calendar_chapter_model.dart';
import 'package:tanachyomi/models/calendar_model.dart';
import 'package:tanachyomi/models/calendar_schedule_model.dart';
import 'package:tanachyomi/models/calendar_stats_model.dart';
import 'package:tanachyomi/screens/Verses/versescreen.dart';
import 'package:tanachyomi/screens/errorscreenpage.dart';
import 'package:tanachyomi/screens/no_internet_screen.dart';
import 'package:tanachyomi/screens/please_wait_loader.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/current_userinfo.dart';
import 'package:tanachyomi/utils/dateutil.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CalendarScreenState createState() => new _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  bool isError = false;
  bool? isInternet;
  bool? isLoading = true;
  ReferenceWrapper reference = ReferenceWrapper(null, null);
  EventList<Event>? _markedDateMap;
  @override
  void initState() {
    internetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return layout();
  }

  layoutMain() {
    final _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (date, events) {
        this.setState(
          () {
            currentSelectedDate = date;
            callApi();
          },
        );
      },
      weekDayFormat: WeekdayFormat.narrow,
      weekdayTextStyle: TextStyle(
        fontSize: 11,
        color: Color(0xFF62606E),
      ),
      prevDaysTextStyle: TextStyle(
        fontSize: 11,
        color: Colors.transparent,
      ),
      nextDaysTextStyle: TextStyle(
        fontSize: 11,
        color: Colors.transparent,
      ),
      weekendTextStyle: TextStyle(
        fontSize: 11,
        color: Color(0xFF62606E),
      ),
      thisMonthDayBorderColor: Colors.grey,
      daysTextStyle: TextStyle(
        fontSize: 11,
        color: Color(0xFF62606E),
      ),
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 300.0,
      selectedDayButtonColor: Colors.transparent,
      selectedDayBorderColor: Colors.transparent,
      selectedDateTime: currentSelectedDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.transparent)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: AppColor.appColorSecondaryValue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.transparent,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      showIconBehindDayText: true,
      markedDateShowIcon: false,
      markedDateMoreShowTotal: false,
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Calendar",
          style:
              TextStyle(color: AppColor.appColorSecondaryValue, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 35,
              decoration: new BoxDecoration(
                color: Color(0xFF62606E),
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(5.0),
                  topRight: const Radius.circular(5.0),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              //: const EdgeInsets.only(left: 5.0, right: 5),
              child: new Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_before_outlined,
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          _targetDateTime = DateTime(
                              _targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth =
                              DateFormat.yMMM().format(_targetDateTime);
                          currentSelectedDate = DateTime(
                              currentSelectedDate.year,
                              currentSelectedDate.month - 1,
                              currentSelectedDate.day);
                          callApi();
                        },
                      );
                    },
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        _currentMonth,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.navigate_next_outlined,
                      size: 24,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month + 1);
                        _currentMonth =
                            DateFormat.yMMM().format(_targetDateTime);
                        currentSelectedDate = DateTime(
                            currentSelectedDate.year,
                            currentSelectedDate.month + 1,
                            currentSelectedDate.day);
                        callApi();
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFF5F5F5),
              margin:
                  EdgeInsets.only(top: 3, bottom: 15, left: 15.0, right: 15),
              child: _calendarCarousel,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              color: Colors.white,
              child: Column(
                children: [
                  // Stack(
                  //   alignment: Alignment.bottomCenter,
                  //   children: [
                  // Visibility(
                  //   visible: false,
                  //   child: Card(
                  //     margin: EdgeInsets.zero,
                  //     elevation: 50,
                  //     shadowColor: Colors.black,
                  //     color: Color(0xFF62606E),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(
                  //           top: 15.0, left: 8, right: 8, bottom: 8),
                  //       child: Column(
                  //         children: [
                  //           SizedBox(
                  //             width: MediaQuery.of(context).size.width,
                  //             height: 100,
                  //             child: Column(
                  //               children: [
                  //                 Row(
                  //                   children: [
                  //                     Expanded(
                  //                       flex: 1,
                  //                       child: Text(
                  //                         "TODAY'S SHUR:",
                  //                         style: TextStyle(
                  //                             fontSize: 12,
                  //                             fontWeight: FontWeight.w500,
                  //                             color: AppColor.white),
                  //                       ),
                  //                     ),
                  //                     Expanded(
                  //                       flex: 2,
                  //                       child: Container(
                  //                         padding:
                  //                             EdgeInsets.only(right: 30),
                  //                         child: Center(
                  //                           child: Text(
                  //                             "YEHOSHUA",
                  //                             style: TextStyle(
                  //                                 fontSize: 18,
                  //                                 color: Color(0xFFD4C088)),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       child: Expanded(
                  //                         flex: 1,
                  //                         child: Text(
                  //                           getCurrentDateFormated,
                  //                           style: TextStyle(
                  //                               fontSize: 12,
                  //                               fontWeight: FontWeight.w500,
                  //                               color: AppColor.white),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 Expanded(
                  //                   flex: 1,
                  //                   child: Text(
                  //                     "5",
                  //                     style: TextStyle(
                  //                         fontSize: 28,
                  //                         fontWeight: FontWeight.w500,
                  //                         color: AppColor.white),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Card(
                  //   margin: EdgeInsets.zero,
                  //   borderOnForeground: false,
                  //   elevation: 50,
                  //   shadowColor: Colors.white,
                  //   color: Colors.white,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(5),
                  //       topRight: Radius.circular(5),
                  //     ),
                  //   ),
                  //   child: Positioned(
                  //     left: 30.0,
                  //     top: 30.0,
                  //     child: SizedBox(
                  //       width: 159,
                  //       height: 35,
                  //       child: Center(
                  //         child: Text(
                  //           'Let\'s GO Learn',
                  //           style: TextStyle(
                  //             fontSize: 12,
                  //             color: Color(0xFF62606E),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                ],
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              elevation: 50,
              shadowColor: Colors.black,
              color: Color(0xFFF5F5F5),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: SizedBox(
                  height: 90,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                SlideRightRoute(
                                  widget: VerseScreen(
                                      bookname:
                                          previousChapter!.first.bookTitle,
                                      subTitle: previousChapter!.first.subTitle,
                                      chaptersId: previousChapter!.first.id,
                                      url: previousChapter!.first.rootUrl +
                                          previousChapter!.first.fileUrl,
                                      subChapter:
                                          previousChapter!.first.subChapter,
                                      isCompleted: false),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Previous',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xFF62606E)),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible:
                                        previousChapter == null ? false : true,
                                    child: Text(
                                      previousChapter!.first.bookTitle
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFD4C088)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible:
                                        previousChapter == null ? false : true,
                                    child: Text(
                                      previousChapter!.first.title,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF62606E)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Color(0xFF707070),
                          indent: 7,
                          endIndent: 7,
                        ),
                        Expanded(
                          flex: 1,
                          child: new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                SlideRightRoute(
                                  widget: VerseScreen(
                                      bookname: currentChapter!.first.bookTitle,
                                      subTitle: currentChapter!.first.subTitle,
                                      chaptersId: currentChapter!.first.id,
                                      url: currentChapter!.first.rootUrl +
                                          currentChapter!.first.fileUrl,
                                      subChapter:
                                          currentChapter!.first.subChapter,
                                      isCompleted: false),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Today',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xFF62606E)),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible:
                                        currentChapter == null ? false : true,
                                    child: Text(
                                      currentChapter!.first.bookTitle
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFD4C088)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible:
                                        currentChapter == null ? false : true,
                                    child: Text(
                                      currentChapter!.first.title,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF62606E)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalDivider(
                          color: Color(0xFF707070),
                          indent: 7,
                          endIndent: 7,
                        ),
                        Expanded(
                          flex: 1,
                          child: new GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                SlideRightRoute(
                                  widget: VerseScreen(
                                      bookname: nextChapter!.first.bookTitle,
                                      subTitle: nextChapter!.first.subTitle,
                                      chaptersId: nextChapter!.first.id,
                                      url: nextChapter!.first.rootUrl +
                                          nextChapter!.first.fileUrl,
                                      subChapter: nextChapter!.first.subChapter,
                                      isCompleted: false),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xFF62606E)),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible: nextChapter == null ? false : true,
                                    child: Text(
                                      nextChapter!.first.bookTitle
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFD4C088)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    nextChapter!.first.title,
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xFF62606E)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String get getCurrentDateFormated {
    var formatter = new DateFormat('yyyy/MM/dd');
    String formattedDate = formatter.format(currentSelectedDate);
    return formattedDate;
  }

  Widget layout() {
    if (isInternet != null && isInternet!) {
      if (!isError) {
        if (isLoading != null && isLoading! == true) {
          callApi();
        } else if (isLoading != null && isLoading! == false) {
          return layoutMain();
        }
      } else {
        return const ErrorScreenPage();
      }
    } else if (isInternet != null && isInternet!) {
      return NoInternetScreen(
        onPressedRetyButton: () {
          internetConnection();
        },
      );
    }
    return PleaseWait();
  }

  internetConnection() async {
    isInternet = await Constants.isInternetAvailable();
    isLoading = isInternet;
    setState(() {});
  }

  callApi() async {
    if (isInternet == null) {
      isInternet = await internetConnection();
    }

    if (isInternet == true) {
      await getSharedPreferences();
      try {
        await callApiMemberListCalendar();
      } catch (e) {}
      isLoading = false;
      setState(() {});
    }
  }

  SharedPreferences? prefs;
  List<CalendarScheduleModel>? calendarSchedule;
  List<CalendarStatsModel>? calendarStats;
  List<CalendarChapterModel>? currentChapter;
  List<CalendarChapterModel>? nextChapter;
  List<CalendarChapterModel>? previousChapter;

  FutureOr getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  DateTime currentSelectedDate = DateTime.now();
  FutureOr<void> callApiMemberListCalendar() async {
    _markedDateMap = new EventList<Event>(events: {});
    Map<String, dynamic> toJson = {
      "MembersId": CurrentUserInfo.currentUserId,
      "CalendarMonth": currentSelectedDate.month,
      "CalendarYear": currentSelectedDate.year,
      "CalendarDay": currentSelectedDate.day,
    };
    reference.requestParam = toJson;
    reference.shouldIParse = true;
    await ApiHandler.callApiMemberListCalendar(reference);
    if (reference.isError) {
      reference.isError = false;
      isLoading = false;
    } else {
      try {
        CalendarModel calendarModel = CalendarModel();
        calendarModel = reference.responseParam;

        calendarSchedule = calendarModel.calendarSchedule;
        calendarStats = calendarModel.calendarStats;
        currentChapter = calendarModel.currentChapter;
        nextChapter = calendarModel.nextChapter;
        previousChapter = calendarModel.previousChapter;

        for (var element in calendarSchedule!) {
          Color? color = null;
          if (element.isCompleted)
            color = Colors.grey;
          else if (element.isStarted)
            color = Colors.yellow;
          else
            color = AppColor.appColorSecondaryValue;
          DateTime? date =
              DateUtil.StingToDate(element.studyScheduleDate, "MM-dd-yyyy");
          if (date != null) {
            Event event = new Event(
              date: new DateTime(date.year, date.month, date.day),
              dot: Center(
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  padding: EdgeInsets.only(right: 2, bottom: 10),
                  decoration: new BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
            _markedDateMap!
                .add(new DateTime(date.year, date.month, date.day), event);
          }
        }
      } catch (e) {
        print('object');
      }
      setState(() {});
    }
  }
}
