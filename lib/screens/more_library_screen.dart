import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tanachyomi/apis/apihandler.dart';
import 'package:tanachyomi/apis/primitive_wrapper.dart';
import 'package:tanachyomi/models/chaptersListMoreModel.dart';
import 'package:tanachyomi/screens/errorscreenpage.dart';
import 'package:tanachyomi/screens/no_internet_screen.dart';
import 'package:tanachyomi/screens/please_wait_loader.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';

class MoreLibraryScreen extends StatefulWidget {
  int? chaptersId;

  MoreLibraryScreen({
    Key? key,
    this.chaptersId,
  }) : super(key: key);

  @override
  _MoreLibraryScreenState createState() => _MoreLibraryScreenState();
}

class _MoreLibraryScreenState extends State<MoreLibraryScreen> {
  bool isError = false;
  bool? isInternet;
  bool? isLoading = true;
  List<ChaptersListMoreModel> chaptersList = [];
  Widget layout() {
    if (isInternet != null && isInternet!) {
      if (!isError) {
        if (isLoading != null && isLoading! == true) {
          callApi();
        } else if (isLoading != null && isLoading! == false) {
          return mainLayout();
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
  void initState() {
    internetConnection();
  }

  callApi() async {
    if (isInternet == null) {
      isInternet = await internetConnection();
    }

    if (isInternet == true) {
      await getSharedPreferences();
      try {
        await callApiForChaptersListMore();
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

  @override
  Widget build(BuildContext context) {
    return layout();
  }

  Widget mainLayout() {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.grey600,
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            color: AppColor.appColorSecondaryValue,
            height: 4.0,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        title: Text(
          "More",
          style:
              TextStyle(color: AppColor.appColorSecondaryValue, fontSize: 18),
        ),
        surfaceTintColor: AppColor.appColorSecondaryValue,
        backgroundColor: AppColor.white,
        elevation: 0,
      ),
      body: chaptersList.length != 0
          ? ListView.builder(
              itemCount: chaptersList.length - 1,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.all(5),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        child: AnyLinkPreview(
                          link: chaptersList[index].urlLink,
                          displayDirection: UIDirection.uiDirectionHorizontal,
                          showMultimedia: false,
                          bodyMaxLines: 5,
                          bodyTextOverflow: TextOverflow.ellipsis,
                          titleStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                          errorBody: 'There was a problem',
                          errorTitle: 'Oops',
                          errorWidget: Container(
                            color: Colors.grey[300],
                            child: Text('Oops!'),
                          ),
                          errorImage: "https://google.com/",
                          cache: Duration(days: 7),
                          backgroundColor: Colors.grey[300],
                          borderRadius: 12,
                          removeElevation: false,
                          boxShadow: [
                            BoxShadow(blurRadius: 3, color: Colors.grey)
                          ],
                          onTap: () {},
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          chaptersList[index].title,
                          style: TextStyle(
                              color: AppColor.appColorSecondaryValue,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Container(),
    );
  }

  dynamic callApiParams() {
    Map<String, dynamic> map = {
      'ChaptersId': widget.chaptersId!.toString(),
    };
    return map;
  }

  ReferenceWrapper reference = ReferenceWrapper(null, null);
  Future<void> callApiForChaptersListMore() async {
    reference.requestParam = callApiParams();
    reference.shouldIParse = true;
    await ApiHandler.callApiForChaptersListMore(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      for (var element in reference.responseParam) {
        chaptersList.add(element);
      }
    }
  }
}
