import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/theme.dart';

import '../../apis/apihandler.dart';
import '../../apis/common_paramters.dart';
import '../../apis/primitive_wrapper.dart';
import '../../models/bookmark_list_model.dart';
import '../../utils/constant.dart';
import '../../utils/current_userinfo.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  bool? isdark;
  ReferenceWrapper reference = ReferenceWrapper(null, null);
  List<Torah> torahListModel = [];
  bool? isInternet = true;
  @override
  Widget build(BuildContext context) {
    if (isInternet != null && isInternet!) {
      if (!reference.isError) {
        if (reference.isLoading) {
          callApi();
        } else if (!reference.isLoading) {
          return layoutMain();
        }
      }
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SpinKitThreeBounce(
              color: AppColor.appColorPrimaryValue,
              size: 30.0,
            ),
            const Padding(padding: EdgeInsets.only(top: 15.0)),
            Text(
              "Please wait",
              style: TextStyle(color: AppColor.appColorPrimaryValue),
            ),
          ],
        ),
      ),
    );
  }

  Consumer<ThemeNotifier> layoutMain() {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isdark = theme.getTheme() == theme.darkTheme ? true : false;
      return WillPopScope(
        onWillPop: () {
          return handleBackPress();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: isdark == true ? AppColor.white : AppColor.white,
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
                child: Container(
                  color: AppColor.appColorSecondaryValue,
                  height: 4.0,
                ),
                preferredSize: Size.fromHeight(4.0)),
            title: Text(
              "Bookmarks",
              style: TextStyle(
                  color: AppColor.appColorSecondaryValue, fontSize: 18),
            ),
          ),
          body: bookmarkbody(),
        ),
      );
    });
  }

  Widget bookmarkbody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        torahList(),
      ],
    );
  }

  Widget torahList() {
    return torahListModel.length != 0
        ? Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: isdark == true ? AppColor.mainbg : AppColor.grey1.shade200,
            ),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: torahListModel.length,
              itemBuilder: (context, index) {
                Torah? item = torahListModel[index];
                return ListTile(
                  leading: Container(
                      child: Image.asset(
                    "assets/images/book.png",
                    width: 30,
                    height: 20,
                    fit: BoxFit.fill,
                    color: AppColor.appColorPrimaryValue,
                  )),
                  title: Text(
                    item.bookName ?? "",
                    style: TextStyle(
                        color:
                            isdark == true ? AppColor.white : AppColor.mainbg),
                  ),
                  trailing: Icon(Icons.delete),
                );
              },
            ),
          )
        : Container();
  }

  handleBackPress() {
    return Navigator.pop(context);
  }

  Future<void> callBookmarkList() async {
    CommonsParameter parameter =
        CommonsParameter(membersId: CurrentUserInfo.currentUserId);
    reference.requestParam = parameter;
    reference.shouldIParse = true;
    await ApiHandler.getBookmarkList(reference);
    if (reference.isError) {
      reference.isError = false;
    } else {
      try {
        torahListModel = reference.responseParam;
      } catch (e) {}
    }
  }

  callApi() async {
    isInternet = await Constants.isInternetAvailable();
    if (isInternet != null && isInternet!) {
      await callBookmarkList();
      reference.isLoading = false;
      if (mounted) {
        setState(() {});
      }
    }
  }
}
