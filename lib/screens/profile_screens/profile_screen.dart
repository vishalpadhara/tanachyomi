import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanachyomi/config/config.dart';
import 'package:tanachyomi/models/userinfomodel.dart';
import 'package:tanachyomi/models/usermodel.dart';
import 'package:tanachyomi/parsers/profile_parser.dart';
import 'package:tanachyomi/parsers/registeration_parser.dart';
import 'package:tanachyomi/screens/errorscreenpage.dart';
import 'package:tanachyomi/screens/profile_screens/bookmark_screen.dart';
import 'package:tanachyomi/screens/profile_screens/update_profile.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool? isdark;
  final ImagePicker _picker = ImagePicker();
  File? _imageFromPicker;
  String? imageName, contentType, newimage;
  File? newFile;
  int? userid;
  String? imgGuid;
  bool? isdark1;
  String? imgurl = "";
  UserInfoModel? userInfo;
  bool isError = false;
  bool? isInternet;
  bool? isLoading;
  SharedPreferences? prefs;
  int? count = 0;
  Timer? _timer;
  int _start = 10;

  @override
  void initState() {
    internetConnection();
    CallApi();
    startTimer();
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   if (isInternet != null && isInternet!) {
  //     if (!isError) {
  //       if (isLoading != null && isLoading! == true) {
  //         CallApi();
  //       } else if (isLoading != null && isLoading! == false) {
  //         return layoutMain();
  //       }
  //     } else {
  //       return const ErrorScreenPage();
  //     }
  //   } else if (isInternet != null && isInternet!) {
  //     return NoInternetScreen(
  //       onPressedRetyButton: () {
  //         internetConnection();
  //       },
  //     );
  //   }
  //   return layoutMain();
  //   //   Scaffold(
  //   //   resizeToAvoidBottomInset: false,
  //   //   body: Center(
  //   //     child: SpinKitThreeBounce(
  //   //       color: AppColor.appColorPrimaryValue,
  //   //       size: 30.0,
  //   //     ),
  //   //   ),
  //   // );
  // }

  // Widget layoutMain() {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isdark = theme.getTheme() == theme.darkTheme ? true : false;
      return userInfo != null
          ? WillPopScope(
              onWillPop: () {
                return handleBackPress();
              },
              child: Scaffold(
                appBar: AppBar(
                  // backgroundColor: ,
                  automaticallyImplyLeading: false,
                  backgroundColor:
                      isdark == true ? AppColor.white : AppColor.white,
                  // leading: Icon(Icons.arrow_back_ios,color: AppColor.grey600,),
                  centerTitle: true,
                  elevation: 0,
                  bottom: PreferredSize(
                      child: Container(
                        color: AppColor.appColorSecondaryValue,
                        height: 4.0,
                      ),
                      preferredSize: Size.fromHeight(4.0)),
                  title: Text(
                    "Profile",
                    style: TextStyle(
                        color: AppColor.appColorSecondaryValue, fontSize: 18),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context, SlideRightRoute(widget: UpdateProfile()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Center(
                            child: Text(
                          "Edit",
                          style: TextStyle(
                              fontSize: 16,
                              color: isdark == true
                                  ? AppColor.black
                                  : AppColor.black),
                        )),
                      ),
                    )
                  ],
                ),
                body: profilebody(),
              ),
            )
          : isError == true
              ? ErrorScreenPage()
              : Constants.progressDialog1(true, "please Wait");
    });
  }

  // }

  Widget profilebody() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [profileImage(), content()],
        ),
      ),
    );
  }

  Widget profileImage() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: CircleAvatar(
              radius: 80,
              backgroundColor: isdark == true
                  ? AppColor.appColorPrimarydull
                  : AppColor.appColorPrimaryValue,
              child: CircleAvatar(
                radius: 70,
                // backgroundImage: AssetImage("assets/images/usa.png"),
                child: Stack(
                  children: [
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Center(
                          child: _start == 0
                              ? Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/noimage.png",
                                          ),
                                          fit: BoxFit.fill)),
                                )
                              : SpinKitFadingCircle(
                                  color: AppColor.appColorPrimaryValue,
                                )),
                    ),
                    Container(
                      height: 140,
                      width: 140,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, image: setImageFromUrl()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: MediaQuery.of(context).size.width / 1.8,
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: InkWell(
                onTap: () async {
                  // await AllPermission();
                  await showImagePickerDialog(context);
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColor.grey600,
                  child: Center(
                      child: Icon(
                    Icons.camera_alt,
                    color: isdark == true ? AppColor.white : AppColor.white,
                  )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  DecorationImage? setImageFromUrl() {
    //print("ProfileImage:: "+imgurl.toString());
    if (imgurl != null || imgurl!.isNotEmpty) {
      return DecorationImage(image: NetworkImage(imgurl!), fit: BoxFit.fill);
    } else {
      return DecorationImage(
          image: AssetImage(
            "assets/images/wall1.jpg",
          ),
          fit: BoxFit.fill);
    }
  }

  Widget content() {
    return Container(
      padding: EdgeInsets.only(left: 1, top: 50, right: 1),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width,
            height: 30,
            color: isdark == true ? AppColor.mainbg : AppColor.grey1.shade300,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("PROGRESS",
                    style: TextStyle(
                        fontSize: 16,
                        color: isdark == true
                            ? AppColor.appColorPrimaryValue
                            : AppColor.black),
                    textAlign: TextAlign.left)),
          ),
          // Text("PROGRESS",style: TextStyle(fontSize: 18,color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.white),),
          SizedBox(
            height: 10,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 10, right: 5),
            trailing: Text(
              "0.70%",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            title: Text(
              "Overall Progress",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            leading: Image.asset(
              "assets/images/frame2.png",
              width: 30,
              height: 30,
              fit: BoxFit.fill,
            ),
          ),
          Divider(
            height: 2,
            color: isdark == true
                ? AppColor.white
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 10, right: 7),
            trailing: Text(
              "5",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            title: Text(
              "Chapters Completed",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            leading: Image.asset(
              "assets/images/vector.png",
              width: 30,
              height: 30,
              fit: BoxFit.fill,
            ),
          ),
          Divider(
            height: 2,
            color: isdark == true
                ? AppColor.white
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 10, right: 7),
            trailing: Text(
              "0",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            title: Text(
              "Chapters Started",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            leading: Image.asset(
              "assets/images/spinner.png",
              width: 30,
              height: 30,
              fit: BoxFit.fill,
            ),
          ),
          Divider(
            height: 2,
            color: isdark == true
                ? AppColor.white
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1,
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 10, right: 3),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 23,
              color: isdark == true ? AppColor.white : AppColor.grey600,
            ),
            onTap: () {
              Navigator.push(
                  context, SlideRightRoute(widget: BookMarkScreen()));
            },
            title: Row(
              children: [
                Text(
                  "Bookmarks ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  "(5)",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.appColorPrimaryValue),
                ),
              ],
            ),
            leading: Image.asset("assets/images/bookmark.png",
                width: 30, height: 30, fit: BoxFit.fill),
          ),
          Divider(
            height: 2,
            color: isdark == true
                ? AppColor.white
                : Colors.blueAccent.shade700.withOpacity(0.2),
            thickness: 1,
          ),
        ],
      ),
    );
  }

  requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print(
          'Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
  }

  requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print(
          'Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
  }

  AllPermission() async {
    await requestStoragePermission();
    await requestCameraPermission();
    //await requestSMSPermission();
  }

  showImagePickerDialog(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Pick Image",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6!.copyWith(),
                  // Constants.getValueFromKey(
                  //     "nop.mobile.nop.EditProfileScreen.addPhoto",
                  //     Constants.hashMap),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: isdark == true ? AppColor.white : Colors.black,
                      ),
                      icon: const Icon(
                        Icons.camera,
                        size: 16,
                      ),
                      onPressed: () {
                        const SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarBrightness: Brightness.dark,
                          statusBarIconBrightness: Brightness.dark,
                        );
                        Navigator.pop(context);
                        takePhoto(ImageSource.camera);
                      },
                      label: Text(
                        "Camera",
                        softWrap: true,
                        style:
                            Theme.of(context).textTheme.bodyText2!.copyWith(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: isdark == true ? AppColor.white : Colors.black,
                      ),
                      icon: const Icon(
                        Icons.image,
                        size: 16,
                      ),
                      onPressed: () {
                        const SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarBrightness: Brightness.dark,
                          statusBarIconBrightness: Brightness.dark,
                        );
                        Navigator.pop(context);
                        takePhoto(ImageSource.gallery);
                      },
                      label: Text(
                        "Gallery",
                        softWrap: true,
                        style:
                            Theme.of(context).textTheme.bodyText2!.copyWith(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      },
    );
  }

  void takePhoto(ImageSource imageSource) async {
    try {
      final pickedFile = await _picker.pickImage(
          source: imageSource, maxHeight: 150, maxWidth: 150);
      setState(() {
        if (pickedFile != null) {
          _imageFromPicker = File(pickedFile.path);
          CallApiForUploadImage(userid, _imageFromPicker);
        } else {
          Fluttertoast.showToast(
              msg: Constants.getValueFromKey(
                  "nop.mobile.no.image.selected", Constants.hashMap),
              timeInSecForIosWeb: 1);
        }
        if (_imageFromPicker != null) {
          // apiCallForMultipart(imageContentType![0],contentType.toString(),_imageFromPicker/*imagePathInBytes!*/);
        }
      });
    } catch (e) {
      print(e);
      if (imageSource == ImageSource.camera) {
        // Fluttertoast.showToast(
        //     msg: Constants.getValueFromKey(
        //         "nop.mobile.camera.access.error", Constants.hashMap),
        //     timeInSecForIosWeb: 1);
      } else if (imageSource == ImageSource.gallery) {
        // Fluttertoast.showToast(
        //   msg: Constants.getValueFromKey(
        //       "nop.mobile.storage.access.for.image.error", Constants.hashMap),
        //   timeInSecForIosWeb: 1,
        // );
      }
    }
  }

  SharedPrefenceValue() async {
    prefs = await SharedPreferences.getInstance();
    userid = prefs!.getInt(Constants.prefUserIdKeyInt);
    imgGuid = prefs!.getString(Constants.prefUserGuid);
    isdark = prefs!.getBool(Constants.isDarkMode);
    print("UserId::" + userid.toString());
    print("GuidId::" + imgGuid.toString());
    print("DarkTheme::" + isdark1.toString());
    // setState(() {
    //   if (imgGuid != null) {
    //     imgurl = Config().getimagebaseurl + imgGuid!;
    //   }
    // });
  }

  CallApi() async {
    await SharedPrefenceValue();
    await CallApiForGetProfileImage();
    setState(() {
      // isLoading = false;
    });
  }

  //"ae12e0e9-aaa7-4620-a2d0-5b8ba044a412"
  CallApiForGetProfileImage() async {
    // Constants.progressDialog(true, context, "please wait");
    count = count! + 1;
    print("COUNT::" + count.toString());
    print("UserId::" + userid.toString());
    print("GuidId::" + imgGuid.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt(Constants.prefUserIdKeyInt);

    String strJson = UserModel.getUserInfo(
      userid.toString(),
    );
    String url = Config().baseurl + "Member/Get";
    Map? result = await ProfileParser.callApiForGetUser(url, strJson);
    if (result!["errorCode"] == 0) {
      // Constants.progressDialog(false, context, "");
      userInfo = result["value"];
      await setGUID(userInfo!.imageguid!);
      print("Guid:: " + userInfo!.imageguid.toString());
      setState(() {
        isLoading = true;
        imgurl = Config().getimagebaseurl + userInfo!.imageguid!;
      });
      // setValueIntoFields(userInfo!);
      // Fluttertoast.showToast(
      //   msg: result["value"]/*[0]*/,
      //   timeInSecForIosWeb: 3,
      // );
    } else if (result["errorCode"] == -1) {
      // Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: result["value"],
        timeInSecForIosWeb: 3,
      );
      isError = true;
      setState(() {});
    } else {
      // Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: "error found",
        timeInSecForIosWeb: 3,
      );
      isError = true;
      setState(() {});
    }
  }

  CallApiForUploadImage(int? id, File? image) async {
    Constants.progressDialog(true, context, "please wait");
    String? url = Config().baseurl + "Member/Upload";
    // Map strJson = UserModel.addUserUploadImageInfo(id!.toString(), _imageFromPicker!.path);
    Map? result = await RegisterationParser.callApiforUploadImage(
        url, image!.path, userid!);
    if (result!["errorCode"] == 0) {
      Constants.progressDialog(false, context, "");
      UserInfoModel? guid = result["value"][1];
      await setGUID(guid!.guid!);
      print("IMAGEData:" + result["value"][0]);

      // Fluttertoast.showToast(
      //   msg: result["value"][0],
      //   timeInSecForIosWeb: 3,
      // );
      //await CallApiForGetProfileImage();
      setState(() {
        imgurl = Config().getimagebaseurl + imgGuid!;
      });
    } else {
      Constants.progressDialog(false, context, "");
      print("ERRORIMAGE:" + result["value"]);
    }
  }

  setGUID(String? guid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.prefUserGuid, guid!);
    imgGuid = prefs.getString(Constants.prefUserGuid);
  }

  internetConnection() async {
    isInternet = await Constants.isInternetAvailable();
    // isLoading = isInternet;
    // if (mounted) {
    //   setState(() {});
    // }
  }

  handleBackPress() {
    // return Navigator.pop(context);
  }
}
