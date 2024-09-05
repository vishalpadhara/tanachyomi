import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:tanachyomi/models/chartdata.dart';
import 'package:tanachyomi/models/this_week_model.dart';
import 'package:tanachyomi/models/mapmodel.dart';
import 'package:tanachyomi/models/usermodel.dart';
import 'package:tanachyomi/screens/Verses/versescreen.dart';
import 'package:tanachyomi/screens/billing_address_screen.dart';
import 'package:tanachyomi/screens/calendar_screen.dart';
import 'package:tanachyomi/screens/errorscreenpage.dart';
import 'package:tanachyomi/screens/library_screens/library_screen.dart';
import 'package:tanachyomi/screens/no_internet_screen.dart';
import 'package:tanachyomi/screens/please_wait_loader.dart';
import 'package:tanachyomi/screens/profile_screens/profile_screen.dart';
import 'package:tanachyomi/screens/donate_button_screen.dart';
import 'package:tanachyomi/screens/setting_screens/settings.dart';
import 'package:tanachyomi/screens/sponsor_module_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/clippath.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/dateutil.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import 'package:tanachyomi/utils/validator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as Rp;
import '../apis/apihandler.dart';
import '../apis/common_paramters.dart';
import '../apis/primitive_wrapper.dart';
import '../models/achievementsStudyModel.dart';
import '../models/bookstats_model.dart';
import '../models/currentbook_stats_model.dart';
import '../models/dailychartmodel.dart';
import '../models/dashboardAllModel.dart';
import '../models/partialstats_model.dart';
import '../models/torahmodel.dart';
import '../utils/current_userinfo.dart';

class HomeScreen extends StatefulWidget {
  String? authname;
  String? uid;
  String? email;
  String? displayname;

  HomeScreen({Key? key, this.authname, this.uid, this.email, this.displayname})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with
    SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomeScreen> {
  int? selected = 0;
  PageController controller = PageController(
    initialPage: 0,
  );
  ReferenceWrapper reference = ReferenceWrapper(null, null);

  bool ProgressDone = false;

  List Size1 = [
    20.0,
    90.0,
    120.0,
    70.0,
    50.0,
    60.0,
    70.0,
    80.0,
    125.0,
    50.0,
    110.0
  ];
  List yaxis = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  // List xaxis = ["60", "2", "3", "4","5","6"];
  List xaxis = ["60min", "50min", "40min", "30min", "20min", "10min"];

  // List Size = [50.0, 90.0, 120.0, 70.0];

  List<Color> col = [
    AppColor.grey1.shade300,
    AppColor.appColorSecondaryValue,
    AppColor.grey1.shade300,
    AppColor.grey1.shade300
  ];

  bool isBack = false;
  bool isdark = false;
  bool isGood = false;
  late List<GraphChartData> graphdata = [];
  late TooltipBehavior _tooltip;
  SharedPreferences? prefs;
  int? userid;
  String? imgGuid;
  List<ThisWeekModel>? weeklist;
  CurrentBookStat? currentBookStatsModel;
  List<PartialStatsModel>? partialStatsModel;
  List<TorahModel>? torahModel;
  List<DailyChartModel>? dailyChartModel;
  List<BookStat>? bookStatsModel;
  List<AchievementsStudyModel>? achievementsStudyModel;

  DateTime date = DateTime.now();
  TextEditingController birthDateTextController =
      TextEditingController(text: "16/09/2022");
  TextEditingController surveyTextController =
      TextEditingController(text: "JohnSmith in honor of Cohen");
  late List<Model> _data;
  late List<Widget> _iconsList;
  late MapShapeSource _dataSource;
  bool isError = false;
  bool? isInternet;
  bool? isLoading = true;

  @override
  void initState() {
    internetConnection();
    _data = <Model>[
      Model(70.87433, -135.96818),
      Model(61.16569, -105.451526),
      Model(35.274398, -5.775136),
    ];

    _iconsList = <Widget>[
      Image.asset(
        "assets/images/pointer.png",
        height: 40,
        width: 20,
        fit: BoxFit.fill,
      ),
      Image.asset(
        "assets/images/pointer.png",
        height: 40,
        width: 20,
        fit: BoxFit.fill,
      ),
      Image.asset(
        "assets/images/pointer.png",
        height: 40,
        width: 20,
        fit: BoxFit.fill,
      ),
    ];

    _dataSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'name',
    );

    _tooltip = TooltipBehavior(
      enable: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.size <= const Size(360.0, 720.0)) {
      // build small image.
      isGood = true;
      setState(() {});
    } else {
      isGood = false;
      setState(() {});
      // build big image.
    }
    return WillPopScope(
        child: layout(),
        onWillPop: () {
          return handleBackPress();
        });
  }

