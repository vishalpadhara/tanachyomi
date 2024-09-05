import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/models/bookmodel.dart';
import 'package:tanachyomi/models/chaptersListMoreModel.dart';
import 'package:tanachyomi/screens/Verses/versescreen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import '../../apis/apihandler.dart';
import '../../apis/primitive_wrapper.dart';
import '../../models/list_chapters_model.dart';
import '../../models/list_of_chapters_in_book.dart';
import '../../utils/current_userinfo.dart';
import '../errorscreenpage.dart';
import '../no_internet_screen.dart';
import '../please_wait_loader.dart';

class SubListOfLibraryScreen extends StatefulWidget {
  String? name;
  String? title;
  int? id;
  int? count;
  int? bookid;
  bool? IsHaftorahScreen;
  bool? IsNevimScreen;
  bool? IsKesuvimScreen;
  SubListOfLibraryScreen(
      {Key? key,
      this.name,
      this.title,
      this.id,
      this.count,
      this.bookid,
      this.IsHaftorahScreen,
      this.IsNevimScreen,
      this.IsKesuvimScreen})
      : super(key: key);

  @override
  State<SubListOfLibraryScreen> createState() => _SubListOfLibraryScreenState();
}

class _SubListOfLibraryScreenState extends State<SubListOfLibraryScreen> {
  bool? isDark;
  List<BookModel>? bookModel = [];
  List<ListOfChaptersModel>? listOfChaptersModel = [];
  List<ChaptersListMoreModel>? chaptersListMoreModel = [];

  ReferenceWrapper reference = ReferenceWrapper(null, null);
  List<String> subListName = <String>[
    " 1",
    " 2",
    " 3",
    " 4",
    " 5",
    " 6",
    " 7",
    " 8",
    " 9",
    " 10",
    " 11",
    " 12",
    " 13",
    " 14",
  ];
  bool isError = false;
  bool? isInternet;
  bool? isLoading = true;
  @override
  void initState() {
    internetConnection();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return layout();
  }

