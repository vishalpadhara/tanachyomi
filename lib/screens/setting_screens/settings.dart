import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanachyomi/config/config.dart';
import 'package:tanachyomi/models/bookmodel.dart';
import 'package:tanachyomi/models/memberInfoModel.dart';
import 'package:tanachyomi/models/userinfomodel.dart';
import 'package:tanachyomi/models/usermodel.dart';
import 'package:tanachyomi/parsers/profile_parser.dart';
import 'package:tanachyomi/screens/login_screen.dart';
import 'package:tanachyomi/screens/setting_screens/information_screen.dart';
import 'package:tanachyomi/screens/setting_screens/notification_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/dateutil.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import '../../apis/apihandler.dart';
import '../../apis/common_paramters.dart';
import '../../apis/primitive_wrapper.dart';
import '../../models/list_chapters_model.dart';
import '../../models/list_of_chapters_in_book.dart';
import '../../models/newUserInfoModel.dart';
import '../../utils/current_userinfo.dart';
import '../errorscreenpage.dart';
import '../no_internet_screen.dart';
import '../please_wait_loader.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ReferenceWrapper reference = ReferenceWrapper(null, null);
  bool? isLoading = true;
  bool? isSwitched = false;
  int? userid;
  NewUserInfoModel? newUserInfoModel;
  bool? isInternet;
  bool isError = false;
  int? gmailconnect = 0;
  int? facebookconnect = 0;
  int? linkedinconnect = 0;
  SharedPreferences? prefs;

  DateTime date = DateTime.now();
  String? StartDate;
  String? bookName = "";
  String? chaptersName = "";
  int? chaptersId;
  int? bookId;

  //Resources Api
  int? Chapters_Id;
  int? Book_Id;
  int? CycleType = 7;
  bool? isCycleType = false;
  bool? IsNotify = true;
  String? selectedTime;
  List<ListOfChaptersModel>? listOfChaptersModel;
  List<BookModel>? booklist;
  BookModel? bookmodel;

  @override
  void initState() {
    internetConnection();
    super.initState();
    StartDate = DateUtil().DateToString(date, DateUtil.DATE_FORMAT6);
    selectedTime = DateUtil().DateToString(date, DateUtil.DATE_FORMAT12);
  }

  @override
  Widget build(BuildContext context) {
    return layout();
  }

  Consumer<ThemeNotifier> layoutMain() {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) {
        isSwitched = theme.getTheme() == theme.darkTheme ? true : false;
        return newUserInfoModel != null
            ? Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Settings",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColor.appColorSecondaryValue,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  backgroundColor:
                      isSwitched == true ? AppColor.white : AppColor.white,
                ),
                body: SafeArea(
                  child: Container(
                    // color: AppColor.grey1.shade50,
                    color: isSwitched == true
                        ? AppColor.grey1.shade800
                        : AppColor.grey1.shade50,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        AccountSection(),
                        SizedBox(
                          height: 20,
                        ),
                        PreferenceSection(theme),
                        SizedBox(
                          height: 20,
                        ),
                        InformationSection(),
                        SizedBox(
                          height: 20,
                        ),
                        SaveButton(),
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Settings",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColor.appColorSecondaryValue,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  backgroundColor:
                      isSwitched == true ? AppColor.white : AppColor.white,
                ),
                body: SafeArea(
                  child: Container(
                    // color: AppColor.grey1.shade50,
                    color: isSwitched == true
                        ? AppColor.grey1.shade800
                        : AppColor.grey1.shade50,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        AccountSection(),
                        SizedBox(
                          height: 20,
                        ),
                        PreferenceSection(theme),
                        SizedBox(
                          height: 20,
                        ),
                        InformationSection(),
                        SizedBox(
                          height: 20,
                        ),
                        SaveButton(),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget AccountSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width,
            height: 30,
            color:
                isSwitched == true ? AppColor.mainbg : AppColor.grey1.shade100,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("ACCOUNT",
                    style: TextStyle(fontSize: 16), textAlign: TextAlign.left)),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "No Email Found",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, SlideRightRoute(widget: NotificationScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, bottom: 15.0, top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notification",
                    style: TextStyle(
                        color: AppColor.appColorSecondaryValue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color:
                        isSwitched == true ? AppColor.white : AppColor.grey600,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
        ],
      ),
    );
  }

  Widget PreferenceSection(ThemeNotifier theme) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width,
            height: 30,
            color:
                isSwitched == true ? AppColor.mainbg : AppColor.grey1.shade100,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("PREFERENCES",
                    style: TextStyle(fontSize: 16), textAlign: TextAlign.left)),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enable Dark Mode",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                FlutterSwitch(
                  width: 40.0,
                  height: 20.0,
                  toggleSize: 10.0,
                  value: isSwitched!,
                  borderRadius: 30.0,
                  padding: 5.0,
                  toggleColor:
                      isSwitched == true ? AppColor.mainbg : AppColor.white,
                  activeColor:
                      isSwitched == true ? AppColor.white : AppColor.mainbg,
                  inactiveColor:
                      isSwitched == true ? AppColor.white : AppColor.mainbg,
                  onToggle: (val) {
                    theme.getTheme() == theme.darkTheme
                        ? theme.setLightMode()
                        : theme.setDarkMode();
                    setDarkMode(val);
                    setState(() {
                      isSwitched = val;
                    });
                  },
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 15.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Start Date",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Text(
                    StartDate != null ? StartDate.toString() : "",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 15.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sefer",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    _DialogForBookList();
                  },
                  child: Text(
                    bookName != null
                        ? bookName.toString()
                        : bookName.toString(),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 15.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Perek",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    _DialogForChaptersList();
                  },
                  child: Text(
                    chaptersName != null ? chaptersName.toString() : "",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 15.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cycle Type",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    if (isCycleType == false) {
                      isCycleType = true;
                      CycleType = 5;
                    } else {
                      isCycleType = false;
                      CycleType = 7;
                    }
                    setState(() {});
                  },
                  child: Text(
                    "${CycleType} days",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 15.0, top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Turn Notification",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    if (IsNotify == false) {
                      IsNotify = true;
                    } else {
                      IsNotify = false;
                    }
                    setState(() {});
                  },
                  child: Text(
                    IsNotify == true ? "ON" : "OFF",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          IsNotify == true
              ? Divider(
                  height: 2,
                  endIndent: 10,
                  indent: 10,
                  color: isSwitched == true
                      ? AppColor.grey1.shade500
                      : Colors.blueAccent.shade700.withOpacity(0.2),
                  thickness: 1.0,
                )
              : Container(),
          IsNotify == true
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 15.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Time",
                        style: TextStyle(
                            color: AppColor.appColorSecondaryValue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          _show();
                        },
                        child: Text(
                          selectedTime != null ? selectedTime.toString() : "",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          )
        ],
      ),
    );
  }

  Future<void> _show() async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
    );
    if (result != null) {
      setState(() {
        selectedTime = result.format(context);
      });
    }
  }

  _selectDate(BuildContext context) async {
    print("Current Date::" + DateTime.now().toString());
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
        initialDate: DateTime.now() /*inputDate != null ? inputDate : date*/,
        firstDate: DateTime(date.year - 250),
        lastDate: DateTime.now());

    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        StartDate = DateUtil().LocalFormat(date.toString(), "dd-MM-yyyy");
      });
      saveUpdatedDate(date);
    }
  }

  setDarkMode(bool? isDark) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(Constants.isDarkMode, isDark!);
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  _DialogForBookList() {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          color: AppColor.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  for (int i = 0; i < booklist!.length; i++) {
                    if (bookId == i) {
                      bookName = booklist![i].name;
                      Book_Id = booklist![i].id;
                      print(bookName.toString());
                    }
                  }
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Done",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.appColorSecondaryValue),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                      initialItem: bookId != null ? bookId! : 0),
                  itemExtent: 50,
                  onSelectedItemChanged: (val) {
                    bookId = val;
                    print(bookId.toString());
                  },
                  children: booklist!.map((item) {
                    return Center(
                      child: Text(
                        item.name.toString(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _DialogForChaptersList() {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          color: AppColor.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  //String val = chaptersId.toString();
                  for (int i = 0; i < listOfChaptersModel!.length; i++) {
                    if (chaptersId == i) {
                      chaptersName = listOfChaptersModel?[i].subChapter;
                      Chapters_Id = listOfChaptersModel?[i].chaptersId;
                      print(chaptersName.toString());
                    }
                  }
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Done",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.appColorSecondaryValue),
                ),
              ),
              bookmodel != null
                  ? Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                            initialItem: chaptersId != null ? chaptersId! : 0),
                        itemExtent: 50,
                        onSelectedItemChanged: (val) {
                          chaptersId = val;
                          print(chaptersId.toString());
                        },
                        children: listOfChaptersModel!.map((item) {
                          return Center(
                            child: Text(
                              item.subChapter.toString(),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  Widget InformationSection() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10.0),
            width: MediaQuery.of(context).size.width,
            height: 30,
            color: isSwitched == true ? AppColor.mainbg : AppColor.grey1.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("INFORMATION", style: TextStyle(fontSize: 16)),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  InformationScreen()));
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: isSwitched == true
                          ? AppColor.white
                          : AppColor.grey600,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gmail Account",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                (gmailconnect == 1)
                    ? Text("Connected", style: TextStyle(color: Colors.green))
                    : Text(
                        "Not Connected",
                        style: TextStyle(color: Colors.red),
                      ),
              ],
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Facebook Account",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                (facebookconnect == 1)
                    ? Text("Connected", style: TextStyle(color: Colors.green))
                    : Text(
                        "Not Connected",
                        style: TextStyle(color: Colors.red),
                      ),
              ],
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Linkedin Account",
                  style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                (linkedinconnect == 1)
                    ? Text("Connected", style: TextStyle(color: Colors.green))
                    : Text(
                        "Not Connected",
                        style: TextStyle(color: Colors.red),
                      ),
              ],
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
            child: InkWell(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                Navigator.push(context, SlideRightRoute(widget: LoginScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Log out",
                    style: TextStyle(
                        color: AppColor.appColorSecondaryValue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.logout,
                    color:
                        isSwitched == true ? AppColor.white : AppColor.grey600,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 2,
            endIndent: 10,
            indent: 10,
            color: isSwitched == true
                ? AppColor.grey1.shade500
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1.0,
          ),
        ],
      ),
    );
  }

  Widget SaveButton() {
    return Container(
      // color: Colors.teal,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(AppColor.appColorSecondaryValue)),
        onPressed: () async {
          await callApiMemberSaveSettings();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Save Changes",
              style: TextStyle(color: AppColor.white),
            ),
          ],
        ),
      ),
    );
  }

  sharedPrefenceValue() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs!.getInt(Constants.prefUserIdKeyInt);
  }

  internetConnection() async {
    isInternet = await Constants.isInternetAvailable();
    isLoading = isInternet;
    setState(() {});
  }

  Future<void> saveUpdatedDate(DateTime date) async {
    CommonsParameter parameter =
        CommonsParameter(membersId: CurrentUserInfo.currentUserId);
    reference.requestParam = parameter;
    reference.shouldIParse = true;
    await ApiHandler.saveStartDate(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        //dailyChartModel = reference.responseParam;
      } catch (e) {}
    }
  }

  DateTime studyDate(String date) {
    DateTime localDate = DateTime.now();
    try {
      localDate = DateFormat('dd/MM/yyyy').parse(date);
    } catch (e) {
      localDate = DateFormat('dd/MM/yyyy').parse(date);
    }
    return localDate;
  }

  dynamic callApiParams() {
    Map<String, dynamic> map = {
      'BooksId': Book_Id.toString(),
      'MembersId': CurrentUserInfo.currentUserId.toString(),
    };
    return map;
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

  callApi() async {
    if (isInternet == null) {
      isInternet = await internetConnection();
    }
    try {
      await sharedPrefenceValue();
      await callApiForGetUser();
      await callApiBooksListExceptTorah();
      await callApiChaptersList();
    } catch (e) {
      print('error>> ${e}');
    }
    setState(
      () {
        isLoading = false;
      },
    );
  }

  callApiForGetUser() async {
    CommonsParameter parameter =
        CommonsParameter(Id: CurrentUserInfo.currentUserId);
    reference.requestParam = parameter;
    reference.shouldIParse = true;
    await ApiHandler.callApiMemberGet(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        MemberInfoModel memberInfoModel =
            reference.responseParam as MemberInfoModel;
        gmailconnect = memberInfoModel.isSocialGmail;
        facebookconnect = memberInfoModel.isSocialFacebook;
        linkedinconnect = memberInfoModel.isSocialLinkedIn;
      } catch (e) {}
    }
  }

  Future<void> callApiBooksListExceptTorah() async {
    CommonsParameter parameter =
        CommonsParameter(membersId: CurrentUserInfo.currentUserId);
    reference.requestParam = parameter;
    reference.shouldIParse = true;
    await ApiHandler.callApiBooksListExceptTorah(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        booklist = reference.responseParam;
        bookName = booklist![0].name;
        Book_Id = booklist![0].id;
      } catch (e) {}
    }
  }

  Future<void> callApiChaptersList() async {
    reference.requestParam = callApiParams();
    reference.shouldIParse = true;
    await ApiHandler.callApiForChaptersList(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        ChaptersInBookModel parashaList = reference.responseParam;
        bookmodel = parashaList.bookModel[0];
        if (parashaList.listOfChaptersModel.length > 0) {
          chaptersName = parashaList.listOfChaptersModel[0].subChapter;
          Chapters_Id = parashaList.listOfChaptersModel[0].chaptersId;
          listOfChaptersModel = parashaList.listOfChaptersModel;
        }
      } catch (e) {}
    }
  }

  callApiMemberSaveSettings() async {
    Map<String, dynamic> map = {
      "Id": userid.toString(),
      "SettingsIsDarkMode": isSwitched!,
      "SettingsStartDate": parseDate(),
      "SettingsBooksId": Book_Id!,
      "SettingsChaptersId": Chapters_Id!,
      "SettingsCycleType": CycleType!,
      "SettingsIsNotification": IsNotify!,
      "SettingsNotificationTime": selectedTime.toString(),
    };
    reference.requestParam = map;
    reference.shouldIParse = true;
    await ApiHandler.callApiMemberSaveSettings(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        newUserInfoModel = reference.responseParam;
      } catch (e) {}
    }
  }

  String parseDate() {
    DateTime localDate = DateTime.now();
    try {
      localDate = DateFormat('dd/MM/yyyy').parse(StartDate.toString());
    } catch (e) {
      localDate = DateFormat('dd/MM/yyyy').parse(StartDate.toString());
    }

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('MM/dd/yy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }
}