  Widget layoutMain() {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isdark = theme.getTheme() == theme.darkTheme ? true : false;
      return WillPopScope(
        onWillPop: () {
          return handleBackPress();
        },
        child: Scaffold(
          bottomNavigationBar: StylishBottomBar(
            items: [
              BottomBarItem(
                  icon: SvgPicture.asset("assets/homepin.svg",
                      color: AppColor.grey1.shade500,
                      height: 25,
                      semanticsLabel: 'A red up arrow'),
                  selectedIcon: SvgPicture.asset("assets/homepin.svg",
                      color: Colors.black87,
                      height: 25,
                      semanticsLabel: 'A red up arrow'),
                  selectedColor: Colors.black87,
                  title: const Text('Home')),
              BottomBarItem(
                  icon: const Icon(Icons.library_books),
                  selectedIcon: const Icon(Icons.library_books),
                  selectedColor: Colors.black87,
                  title: const Text('Library')),
              BottomBarItem(
                  icon: const Icon(
                    Icons.settings,
                  ),
                  selectedIcon: const Icon(
                    Icons.settings,
                  ),
                  selectedColor: Colors.black87,
                  title: const Text('Settings')),
              BottomBarItem(
                  icon: const Icon(
                    Icons.account_circle_outlined,
                  ),
                  selectedIcon: const Icon(
                    Icons.account_circle,
                  ),
                  selectedColor: Colors.black87,
                  title: const Text('Profile')),
            ],
            backgroundColor: isdark == true ? Colors.white : Colors.white54,
            hasNotch: false,
            elevation: 1,
            currentIndex: selected ?? 0,
            onTap: (index) {
              controller.jumpToPage(index!);
              setState(
                () {
                  selected = index;
                },
              );
            },
            option: AnimatedBarOptions(
              iconSize: 26,
              iconStyle: IconStyle.Default,
            ),
          ),
          body: PageView(
              controller: controller,
              allowImplicitScrolling: true,
              onPageChanged: (val) {
                setState(() {
                  selected = val;
                });
              },
              children: [
                HomePageLayout(),
                LibraryScreen(),
                Settings(),
                ProfileScreen(),
              ]),
        ),
      );
    });
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

  Widget HomePageLayout() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isdark ? AppColor.mainbg : AppColor.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: isdark == true ? AppColor.mainbg : AppColor.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              weekrecords(),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.grey1.shade500
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 10,
              ),
              progressview(),
              progress(),
              progressreport(),
              SizedBox(
                height: 20,
              ),
              addata(),
              SizedBox(
                height: 20,
              ),
              bookdata(),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.grey1.shade500
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 120,
                endIndent: 120,
              ),
              SizedBox(
                height: 20,
              ),
              bookreport(),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.grey1.shade500
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 120,
                endIndent: 120,
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // bookstatistic(),
              // SizedBox(
              //   height: 20,
              // ),
              // ScondLayout(),
              SizedBox(
                height: 20,
              ),
              fourthLayout(),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.grey1.shade500
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 120,
                endIndent: 120,
              ),
              SizedBox(
                height: 20,
              ),
              achievement(),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.grey1.shade500
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.grey1.shade500
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 120,
                endIndent: 120,
              ),
              SizedBox(
                height: 20,
              ),
              leadershipboard(),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.grey1.shade500
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 10,
              ),
              sponsor(),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.grey1.shade500
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 120,
                endIndent: 120,
              ),
              SizedBox(
                height: 10,
              ),
              addata1(),
            ],
          ),
        ),
      ),
    );
  }

  Widget weekrecords() {
    return weeklist!.isNotEmpty
        ? Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color:
                    isdark == true ? AppColor.grey1.shade800 : AppColor.boxback,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Aliya Yomi",
                  style: TextStyle(
                      color: isdark == true
                          ? AppColor.appColorPrimaryValue
                          : AppColor.appColorSecondaryValue,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                      text: "Parsha",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                      children: [
                        TextSpan(
                            text: " - ",
                            style: TextStyle(
                                color: AppColor.appColorPrimaryValue)),
                        TextSpan(text: "${weeklist![0].bookName}")
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: isGood == true
                      ? EdgeInsets.only(
                          top: 5, bottom: 5.0, right: 5.0, left: 1.0)
                      : EdgeInsets.only(
                          top: 5, bottom: 5.0, right: 5.0, left: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.only(right: 0),
                          height: MediaQuery.of(context).size.height / 22,
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: ListView.builder(
                              itemCount: 7,
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    weeklist!.length >= 7
                                        ? Navigator.push(
                                            context,
                                            SlideRightRoute(
                                              widget: VerseScreen(
                                                  bookname:
                                                      weeklist![index].bookName,
                                                  subTitle:
                                                      weeklist![index].bookName,
                                                  chaptersId: weeklist![index]
                                                      .chaptersId,
                                                  url: "${weeklist![index].rootUrl}" +
                                                      "${weeklist![index].fileUrl}",
                                                  subChapter: weeklist![index]
                                                      .subChapter,
                                                  isCompleted: weeklist![
                                                          weeklist!.length - 1]
                                                      .isCompleted),
                                            ),
                                          )
                                        : Fluttertoast.showToast(
                                            msg: "No Data Found",
                                            toastLength: Toast.LENGTH_SHORT);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    height: /*40*/
                                        MediaQuery.of(context).size.height / 22,
                                    width: /*35*/
                                        MediaQuery.of(context).size.width / 11,
                                    decoration: BoxDecoration(
                                        color: isdark == true
                                            ? AppColor.appColorPrimaryValue
                                                .withOpacity(0.3)
                                            : AppColor.box,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    child: Center(
                                        child: Text((index + 1).toString())),
                                  ),
                                );
                              }),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlideRightRoute(
                                widget: VerseScreen(
                                  bookname:
                                      weeklist![weeklist!.length - 1].bookName,
                                  subTitle:
                                      weeklist![weeklist!.length - 1].bookTitle,
                                  chaptersId: weeklist![weeklist!.length - 1]
                                      .chaptersId,
                                  url: "${weeklist![weeklist!.length - 1].rootUrl}" +
                                      "${weeklist![weeklist!.length - 1].fileUrl}",
                                  subChapter: weeklist![weeklist!.length - 1]
                                      .subChapter,
                                  isCompleted: weeklist![weeklist!.length - 1]
                                      .isCompleted,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: isGood == true
                                ? EdgeInsets.only(left: 2)
                                : EdgeInsets.only(left: 1),
                            height: MediaQuery.of(context).size.height / 25,
                            width: isGood == true
                                ? MediaQuery.of(context).size.width / 7.4
                                : MediaQuery.of(context).size.width / 6.4,
                            decoration: BoxDecoration(
                                color: isdark == true
                                    ? AppColor.appColorPrimaryValue
                                        .withOpacity(0.7)
                                    : Colors.blue.shade400.withOpacity(0.2),
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Center(
                                child: Text(
                              "Haftorah",
                              style: isGood == true
                                  ? TextStyle(fontSize: 6)
                                  : TextStyle(),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  color: isdark
                      ? AppColor.white
                      : AppColor.grey600.withOpacity(0.5),
                  thickness: 2,
                  indent: 30,
                  endIndent: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "The Aliya Yomi module is dedicated in Memory of\nPaul Peyser by Mindy and Alan Peyser",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color:
                    isdark == true ? AppColor.grey1.shade800 : AppColor.boxback,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Aliya Yomi",
                  style: TextStyle(
                      color: isdark == true
                          ? AppColor.appColorPrimaryValue
                          : AppColor.appColorSecondaryValue,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: "No Parasha This Week",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                    children: [],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: isGood == true
                      ? EdgeInsets.only(
                          top: 5, bottom: 5.0, right: 5.0, left: 1.0)
                      : EdgeInsets.only(
                          top: 5, bottom: 5.0, right: 5.0, left: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.only(right: 0),
                          height: MediaQuery.of(context).size.height / 22,
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: ListView.builder(
                            itemCount: 7,
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  height:
                                      MediaQuery.of(context).size.height / 22,
                                  width: MediaQuery.of(context).size.width / 11,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  child: Center(
                                      child: Text((index + 1).toString())),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: InkWell(
                          child: Container(
                            margin: isGood == true
                                ? EdgeInsets.only(left: 2)
                                : EdgeInsets.only(left: 1),
                            height: MediaQuery.of(context).size.height / 25,
                            width: isGood == true
                                ? MediaQuery.of(context).size.width / 7.4
                                : MediaQuery.of(context).size.width / 6.4,
                            decoration: BoxDecoration(
                                color: isdark == true
                                    ? AppColor.appColorPrimaryValue
                                        .withOpacity(0.7)
                                    : Colors.blue.shade400.withOpacity(0.2),
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Center(
                                child: Text(
                              "Haftorah",
                              style: isGood == true
                                  ? TextStyle(fontSize: 6)
                                  : TextStyle(),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  color: isdark
                      ? AppColor.white
                      : AppColor.grey600.withOpacity(0.5),
                  thickness: 2,
                  indent: 30,
                  endIndent: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "The Aliya Yomi module is dedicated in Memory of\nPaul Peyser by Mindy and Alan Peyser",
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
  }

  Widget progressview() {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.only(left: 20, right: 20.0, top: 10),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: currentBookStatsModel != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text("Nach Yomi",
                        style: TextStyle(
                            color: isdark == true
                                ? AppColor.appColorPrimaryValue
                                : AppColor.appColorSecondaryValue,
                            fontSize: 18)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Check Our Progress and Achievements",
                        style: TextStyle(fontSize: 15)),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        //_selectDate(context);
                        setState(
                          () {
                            Navigator.push(
                              context,
                              SlideRightRoute(
                                widget: CalendarScreen(
                                  title: '',
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(parseDate(),
                              style: TextStyle(
                                  color: isdark == true
                                      ? AppColor.appColorSecondaryValue
                                      : AppColor.appColorPrimaryValue,
                                  fontSize: 15)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.calendar_month,
                            size: 20,
                            color: AppColor.grey600,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text("Complete"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isdark == true
                                        ? AppColor.grey600
                                        : Colors.grey.shade200,
                                  ),
                                  child: Center(
                                      child: Text("0",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: isdark == true
                                                  ? AppColor
                                                      .appColorPrimaryValue
                                                  : AppColor
                                                      .appColorSecondaryValue,
                                              fontWeight: FontWeight.w700))),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: SfRadialGauge(axes: <RadialAxis>[
                              RadialAxis(
                                radiusFactor: 1.1,
                                maximum: 100,
                                minimum: 0,
                                startAngle: -90,
                                endAngle: 270,
                                canScaleToFit: true,
                                showLabels: false,
                                minorTickStyle:
                                    MinorTickStyle(length: 0, thickness: 0),
                                majorTickStyle:
                                    MajorTickStyle(thickness: 0, length: 0),
                                canRotateLabels: false,
                                isInversed: false,
                                axisLineStyle: AxisLineStyle(
                                  thickness: 14,
                                  color: isdark == true
                                      ? AppColor.grey1.shade200
                                      : AppColor.grey1.shade300,
                                ),
                                annotations: [
                                  GaugeAnnotation(
                                    widget: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 18),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: isdark == true
                                                    ? AppColor.white
                                                    : AppColor.progressbar,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "0 %",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: isdark == true
                                                    ? AppColor
                                                        .appColorPrimaryValue
                                                    : AppColor
                                                        .appColorSecondaryValue,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "chapter",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: isdark == true
                                                    ? AppColor
                                                        .appColorPrimaryValue
                                                    : AppColor
                                                        .appColorSecondaryValue,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                                pointers: <GaugePointer>[
                                  RangePointer(
                                      value: 0,
                                      width: 0.18,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      cornerStyle: Rp.CornerStyle.bothCurve,
                                      color: isdark == true
                                          ? AppColor.appColorPrimaryValue
                                          : AppColor.grey600),
                                  MarkerPointer(
                                    value: 0,
                                    markerHeight: 15,
                                    markerWidth: 15,
                                    markerOffset: 0,
                                    markerType: MarkerType.circle,
                                    color: isdark
                                        ? AppColor.mainbg
                                        : AppColor
                                            .appColorSecondaryValue /*Colors.red*/,
                                  )
                                ],
                              )
                            ]),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text("Missing"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isdark == true
                                        ? AppColor.grey600
                                        : Colors.grey.shade200,
                                  ),
                                  child: Center(
                                      child: Text("0",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: isdark == true
                                                  ? AppColor
                                                      .appColorPrimaryValue
                                                  : AppColor
                                                      .appColorSecondaryValue,
                                              fontWeight: FontWeight.w700))),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // color: Colors.teal,
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColor.appColorSecondaryValue)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            SlideRightRoute(
                              widget: VerseScreen(
                                  bookname: "",
                                  subTitle: "",
                                  chaptersId: 0,
                                  url: "",
                                  subChapter: ""),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Study Today",
                              style: TextStyle(color: AppColor.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/images/book.png",
                              height: 20,
                              width: 25,
                              fit: BoxFit.fill,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text("Nach Yomi",
                        style: TextStyle(
                            color: isdark == true
                                ? AppColor.appColorPrimaryValue
                                : AppColor.appColorSecondaryValue,
                            fontSize: 18)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Check Our Progress and Achievements",
                        style: TextStyle(fontSize: 15)),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(parseDate(),
                              style: TextStyle(
                                  color: isdark == true
                                      ? AppColor.appColorSecondaryValue
                                      : AppColor.appColorPrimaryValue,
                                  fontSize: 15)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.calendar_month,
                            size: 20,
                            color: AppColor.grey600,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text("Complete"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isdark == true
                                        ? AppColor.grey600
                                        : Colors.grey.shade200,
                                  ),
                                  child: Center(
                                      child: Text("0",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: isdark == true
                                                  ? AppColor
                                                      .appColorPrimaryValue
                                                  : AppColor
                                                      .appColorSecondaryValue,
                                              fontWeight: FontWeight.w700))),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: SfRadialGauge(axes: <RadialAxis>[
                              RadialAxis(
                                radiusFactor: 1.1,
                                maximum: 100,
                                minimum: 0,
                                startAngle: -90,
                                endAngle: 270,
                                canScaleToFit: true,
                                showLabels: false,
                                minorTickStyle:
                                    MinorTickStyle(length: 0, thickness: 0),
                                majorTickStyle:
                                    MajorTickStyle(thickness: 0, length: 0),
                                canRotateLabels: false,
                                isInversed: false,
                                axisLineStyle: AxisLineStyle(
                                  thickness: 14,
                                  color: isdark == true
                                      ? AppColor.grey1.shade200
                                      : AppColor.grey1.shade300,
                                ),
                                annotations: [
                                  GaugeAnnotation(
                                    widget: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 18),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: isdark == true
                                                    ? AppColor.white
                                                    : AppColor.progressbar,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "0%",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: isdark == true
                                                    ? AppColor
                                                        .appColorPrimaryValue
                                                    : AppColor
                                                        .appColorSecondaryValue,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            "chapter",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: isdark == true
                                                    ? AppColor
                                                        .appColorPrimaryValue
                                                    : AppColor
                                                        .appColorSecondaryValue,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                                pointers: <GaugePointer>[
                                  RangePointer(
                                      value: 0,
                                      width: 0.18,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      cornerStyle: Rp.CornerStyle.bothCurve,
                                      color: isdark == true
                                          ? AppColor.appColorPrimaryValue
                                          : AppColor.grey600),
                                  MarkerPointer(
                                    value: (0),
                                    markerHeight: 15,
                                    markerWidth: 15,
                                    markerOffset: 0,
                                    markerType: MarkerType.circle,
                                    color: isdark
                                        ? AppColor.mainbg
                                        : AppColor
                                            .appColorSecondaryValue /*Colors.red*/,
                                  )
                                ],
                              )
                            ]),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text("Missing"),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isdark == true
                                        ? AppColor.grey600
                                        : Colors.grey.shade200,
                                  ),
                                  child: Center(
                                      child: Text("0",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: isdark == true
                                                  ? AppColor
                                                      .appColorPrimaryValue
                                                  : AppColor
                                                      .appColorSecondaryValue,
                                              fontWeight: FontWeight.w700))),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      // color: Colors.teal,
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColor.appColorSecondaryValue)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            SlideRightRoute(
                              widget: VerseScreen(
                                  bookname: "",
                                  subTitle: "",
                                  chaptersId: 0,
                                  url: "",
                                  subChapter: ""),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Study Today",
                              style: TextStyle(color: AppColor.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/images/book.png",
                              height: 20,
                              width: 25,
                              fit: BoxFit.fill,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  String parseDate() {
    DateTime localDate = DateTime.now();
    try {
      localDate = DateFormat('dd/MM/yyyy').parse(birthDateTextController.text);
    } catch (e) {
      localDate = DateFormat('dd/MM/yyyy').parse(birthDateTextController.text);
    }

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('MM/dd/yy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  Widget progress() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/images/book.png",
            color: isdark == true ? AppColor.white : null,
            width: 50,
            height: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Progress",
              style: TextStyle(
                  color: isdark == true
                      ? AppColor.appColorPrimaryValue
                      : AppColor.appColorSecondaryValue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 10,
          ),
          Text("How much have you studied",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget progressreport() {
    return Card(
      margin: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      )),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            color: AppColor.grey1.shade400),
        // margin: EdgeInsets.only(left: 20,right: 20),
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(10),
                // bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: isdark == true ? AppColor.grey1.shade800 : Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sefarim in Progress",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                height: 10,
              ),
              Text("Check your Progress and Achievements",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              SizedBox(
                height: 10,
              ),
              partialStatsModel!.length != 0
                  ? Row(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/book.png",
                                    color: isdark == true
                                        ? AppColor.white
                                        : AppColor.appColorPrimaryValue,
                                    width: 30,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    partialStatsModel![0].bookName ?? "",
                                    style: TextStyle(
                                        color: isdark == true
                                            ? AppColor.appColorPrimaryValue
                                            : AppColor.grey600,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    lineHeight: 14.0,
                                    percent: partialStatsModel
                                            ?.first.percentCompleted ??
                                        0,
                                    barRadius: Radius.circular(10),
                                    backgroundColor: AppColor.grey1.shade300,
                                    progressColor: isdark == true
                                        ? AppColor.appColorSecondaryValue
                                        : AppColor.grey600,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    ((partialStatsModel?.first
                                                        .percentCompleted ??
                                                    0) *
                                                100)
                                            .round()
                                            .toString() +
                                        "%",
                                    style: TextStyle(
                                        color: isdark == true
                                            ? AppColor.white
                                            : AppColor.appColorSecondaryValue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            color: isdark == true
                                ? AppColor.mainbg
                                : AppColor.white,
                          ),
                        ),
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            color: isdark == true
                                ? AppColor.mainbg
                                : AppColor.white,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/book.png",
                                    color: isdark == true
                                        ? AppColor.white
                                        : AppColor.appColorPrimaryValue,
                                    width: 30,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    partialStatsModel?.last.bookName ?? "",
                                    style: TextStyle(
                                        color: isdark == true
                                            ? AppColor.appColorPrimaryValue
                                            : AppColor.grey600,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    lineHeight: 14.0,
                                    percent: partialStatsModel
                                            ?.last.percentCompleted ??
                                        0,
                                    barRadius: Radius.circular(10),
                                    backgroundColor: AppColor.grey1.shade300,
                                    progressColor: isdark == true
                                        ? AppColor.appColorSecondaryValue
                                        : AppColor.grey600,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    ((partialStatsModel?.last
                                                        .percentCompleted ??
                                                    0) *
                                                100)
                                            .round()
                                            .toString() +
                                        "%",
                                    style: TextStyle(
                                        color: isdark == true
                                            ? AppColor.white
                                            : AppColor.appColorSecondaryValue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/book.png",
                                    color: isdark == true
                                        ? AppColor.white
                                        : AppColor.appColorPrimaryValue,
                                    width: 30,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " ",
                                    style: TextStyle(
                                        color: isdark == true
                                            ? AppColor.appColorPrimaryValue
                                            : AppColor.grey600,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    lineHeight: 14.0,
                                    percent: 0,
                                    barRadius: Radius.circular(10),
                                    backgroundColor: AppColor.grey1.shade300,
                                    progressColor: isdark == true
                                        ? AppColor.appColorSecondaryValue
                                        : AppColor.grey600,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "0%",
                                    style: TextStyle(
                                        color: isdark == true
                                            ? AppColor.white
                                            : AppColor.appColorSecondaryValue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            color: isdark == true
                                ? AppColor.mainbg
                                : AppColor.white,
                          ),
                        ),
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            color: isdark == true
                                ? AppColor.mainbg
                                : AppColor.white,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/book.png",
                                    color: isdark == true
                                        ? AppColor.white
                                        : AppColor.appColorPrimaryValue,
                                    width: 30,
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " ",
                                    style: TextStyle(
                                        color: isdark == true
                                            ? AppColor.appColorPrimaryValue
                                            : AppColor.grey600,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  LinearPercentIndicator(
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    lineHeight: 14.0,
                                    percent: 0,
                                    barRadius: Radius.circular(10),
                                    backgroundColor: AppColor.grey1.shade300,
                                    progressColor: isdark == true
                                        ? AppColor.appColorSecondaryValue
                                        : AppColor.grey600,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "0%",
                                    style: TextStyle(
                                        color: isdark == true
                                            ? AppColor.white
                                            : AppColor.appColorSecondaryValue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addata() {
    return InkWell(
      onTap: () {
        Navigator.push(context, SlideRightRoute(widget: DonateButtonScreen()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: isdark == true
            ? Image.asset(
                "assets/images/monthlydark.png",
                fit: BoxFit.fill,
              )
            : Image.asset(
                "assets/images/monthly.png",
                fit: BoxFit.fill,
              ),
      ),
    );
  }

  Widget addata1() {
    return InkWell(
      onTap: () {
        Navigator.push(context, SlideRightRoute(widget: SponsorModuleScreen()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3,
        child: isdark == true
            ? Image.asset(
                "assets/images/sponsormoduledark.png",
                fit: BoxFit.fill,
              )
            : Image.asset(
                "assets/images/sponsormodule.png",
                fit: BoxFit.fill,
              ),
      ),
    );
  }

  Widget bookdata() {
    return Card(
      margin: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      )),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            color: AppColor.grey1.shade400),
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            color: isdark == true ? AppColor.grey1.shade800 : AppColor.white,
          ),
          child: bookStatsModel!.length != 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tanach",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: isdark == true
                                ? AppColor.white
                                : AppColor.grey600)),
                    SizedBox(
                      height: 2,
                    ),
                    Text(bookStatsModel?.first.typeOfBook ?? "Nevi``m",
                        style: TextStyle(
                            color: AppColor.appColorSecondaryValue,
                            fontSize: 22,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 2,
                    ),
                    Text("how much i need",
                        style: TextStyle(
                            color: AppColor.grey1.shade500, fontSize: 18)),
                    SizedBox(
                      height: 10,
                    ),
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width / 1.3,
                      lineHeight: 15.0,
                      percent:
                          ((bookStatsModel?.first.percentCompleted ?? 0) * 100),
                      widgetIndicator: CircleAvatar(
                        backgroundColor: isdark == true
                            ? AppColor.appColorPrimaryValue
                            : AppColor.appColorSecondaryValue,
                        radius: 15,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: AppColor.white,
                        ),
                      ),
                      animateFromLastPercent: true,
                      center: Text(
                        "${((bookStatsModel?.first.percentCompleted ?? 0) * 100).round()}%",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      alignment: MainAxisAlignment.start,
                      barRadius: Radius.circular(10),
                      backgroundColor: isdark == true
                          ? AppColor.white
                          : AppColor.grey1.shade300,
                      progressColor: isdark == true
                          ? AppColor.appColorPrimaryValue
                          : AppColor.grey600,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "0%",
                          style:
                              TextStyle(color: AppColor.appColorPrimaryValue),
                        ),
                        Text(
                          "100%",
                          style:
                              TextStyle(color: AppColor.appColorPrimaryValue),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                            "${bookStatsModel?.first.noMissing ?? 0} missing books",
                            style: TextStyle())),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tanach",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: isdark == true
                                ? AppColor.white
                                : AppColor.grey600)),
                    SizedBox(
                      height: 2,
                    ),
                    Text("Nevi``m",
                        style: TextStyle(
                            color: AppColor.appColorSecondaryValue,
                            fontSize: 22,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 2,
                    ),
                    Text("how much i need",
                        style: TextStyle(
                            color: AppColor.grey1.shade500, fontSize: 18)),
                    SizedBox(
                      height: 10,
                    ),
                    LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width / 1.3,
                      lineHeight: 15.0,
                      percent: 0,
                      widgetIndicator: CircleAvatar(
                        backgroundColor: isdark == true
                            ? AppColor.appColorPrimaryValue
                            : AppColor.appColorSecondaryValue,
                        radius: 15,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: AppColor.white,
                        ),
                      ),
                      animateFromLastPercent: true,
                      center: Text(
                        "0%",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      alignment: MainAxisAlignment.start,
                      barRadius: Radius.circular(10),
                      backgroundColor: isdark == true
                          ? AppColor.white
                          : AppColor.grey1.shade300,
                      progressColor: isdark == true
                          ? AppColor.appColorPrimaryValue
                          : AppColor.grey600,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "0%",
                          style:
                              TextStyle(color: AppColor.appColorPrimaryValue),
                        ),
                        Text(
                          "100%",
                          style:
                              TextStyle(color: AppColor.appColorPrimaryValue),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text("0 missing books", style: TextStyle())),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget bookreport() {
    return InkWell(
      onTap: () {
        // Navigator.push(context, SlideRightRoute(
        //     widget: BillingAddressScreen())
        // );
      },
      child: Card(
        margin: EdgeInsets.only(left: 20, right: 20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        )),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: AppColor.grey1.shade400),
          // margin: EdgeInsets.only(left: 20,right: 20),
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: isdark == true ? AppColor.grey1.shade800 : AppColor.white,
            ),
            child: torahModel?.length != 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Torah",
                          style: TextStyle(
                              color: isdark == true
                                  ? AppColor.appColorPrimaryValue
                                  : AppColor.appColorSecondaryValue,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 2,
                      ),
                      Text("How many Parshas have you completed?",
                          style: TextStyle(
                              color: isdark == true
                                  ? AppColor.white
                                  : AppColor.grey1.shade500,
                              fontSize: 16)),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: torahModel?.length,
                            itemBuilder: (context, index) {
                              TorahModel? item = torahModel?[index];
                              return torahListTile(item);
                            },
                          ),
                          Positioned(
                            left: 0.0,
                            child: Container(
                              color: Colors.transparent.withOpacity(0),
                              width: 350,
                              height: 400,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Torah",
                          style: TextStyle(
                              color: isdark == true
                                  ? AppColor.appColorPrimaryValue
                                  : AppColor.appColorSecondaryValue,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 2,
                      ),
                      Text("How many Parshas have you completed?",
                          style: TextStyle(
                              color: isdark == true
                                  ? AppColor.white
                                  : AppColor.grey1.shade500,
                              fontSize: 16)),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget torahListTile(TorahModel? item) {
    return Column(
      children: [
        ListTile(
          leading: Image.asset(
            "assets/images/book.png",
            color:
                isdark == true ? AppColor.white : AppColor.appColorPrimaryValue,
            width: 30,
            height: 40,
          ),
          title: Text(
            item?.bookName ?? "",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${item?.noTotal} Parshas",
              style: TextStyle(
                  color: AppColor.appColorSecondaryValue, fontSize: 14)),
          trailing: Container(
            height: 30,
            width: 50,
            decoration: BoxDecoration(
                color: AppColor.appColorSecondaryValue,
                borderRadius: BorderRadius.circular(20)),
            child: Icon(
              Icons.done,
              color: AppColor.white,
            ),
          ),
        ),
        LinearPercentIndicator(
          lineHeight: 15.0,
          percent: ((item?.percentCompleted ?? 0) * 100),
          animateFromLastPercent: true,
          alignment: MainAxisAlignment.start,
          barRadius: Radius.circular(10),
          backgroundColor: AppColor.grey1.shade300,
          progressColor: isdark == true
              ? AppColor.appColorSecondaryValue
              : AppColor.grey600,
        ),
      ],
    );
  }

  Widget bookstatistic() {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Image.asset(
          "assets/images/table1.png",
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
        ));
  }

  Widget achievement() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Text(
            "Achievements",
            style: TextStyle(
                color: isdark == true
                    ? AppColor.appColorPrimaryValue
                    : AppColor.appColorSecondaryValue,
                fontSize: 22,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Feel proud of your milestones",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 20,
          ),
          achievementsStudyModel != null && achievementsStudyModel!.length != 0
              ? Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: achievementsStudyModel?.length,
                    itemBuilder: (context, index) {
                      AchievementsStudyModel item =
                          achievementsStudyModel![index];
                      return achievmentsStudyUI(item);
                    },
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/deuteronomy.png",
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        " ",
                        style: TextStyle(
                            color: isdark == true
                                ? AppColor.white
                                : AppColor.appColorPrimaryValue,
                            fontSize: 16),
                      ),
                      Text(
                        " ",
                        style: TextStyle(
                            color: isdark == true
                                ? AppColor.white
                                : AppColor.appColorPrimaryValue,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Padding achievmentsStudyUI(AchievementsStudyModel achievementsStudy) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Image.asset(
            "assets/images/deuteronomy.png",
            height: 100,
            fit: BoxFit.fill,
          ),
          Text(
            achievementsStudy.bookName,
            style: TextStyle(
                color: isdark == true
                    ? AppColor.white
                    : AppColor.appColorPrimaryValue,
                fontSize: 16),
          ),
          Text(
            achievementsStudy.typeOfBook,
            style: TextStyle(
                color: isdark == true
                    ? AppColor.white
                    : AppColor.appColorPrimaryValue,
                fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget leadershipboard() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      )),
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            color: AppColor.grey1.shade400),
        // margin: EdgeInsets.only(left: 20,right: 20),
        width: MediaQuery.of(context).size.width,
        child: Container(
          // margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(10),
                // bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: isdark == true ? AppColor.grey1.shade800 : Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Leadership Board",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: isdark == true
                        ? AppColor.appColorPrimaryValue
                        : AppColor.appColorSecondaryValue,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Check the best listeners, the best track and the best placements in the last week",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Map",
                style: TextStyle(
                    color: isdark == true
                        ? AppColor.appColorSecondaryValue
                        : AppColor.appColorPrimaryValue),
              )),
              SizedBox(
                height: 5,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: isdark == true ? Colors.transparent : AppColor.white,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.only(left: 1, right: 1),
                  child: SfMaps(
                    layers: <MapLayer>[
                      MapShapeLayer(
                        source: _dataSource,
                        initialMarkersCount: 3,
                        color: isdark == true
                            ? AppColor.grey1.shade300
                            : AppColor.mainbg,

                        // showDataLabels: true,
                        // legend: const MapLegend(MapElement.shape),
                        // tooltipSettings: MapTooltipSettings(
                        //     color: Colors.grey[700],
                        //     strokeColor: Colors.white,
                        //     strokeWidth: 2),

                        strokeColor: AppColor.white,
                        // strokeWidth: 0.5,

                        markerBuilder: (BuildContext context, int index) {
                          return MapMarker(
                            latitude: _data[index].latitude,
                            longitude: _data[index].longitude,
                            child: _iconsList[index],
                          );
                        },
                      ),
                    ],
                  ),
                )),
              ),
              /*Image.asset(
                "assets/images/map.png", fit: BoxFit.fill,
                // width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
              ),*/
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.white
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 120,
                endIndent: 120,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Locations",
                    ),
                    Text(
                      "See All",
                      style: TextStyle(color: AppColor.appColorPrimaryValue),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.white
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Last 7 Days",
                        style:
                            TextStyle(color: AppColor.appColorSecondaryValue)),
                    Text(
                      "Plays",
                      style: TextStyle(color: AppColor.appColorSecondaryValue),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                  leading: Container(
                      decoration: BoxDecoration(
                          color: isdark == true
                              ? AppColor.mainbg
                              : AppColor.grey1.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.all(5),
                      child: Image.asset(
                        "assets/images/usa.png",
                        fit: BoxFit.fill,
                        height: 30,
                        width: 30,
                      )),
                  title: Text(
                    "Valey Stream",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "200",
                    style: TextStyle(color: AppColor.appColorPrimaryValue),
                  )),
              SizedBox(
                height: 3,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.white
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 3,
              ),
              ListTile(
                  leading: Container(
                      decoration: BoxDecoration(
                          color: isdark == true
                              ? AppColor.mainbg
                              : AppColor.grey1.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.all(5),
                      child: Image.asset(
                        "assets/images/cn.png",
                        fit: BoxFit.fill,
                        height: 30,
                        width: 30,
                      )),
                  title: Text(
                    "New York",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "15",
                    style: TextStyle(color: AppColor.appColorPrimaryValue),
                  )),
              SizedBox(
                height: 3,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.white
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 3,
              ),
              ListTile(
                  leading: Container(
                      decoration: BoxDecoration(
                          color: isdark == true
                              ? AppColor.mainbg
                              : AppColor.grey1.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.all(5),
                      child: Image.asset(
                        "assets/images/un.png",
                        fit: BoxFit.fill,
                        height: 30,
                        width: 30,
                      )),
                  title: Text(
                    "Tel Aviv",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "5",
                    style: TextStyle(color: AppColor.appColorPrimaryValue),
                  )),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 2,
                color: isdark
                    ? AppColor.white
                    : Colors.blueAccent.shade700.withOpacity(0.2),
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sponsor() {
    return Card(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: AppColor.grey1.shade400),
        // margin: EdgeInsets.only(left: 20,right: 20),
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              // bottomLeft: Radius.circular(10),
              // bottomRight: Radius.circular(10),
            ),
            color: isdark == true ? AppColor.grey1.shade800 : AppColor.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: ClipPathValue(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        color: AppColor.appColorPrimaryValue,
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text("The Tanach Yomi App is Sponsored by",
                            style:
                                TextStyle(fontSize: 16, color: AppColor.white),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width / 1.28,
                    child: Container(
                      height: 2,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 3,
                            offset: Offset(1, 4), // Shadow position
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                  "The Henry, Bertha and Edward Rothman Foundation Rochester NY Circleville OH Cleveland OH",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: isdark == true
                          ? AppColor.white
                          : AppColor.grey1.shade500,
                      fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget sponsordialog() {
    print("hello sponsor dialog");
    return Scaffold(
      // appBar: AppBar(title: Text("donate"),),
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.transparent,
        child: Card(
          elevation: 10,
          margin: EdgeInsets.only(top: 25.0, right: 15, left: 15, bottom: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width,
                          child: isdark == true
                              ? Image.asset(
                                  "assets/images/amicodark.png",
                                  alignment: Alignment.bottomCenter,
                                )
                              : Image.asset(
                                  "assets/images/amico.png",
                                  alignment: Alignment.bottomCenter,
                                ),
                        ),
                        Positioned(
                            left: 15,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  endIndent: 20,
                  indent: 20,
                  color: isdark == true
                      ? AppColor.white
                      : Colors.blueAccent.shade700.withOpacity(0.2),
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "SPONSOR",
                    style: TextStyle(
                        color: isdark == true
                            ? AppColor.appColorPrimaryValue
                            : AppColor.appColorSecondaryValue,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Center(
                    child: Text(
                      "Become a sponsor of this \n day of learning for an \n amount of",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  endIndent: 120,
                  indent: 120,
                  color: isdark == true
                      ? AppColor.white
                      : Colors.blueAccent.shade700.withOpacity(0.2),
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    // margin: EdgeInsets.only(left: 15, right: 15),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: isdark == true
                          ? AppColor.mainbg
                          : AppColor.grey1.shade100,
                      // borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      decoration: BoxDecoration(
                          color: isdark == true
                              ? AppColor.grey1.shade800
                              : AppColor.white,
                          border: Border.all(
                              color: isdark == true
                                  ? AppColor.white
                                  : AppColor.grey1.shade300),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        children: [
                          Center(
                            child: Text("\$180",
                                style: TextStyle(
                                    color: isdark == true
                                        ? AppColor.white
                                        : AppColor.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20)),
                          ),
                          Center(
                            child: Text("Per day",
                                style: TextStyle(
                                    color: AppColor.appColorSecondaryValue,
                                    fontSize: 14)),
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 2,
                  endIndent: 120,
                  indent: 120,
                  color: isdark == true
                      ? AppColor.white
                      : Colors.blueAccent.shade700.withOpacity(0.2),
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    // height: 100,
                    padding: EdgeInsets.only(left: 10, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: isdark == true
                                ? AppColor.white
                                : Colors.grey.withOpacity(0.2))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            "Message Sponsored by",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColor.appColorPrimaryValue),
                          ),
                        ),
                        TextFormField(
                          cursorColor: AppColor.black,
                          controller: surveyTextController,
                          maxLines: 3,
                          // minLines: 1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.multiline,
                          inputFormatters: [NoLeadingSpaceFormatter()],
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 8),
                            // constraints: BoxConstraints.tight(Size.fromHeight(40)),
                            border: InputBorder.none,
                            labelStyle:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: AppColor.grey600,
                                      fontSize: 24.0,
                                    ),
                          ),

                          textInputAction: TextInputAction.done,
                          // focusNode: secondFocusNode,
                          validator: (value) {
                            return Validator.validateFormField(
                                value,
                                "message is required",
                                null,
                                Constants.NORMAL_VALIDATION);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 2,
                  endIndent: 120,
                  indent: 120,
                  color: isdark == true
                      ? AppColor.white
                      : Colors.blueAccent.shade700.withOpacity(0.2),
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // elevation: MaterialStateProperty.all(0.0),
                      padding: const EdgeInsets.all(10.0),
                      primary: isdark == true
                          ? AppColor.appColorSecondaryValue
                          : AppColor.grey600,
                      shadowColor: isdark == true
                          ? AppColor.appColorSecondaryValue
                          : AppColor.grey600,
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          SlideRightRoute(widget: BillingAddressScreen()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width / 1.15,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/coins.png",
                              height: 20,
                              width: 30,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Sponsor Now",
                              style: TextStyle(color: AppColor.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleBackPress() {
    if (isBack) {
      exit(0);
    } else {
      isBack = true;
      showToast(
        "press again for back",
        context: context,
        animation: StyledToastAnimation.fadeScale,
        backgroundColor: AppColor.appColorPrimaryValue,
      );
    }

    Timer(const Duration(seconds: 3), () => isBack = false);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.grey,
            splashColor: Colors.black,
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black),
            ),
            colorScheme: ColorScheme.light(
              primary: AppColor.appColorPrimaryValue,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? Text(""),
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(date.year + 100),
    );

    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        String pick = DateUtil().LocalFormat(date.toString(), "dd-MM-yyyy");
        birthDateTextController.text = pick;
      });
      saveUpdatedDate(date);
    }
  }

  Widget fourthLayout() {
    return Card(
      margin: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      )),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            color: AppColor.grey1.shade400),
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: isGood == true
              ? MediaQuery.of(context).size.height / 2.0
              : MediaQuery.of(context).size.height / 2.15,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          margin: EdgeInsets.only(bottom: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: isdark == true ? AppColor.grey1.shade800 : Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(right: 10),
                margin: EdgeInsets.only(top: 10),
                child: RichText(
                  text: new TextSpan(
                    text: 'Statistics',
                    style: TextStyle(
                      color: isdark == true
                          ? AppColor.appColorPrimaryValue
                          : AppColor.appColorSecondaryValue,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                    children: [
                      new TextSpan(
                        text: '\nDaily reading progress',
                        style: TextStyle(
                          color: AppColor.grey1.shade500,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 3.4,
                child: Stack(
                  children: [
                    SfCartesianChart(
                      primaryYAxis: NumericAxis(
                        minimum: 0,
                        maximum: 70,
                        interval: 10,
                        axisLine: AxisLine(
                            color:
                                isdark ? AppColor.grey1.shade800 : Colors.white,
                            width: 1),
                        majorTickLines: MajorTickLines(width: 0),
                        majorGridLines: MajorGridLines(
                            width: 0.5,
                            color: isdark ? Colors.white : AppColor.grey1),
                        labelFormat: '{value}min',
                        edgeLabelPlacement: EdgeLabelPlacement.hide,
                      ),
                      primaryXAxis: NumericAxis(
                        minimum: 0,
                        maximum: 10,
                        interval: 1,
                        axisLine: AxisLine(
                            width: 0.5,
                            color: isdark
                                ? AppColor.white
                                : AppColor.grey1.shade600),
                        majorTickLines: MajorTickLines(width: 0),
                        labelStyle:
                            TextStyle(color: AppColor.appColorSecondaryValue),
                        edgeLabelPlacement: EdgeLabelPlacement.hide,
                        majorGridLines: MajorGridLines(
                            width: 1,
                            color: isdark
                                ? AppColor.grey1.shade800
                                : AppColor.white),
                      ),
                      tooltipBehavior: _tooltip,
                      margin: EdgeInsets.all(0),
                      series: <ChartSeries<GraphChartData, double>>[
                        ColumnSeries<GraphChartData, double>(
                            dataSource: graphdata,
                            xValueMapper: (GraphChartData data, _) {
                              return data.x;
                            },
                            yValueMapper: (GraphChartData data, _) {
                              return data.y;
                            },
                            name: 'Book',
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            trackBorderWidth: 0,
                            width: 0.2,
                            spacing: 2.2,
                            trackPadding: 1,
                            pointColorMapper: (GraphChartData data, _) =>
                                data.color),
                      ],
                    ),
                    Positioned(
                      left: 1,
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                                color: isdark
                                    ? AppColor.grey1
                                    : AppColor.grey1.shade600,
                                height: 1,
                                endIndent: 55,
                                indent: 1,
                                thickness: 1),
                            SizedBox(
                              height: isGood == true ? 4 : 6.4,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 1.0),
                              child: Text(
                                "Daily",
                                style: TextStyle(
                                    color: isdark
                                        ? AppColor.white
                                        : AppColor.grey1.shade600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width / 1.2,
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: 15,
                      decoration: BoxDecoration(
                          color: AppColor.appColorSecondaryValue,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "audio study time",
                      style: TextStyle(
                          color: AppColor.grey1.shade400, fontSize: 12),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 5,
                      width: 15,
                      decoration: BoxDecoration(
                          color: AppColor.appColorPrimaryValue,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "reading study time",
                      style: TextStyle(
                          color: AppColor.grey1.shade400, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                dateFormat(),
                style: TextStyle(color: AppColor.grey1.shade400, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? graphcolor(int index) {
    if (index == 0) {
      return AppColor.appColorPrimaryValue;
    } else if (index == 8) {
      return AppColor.appColorSecondaryValue;
    } else {
      return AppColor.grey1.shade400;
    }
  }

  FutureOr getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs!.getInt(Constants.prefUserIdKeyInt);
    imgGuid = prefs!.getString(Constants.prefUserGuid);
    // isdark = prefs!.getBool(Constants.isDarkMode)!;
    print("UserId::" + userid.toString());
    print("GuidId::" + imgGuid.toString());
    // print("DarkTheme::" + isdark.toString());
  }

  internetConnection() async {
    isInternet = await Constants.isInternetAvailable();
    isLoading = isInternet;
    setState(() {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  callApi() async {
    if (isInternet == null) {
      isInternet = await internetConnection();
    }

    if (isInternet == true) {
      await getSharedPreferences();
      try {
        await callApiForWeekData();
        await callApiDashboardAll();
      } catch (e) {}
      isLoading = false;
      setState(() {});
    }
  }

  FutureOr<void> callApiForWeekData() async {
    try {
      String date = DateTime.now().toString();
      List datenew = date.split(" ");
      String? strJson = UserModel.addCurrentDate(datenew[0].toString());
      reference.requestParam = strJson;
      reference.shouldIParse = false;
      await ApiHandler.callApiForWeekContent(reference);
      if (reference.isError) {
        reference.isError = false;
      } else {
        try {
          weeklist = reference.responseParam;
          print('object');
        } catch (e) {}
      }
    } catch (e) {
      // TODO
    }
  }

  FutureOr<void> saveUpdatedDate(DateTime date) async {
    CommonsParameter parameter =
        CommonsParameter(membersId: CurrentUserInfo.currentUserId);
    reference.requestParam = parameter;
    reference.shouldIParse = true;
    await ApiHandler.saveUpdatedDate(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        //dailyChartModel = reference.responseParam;
      } catch (e) {}
    }
  }

  DateTime startDate(String date) {
    DateTime localDate = DateTime.now();
    try {
      localDate = DateFormat('MM/dd/yyyy').parse(date);
    } catch (e) {
      localDate = DateFormat('MM/dd/yyyy').parse(date);
    }
    return localDate;
  }

  String dateFormat() {
    return DateFormat('MM/dd/yyyy').format(DateTime.now());
  }

  FutureOr<void> callApiDashboardAll() async {
    CommonsParameter parameter =
        CommonsParameter(membersId: CurrentUserInfo.currentUserId);
    reference.requestParam = parameter;
    reference.shouldIParse = true;
    await ApiHandler.callApiDashboardAll(reference);
    if (reference.isError) {
      reference.isError = false;
      isLoading = false;
    } else {
      try {
        DashboardAllModel dashboardAllModel = reference.responseParam;
        await Future.delayed(Duration(milliseconds: 10));
        await setupDailyChart(dashboardAllModel);
        await Future.delayed(Duration(milliseconds: 10));
        await setupTorah(dashboardAllModel);
        await Future.delayed(Duration(milliseconds: 10));
        await setupPartialStats(dashboardAllModel);
        await Future.delayed(Duration(milliseconds: 10));
        await setupCurrentBookStats(dashboardAllModel);
        await Future.delayed(Duration(milliseconds: 10));
        await setupBookStats(dashboardAllModel);
        await Future.delayed(Duration(milliseconds: 10));
        await setupAchievement(dashboardAllModel);
        await Future.delayed(Duration(milliseconds: 10));
      } catch (e) {}
    }
  }

  Future<void> setupCurrentBookStats(
      DashboardAllModel dashboardAllModel) async {
    if (dashboardAllModel.currentBookStats != null &&
        dashboardAllModel.currentBookStats!.length > 0) {
      currentBookStatsModel = dashboardAllModel.currentBookStats![0];
    } else {
      currentBookStatsModel = CurrentBookStat();
    }
  }

  Future<void> setupPartialStats(DashboardAllModel dashboardAllModel) async {
    partialStatsModel = dashboardAllModel.partialStats;
  }

  Future<void> setupTorah(DashboardAllModel dashboardAllModel) async {
    torahModel = dashboardAllModel.torah;
  }

  Future<void> setupBookStats(DashboardAllModel dashboardAllModel) async {
    bookStatsModel = dashboardAllModel.bookStats;
  }

  Future<void> setupDailyChart(DashboardAllModel dashboardAllModel) async {
    dailyChartModel = dashboardAllModel.dailyChart;
    graphdata = [];
    if (dailyChartModel != null)
      for (int i = 0; i < dailyChartModel!.length; i++) {
        graphdata.add(
          GraphChartData(
              dailyChartModel![i].noOfMinutesAudio!.toDouble(),
              dailyChartModel![i].noOfMinutesRead!.toDouble(),
              AppColor.appColorPrimaryValue),
        );
      }
  }

  Future<void> setupAchievement(DashboardAllModel dashboardAllModel) async {
    achievementsStudyModel = dashboardAllModel.achievementsStudyModel;
  }
}
