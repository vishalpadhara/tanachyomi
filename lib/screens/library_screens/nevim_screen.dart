import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/models/bookmodel.dart';
import 'package:tanachyomi/screens/errorscreenpage.dart';
import 'package:tanachyomi/screens/library_screens/sub_list_of_library_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import '../../apis/apihandler.dart';
import '../../apis/common_paramters.dart';
import '../../apis/primitive_wrapper.dart';
import '../../utils/current_userinfo.dart';
import '../no_internet_screen.dart';
import '../please_wait_loader.dart';

class NevimScreen extends StatefulWidget {
  const NevimScreen({Key? key}) : super(key: key);

  @override
  State<NevimScreen> createState() => _NevimScreenState();
}

class _NevimScreenState extends State<NevimScreen> {
  bool isSwitched = false;
  bool isBack = false;
  List<String> name = <String>[
    "Yehoshua",
    "Shoftim",
    "I Shmuel",
    "II Shmuel",
    "I Melacim"
  ];

  List<String> description = <String>[
    "Curabitur metus leo, pulvinar nec velit id, ornare efficitur mauris.",
    "Bibendum vulputate, massa felis consectetur metus, eget commodo velit nulla ut ligula.Curabitur metus leo.",
    "Felis consectetur metus, eget commodo velit nulla ut ligula. Curabitur metus leo, pulvinar nec velit id, ornare efficitur mauris.",
    "Massa felis consectetur metus, eget commodo velit nulla ut ligula. Curabitur metus leo, pulvinar nec velit id, ornare efficitur mauris.",
    "Ligula curabitur metus leo, pulvinar nec velit id,ornare efficitur mauris."
  ];

  List<String> subName = <String>[
    "Perakim",
    "Perakim",
    "Perakim",
    "Perakim",
    "Perakim"
  ];
  List<BookModel>? listProphetsModel;
  static const _chars =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
  Random _rnd = Random();
  bool isError = false;
  bool? isInternet;
  bool? isLoading = true;

  @override
  void initState() {
    internetConnection();
    super.initState();
  }

  internetConnection() async {
    isInternet = await Constants.isInternetAvailable();
    isLoading = isInternet;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return layout();
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

    if (isInternet == true) {
      try {
        await callApiLibraryBooksListProphets();
      } catch (e) {}
      isLoading = false;
      setState(() {});
    }
  }

  Consumer<ThemeNotifier> layoutMain() {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isSwitched = theme.getTheme() == theme.darkTheme ? true : false;
      return Scaffold(
          backgroundColor:
              isSwitched == true ? AppColor.mainbg : AppColor.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listProphetsModel!.length /*name.length*/,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      SlideRightRoute(
                        widget: SubListOfLibraryScreen(
                          id: index,
                          name: listProphetsModel![index].name,
                          title: listProphetsModel![index].title,
                          bookid: listProphetsModel![index].id,
                          IsNevimScreen: true,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
                    padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: isSwitched == true
                          ? AppColor.grey1.shade800
                          : AppColor.boxback,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    listProphetsModel![index]
                                        .name
                                        .toString() /*name[index]*/,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    listProphetsModel![index].title ?? "",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: isSwitched == true
                                    ? AppColor.appColorPrimarydull
                                    : AppColor.appColorPrimaryValue,
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ));
    });
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  ReferenceWrapper reference = ReferenceWrapper(null, null);
  Future<void> callApiLibraryBooksListProphets() async {
    CommonsParameter parameter =
        CommonsParameter(membersId: CurrentUserInfo.currentUserId);
    reference.requestParam = parameter;
    reference.shouldIParse = true;
    await ApiHandler.callApiLibraryBooksListProphets(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        listProphetsModel = reference.responseParam;
      } catch (e) {}
    }
  }
}
