import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/models/bookmodel.dart';
import 'package:tanachyomi/screens/errorscreenpage.dart';
import 'package:tanachyomi/screens/library_screens/haftorah_screen.dart';
import 'package:tanachyomi/screens/library_screens/kesuvim_screen.dart';
import 'package:tanachyomi/screens/library_screens/nevim_screen.dart';
import 'package:tanachyomi/screens/library_screens/sub_list_of_library_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import '../../apis/apihandler.dart';
import '../../apis/common_paramters.dart';
import '../../apis/primitive_wrapper.dart';
import '../../models/listtorah_model.dart';
import '../../utils/current_userinfo.dart';
import '../no_internet_screen.dart';
import '../please_wait_loader.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<LibraryScreen> {
  TabController? _tabController;
  bool isSwitched = false;
  bool isSelected = false;
  bool isBack = false;
  bool isError = false;
  bool? isInternet;
  bool? isLoading = true;
  int currentIndex = 0;
  List<BookModel>? listTorahModel;

  ReferenceWrapper reference = ReferenceWrapper(null, null);
  List<String> name = <String>[
    "Genesis",
    "Leviticus",
    "Deuteronomy",
    "Exodus",
    "Numbers"
  ];

  List<String> description = <String>[
    "Creation, the beginning of mankind, and stories of the patriarchs and matriarchs.",
    "Laws of sacrificial worship in the Mishkan (Tabernacle), ritual purity, and other topics like agriculture, ethics, and holidays",
    "Moses’ final speeches, recalling events of the desert, reviewing old laws, introducing new ones, and calling for faithfulness to God.",
    "The Israelites’ enslavement in Egypt, miraculous redemption, the giving of the Torah, and building of the Mishkan (Tabernacle).",
    "Wanderings of the Israelites in the desert, census, rebellion, spies and war, interspersed with laws."
  ];

  List<String> subName = <String>[
    "Perakim",
    "Perakim",
    "Perakim",
    "Perakim",
    "Perakim"
  ];

  static const _chars =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
  Random _rnd = Random();

  @override
  void initState() {
    internetConnection();
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController!.index = currentIndex;
    _tabController!.addListener(() {
      setState(() {
        currentIndex = _tabController!.index;
        isSelected = true;
      });
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

  internetConnection() async {
    isInternet = await Constants.isInternetAvailable();
    isLoading = isInternet;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return layout();
  }

  Consumer<ThemeNotifier> layoutMain() {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isSwitched = theme.getTheme() == theme.darkTheme ? true : false;
      return WillPopScope(
        onWillPop: () {
          return handleBackPress();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Nach Yomi",
              style: TextStyle(
                  fontSize: 20,
                  color: AppColor.appColorSecondaryValue,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor:
                isSwitched == true ? AppColor.white : AppColor.white,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Container(
                  color: isSwitched == true ? AppColor.mainbg : AppColor.white,
                  height: 60,
                  child: Stack(
                    children: [
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 4,
                                    color: AppColor.appColorSecondaryValue))),
                        child: TabBar(
                          controller: _tabController,
                          unselectedLabelColor: AppColor.appColorPrimaryValue,
                          indicatorColor: Colors.transparent,
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 20),
                          labelPadding: EdgeInsets.symmetric(horizontal: 0),
                          labelColor: AppColor.black,
                          tabs: [
                            Tab(text: 'TORAH'),
                            Tab(text: 'NEVI"M'),
                            Tab(text: 'KESUV"IM'),
                            Tab(text: 'HAFTORAH')
                          ],
                        ),
                      ),
                      // isSelected == false ?
                      Positioned(
                        bottom: 2.5,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 10,
                                child: _tabController!.index == 0
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 32.5, right: 32.5),
                                        child: Container(
                                          width: 30,
                                          height: 8,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: isSwitched == true
                                                  ? AppColor
                                                      .appColorSecondaryValue
                                                  : AppColor.black,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                        ),
                                      )
                                    : Container(),
                              ),
                              Expanded(
                                  flex: 10,
                                  child: _tabController!.index == 1
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 32.5, right: 32.5),
                                          child: Container(
                                            width: 30,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: isSwitched == true
                                                    ? AppColor
                                                        .appColorSecondaryValue
                                                    : AppColor.black,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                          ),
                                        )
                                      : Container()),
                              Expanded(
                                  flex: 10,
                                  child: _tabController!.index == 2
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 32.5, right: 32.5),
                                          child: Container(
                                            width: 30,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: isSwitched == true
                                                    ? AppColor
                                                        .appColorSecondaryValue
                                                    : AppColor.black,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                          ),
                                        )
                                      : Container()),
                              Expanded(
                                  flex: 10,
                                  child: _tabController!.index == 3
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 32.5, right: 32.5),
                                          child: Container(
                                            width: 30,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                color: isSwitched == true
                                                    ? AppColor
                                                        .appColorSecondaryValue
                                                    : AppColor.black,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5))),
                                          ),
                                        )
                                      : Container()),
                            ],
                          ),
                        ),
                      )
                      //   :Container()
                    ],
                  ),
                )),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              torahLayout(),
              NevimScreen(),
              KesuvimScreen(),
              HaftorahScreen(),
            ],
          ),
        ),
      );
    });
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

  Widget createTab(String tabName) {
    return Tab(
      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
          child: Center(child: Text(tabName)),
        ),
      ]),
    );
  }

  Widget torahLayout() {
    return Scaffold(
      backgroundColor: isSwitched == true ? AppColor.mainbg : AppColor.white,
      body: listTorahModel != null
          ? Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listTorahModel!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRightRoute(
                          widget: SubListOfLibraryScreen(
                            id: index,
                            name: listTorahModel![index].name,
                            bookid: listTorahModel![index].id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 0.0),
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
                                      listTorahModel![index].name!,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      listTorahModel![index].name!,
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
            )
          : isError == true
              ? ErrorScreenPage()
              : Constants.progressDialog1(true, "please Wait"),
    );
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  isSelectedTab() {
    // setState(){
    isSelected = true;
    // }
  }

  callApi() async {
    if (isInternet == null) {
      isInternet = await internetConnection();
    }

    if (isInternet == true) {
      await getSharedPreferences();
      try {
        await callApiBooksListTorah();
      } catch (e) {}
      isLoading = false;
      setState(() {});
    }
  }

  Future getSharedPreferences() async {}

  @override
  bool get wantKeepAlive => true;

  Future<void> callApiBooksListTorah() async {
    CommonsParameter parameter =
        CommonsParameter(membersId: CurrentUserInfo.currentUserId);
    reference.requestParam = parameter;
    reference.shouldIParse = true;
    await ApiHandler.callApiLibraryBooksListTorah(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        listTorahModel = reference.responseParam;
      } catch (e) {}
    }
  }
}