  Consumer<ThemeNotifier> layoutMain() {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isDark = theme.getTheme() == theme.darkTheme ? true : false;
      return WillPopScope(
        onWillPop: () {
          return handleBackPress();
        },
        child: SubChapterLayoutBody(),
      );
    });
  }

  Widget SubChapterLayoutBody() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark == true ? AppColor.white : AppColor.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColor.grey600,
            )),
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(4.0),
            child: Container(
              color: AppColor.appColorSecondaryValue,
              height: 4.0,
            )),
        title: widget.IsNevimScreen == true || widget.IsKesuvimScreen == true
            ? Text(
                widget.name! + " (${widget.title})",
                style: TextStyle(
                    color: AppColor.appColorSecondaryValue, fontSize: 18),
              )
            : Text(
                widget.name!,
                style: TextStyle(
                    color: AppColor.appColorSecondaryValue, fontSize: 18),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 5, top: 5),
                  child: Divider(
                    height: 2,
                    color: isDark == true
                        ? AppColor.white
                        : Colors.blueAccent.shade700.withOpacity(0.2),
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                );
              },
              itemCount: listOfChaptersModel!.length,
              itemBuilder: (context, index) {
                String? audioUrl = "${listOfChaptersModel![index].rootUrl}" +
                    "${listOfChaptersModel![index].fileUrl}";
                if (widget.IsHaftorahScreen == true) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRightRoute(
                          widget: VerseScreen(
                            bookname: bookModel![0].name,
                            subTitle: listOfChaptersModel![index].chapterName,
                            subChapter: listOfChaptersModel![index].subChapter,
                            chaptersId: listOfChaptersModel![index].chaptersId,
                            isCompleted:
                                listOfChaptersModel![index].isCompleted,
                            url: audioUrl.toString(),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 10, top: 10, bottom: 10),
                                child: Image.asset(
                                  "assets/images/book.png",
                                  color: AppColor.appColorSecondaryValue,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  listOfChaptersModel![index].chapterName,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: isDark == true
                                          ? AppColor.white
                                          : AppColor.black),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 15, top: 10, bottom: 10),
                                child: Image.asset(
                                  "assets/images/play_circle.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (widget.IsNevimScreen == true ||
                    widget.IsKesuvimScreen == true) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        SlideRightRoute(
                          widget: VerseScreen(
                            bookname: bookModel![0].name,
                            subTitle: listOfChaptersModel![index].bookName,
                            subChapter: listOfChaptersModel![index].subChapter,
                            chaptersId: listOfChaptersModel![index].chaptersId,
                            url: audioUrl.toString(),
                            isCompleted:
                                listOfChaptersModel![index].isCompleted,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 10, top: 10, bottom: 10),
                                child: Image.asset(
                                  "assets/images/book.png",
                                  color: AppColor.appColorSecondaryValue,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  listOfChaptersModel![index].chapterTitle,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: isDark == true
                                          ? AppColor.white
                                          : AppColor.black),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 15, top: 10, bottom: 10),
                                child: Image.asset(
                                  "assets/images/play_circle.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      SlideRightRoute(
                        widget: VerseScreen(
                          bookname: bookModel![0].name!,
                          subTitle: listOfChaptersModel![index].bookName +
                              " " +
                              listOfChaptersModel![index].subChapter,
                          subChapter: listOfChaptersModel![index].subChapter,
                          chaptersId: listOfChaptersModel![index].chaptersId,
                          url: audioUrl.toString(),
                          isCompleted: listOfChaptersModel![index].isCompleted,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 15, right: 10, top: 10, bottom: 10),
                              child: Image.asset(
                                "assets/images/book.png",
                                color: AppColor.appColorSecondaryValue,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                listOfChaptersModel![index].chapterName +
                                    " " +
                                    listOfChaptersModel![index].chapterSubTitle,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: isDark == true
                                        ? AppColor.white
                                        : AppColor.black),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 15, top: 10, bottom: 10),
                              child: Image.asset(
                                "assets/images/play_circle.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  callApi() async {
    if (isInternet == null) {
      isInternet = await internetConnection();
    }

    if (isInternet == true) {
      await getSharedPreferences();
      try {
        if (widget.IsHaftorahScreen == true) {
          await callApiParashaListHaftorah();
        } else if (widget.IsNevimScreen == true) {
          await callApiChaptersList();
        } else if (widget.IsKesuvimScreen == true) {
          await callApiChaptersList();
        } else {
          await callApiParashaList(); //parsha list
        }
      } catch (e) {}
      isLoading = false;
      setState(() {});
    }
  }

  Future getSharedPreferences() async {}

  internetConnection() async {
    isInternet = await Constants.isInternetAvailable();
    isLoading = isInternet;
    if (mounted) {
      setState(() {});
    }
  }

  handleBackPress() {
    return Navigator.pop(context);
  }

  dynamic callApiParams() {
    Map<String, dynamic> map = {
      'BooksId': widget.bookid.toString(),
      'MembersId': CurrentUserInfo.currentUserId.toString(),
    };
    return map;
  }

  Future<void> callApiParashaList() async {
    reference.requestParam = callApiParams();
    reference.shouldIParse = true;
    await ApiHandler.callApiParashaList(reference); //Parasha/List for torah
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        ChaptersInBookModel parashaList = reference.responseParam;
        bookModel = parashaList.bookModel;
        listOfChaptersModel = parashaList.listOfChaptersModel;
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> callApiParashaListHaftorah() async {
    reference.requestParam = callApiParams();
    reference.shouldIParse = true;
    await ApiHandler.callApiParashaListHaftorah(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        ChaptersInBookModel parashaList = reference.responseParam;
        bookModel = parashaList.bookModel;
        listOfChaptersModel = parashaList.listOfChaptersModel;
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
        bookModel = parashaList.bookModel;
        listOfChaptersModel = parashaList.listOfChaptersModel;
      } catch (e) {}
    }
  }
}
