import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tanachyomi/config/config.dart';
import 'package:tanachyomi/models/userinfomodel.dart';
import 'package:tanachyomi/models/usermodel.dart';
import 'package:tanachyomi/parsers/profile_parser.dart';
import 'package:tanachyomi/screens/errorscreenpage.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/theme.dart';
import 'package:tanachyomi/utils/validator.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  bool? isdark;
  int? userid;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController countryTextController = TextEditingController();
  UserInfoModel? userInfo;
  bool isError = false;
  bool? isInternet;
  bool? isLoading;
  String? SocialFacebookId = "";
  String? SocialFacebookToken = "";
  String? SocialLinkedInId = "";
  String? SocialLinkedInToken = "";
  String? SocialGmailId = "";
  String? SocialAppleId = "";
  String? country = "";
  String? phonecode = "";

  @override
  void initState() {
    internetConnection();
    super.initState();
    CallApi();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isdark = theme.getTheme() == theme.darkTheme ? true : false;
      return WillPopScope(
        onWillPop: () {
          return handleBackPress();
        },
        child: updateBody(),
      );
    });
  }

  Widget updateBody() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          "Update Profile",
          style:
              TextStyle(color: AppColor.appColorSecondaryValue, fontSize: 18),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
                  child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 16,
                    color: isdark == true ? AppColor.black : AppColor.white),
              )),
            ),
          )
        ],
      ),
      body: userInfo != null
          ? SingleChildScrollView(
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  form(),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // elevation: MaterialStateProperty.all(0.0),
                      padding: const EdgeInsets.all(10.0),
                      primary: AppColor.appColorPrimaryValue,
                      shadowColor: AppColor.appColorPrimaryValue,
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                    onPressed: () {
                      CallApiForUpdateProfile();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width / 1.15,
                      child: Center(
                        child: Text(
                          "Update Profile",
                          style: TextStyle(color: AppColor.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          : isError == true
              ? ErrorScreenPage()
              : Constants.progressDialog1(true, "please Wait"),
    );
  }

  Widget form() {
    return Container(
      // height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(top: 30),
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                padding: EdgeInsets.only(
                  left: 10, /*bottom: 5*/
                ),
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
                        "Name",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: nameTextController,
                      inputFormatters: [NoLeadingSpaceFormatter()],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10),
                        constraints: BoxConstraints.tight(Size.fromHeight(35)),
                        border: /*OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),*/
                            InputBorder.none,
                        labelStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: AppColor.grey600,
                                  fontSize: 14.0,
                                ),
                        // prefixIcon: Icon(Icons.mail,color: AppColor.iconValue),
                        // icon: Icon(Icons.mail, color: AppColor.iconValue),
                        // labelText: "Email",
                      ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        return Validator.validateFormField(
                            value,
                            "Name is required",
                            null,
                            Constants.NORMAL_VALIDATION);
                      },
                      // onFieldSubmitted: (String value) {
                      //   FocusScope.of(context).requestFocus(secondFocusNode);
                      // },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                padding: EdgeInsets.only(
                  left: 10, /*bottom: 5*/
                ),
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
                        "Email",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: emailTextController,
                      inputFormatters: [NoLeadingSpaceFormatter()],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10),
                        constraints: BoxConstraints.tight(Size.fromHeight(35)),
                        border: /*OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),*/
                            InputBorder.none,
                        labelStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: AppColor.grey600,
                                  fontSize: 14.0,
                                ),
                        // prefixIcon: Icon(Icons.mail,color: AppColor.iconValue),
                        // icon: Icon(Icons.mail, color: AppColor.iconValue),
                        // labelText: "Email",
                      ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        return Validator.validateFormField(
                            value,
                            "Email is required",
                            "Invalid Email",
                            Constants.EMAIL_VALIDATION);
                      },
                      // onFieldSubmitted: (String value) {
                      //   FocusScope.of(context).requestFocus(secondFocusNode);
                      // },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10 /*, bottom: 5*/),
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
                        "Phone",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            phonecode!,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              cursorColor: AppColor.black,
                              controller: phoneTextController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              inputFormatters: [NoLeadingSpaceFormatter()],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 8),
                                constraints:
                                    BoxConstraints.tight(Size.fromHeight(35)),
                                border: InputBorder.none,
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color: AppColor.grey600,
                                      fontSize: 14.0,
                                    ),
                              ),

                              textInputAction: TextInputAction.done,
                              // focusNode: secondFocusNode,
                              validator: (value) {
                                return Validator.validateFormField(
                                    value,
                                    "Phone Number is required",
                                    null,
                                    Constants.NORMAL_VALIDATION);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 0 /*, bottom: 5*/),
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
                      padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                      child: Text(
                        "Country",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      padding: EdgeInsets.only(left: 5),
                      child: CountryListPick(
                          appBar: AppBar(
                            // backgroundColor: Colors.blue,
                            title: Text('Select Country'),
                          ),

                          // if you need custome picker use this
                          pickerBuilder: (context, CountryCode? countryCode) {
                            // selectedCountryCode = countryCode!.dialCode;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      countryCode!.flagUri!,
                                      package: 'country_list_pick',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      countryName(countryCode.name)!,
                                      style: TextStyle(
                                          color: isdark == true
                                              ? AppColor.white
                                              : AppColor.black),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 20,
                                )
                              ],
                            );
                          },

                          // To disable option set to false
                          theme: CountryTheme(
                            isShowFlag: true,
                            isShowTitle: true,
                            isShowCode: false,
                            isDownIcon: true,
                            initialSelection: country /*"US"*/,
                            showEnglishName: true,
                          ),
                          // Set default value
                          initialSelection: country /*'+1'*/,
                          // or
                          // initialSelection: 'United States',
                          onChanged: (CountryCode? code) {
                            print(code!.name);
                            print(code.code);
                            print(code.dialCode);
                            print(code.flagUri);
                            setState(() {
                              // selectedCountryCode = code.dialCode;
                              // selectedCountry = code.name;
                              country = code.name;
                              countryTextController.text = code.name!;
                              phonecode = code.dialCode!;
                              print("Country::" + country!);
                            });
                          },
                          // Whether to allow the widget to set a custom UI overlay
                          useUiOverlay: true,
                          // Whether the country list should be wrapped in a SafeArea
                          useSafeArea: false),
                    ),
                    // TextFormField(
                    //   cursorColor: AppColor.black,
                    //   controller: countryTextController,
                    //
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   inputFormatters: [NoLeadingSpaceFormatter()],
                    //   decoration: InputDecoration(
                    //     contentPadding: EdgeInsets.only(bottom: 8),
                    //     constraints:
                    //     BoxConstraints.tight(Size.fromHeight(35)),
                    //     border: InputBorder.none,
                    //     labelStyle:
                    //     Theme.of(context).textTheme.bodyText2!.copyWith(
                    //       color: AppColor.grey600,
                    //       fontSize: 14.0,
                    //     ),
                    //   ),
                    //
                    //   textInputAction: TextInputAction.done,
                    //   // focusNode: secondFocusNode,
                    //   validator: (value) {
                    //     return Validator.validateFormField(
                    //         value,
                    //         "country is required",
                    //         null,
                    //         Constants.NORMAL_VALIDATION);
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 2,
              color: isdark == true
                  ? AppColor.white
                  : Colors.blueAccent.shade700.withOpacity(0.2),
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ),
      ),
    );
  }

  String? countryName(String? curname) {
    if (curname != null) {
      country = curname;
      return country;
    } else {
      if (userInfo != null) {
        country = userInfo!.country;
        return country;
      } else {
        country = "";
        return country;
      }
    }
  }

  CallApi() async {
    isInternet = await Constants.isInternetAvailable();
    await Preferences();
    await CallApiForGetUserDetail();
    setState(() {
      isLoading = false;
    });
  }

  Preferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isdark = preferences.getBool(Constants.isDarkMode);
  }

  CallApiForGetUserDetail() async {
    Constants.progressDialog1(true, "please Wait");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt(Constants.prefUserIdKeyInt);

    String strJson = UserModel.getUserInfo(
      userid.toString(),
    );
    String url = Config().baseurl + "Member/Get";
    Map? result = await ProfileParser.callApiForGetUser(url, strJson);
    if (result!["errorCode"] == 0) {
      Constants.progressDialog1(false, "");
      userInfo = result["value"];
      setValueIntoFields(userInfo!);
      // Fluttertoast.showToast(
      //   msg: result["value"]/*[0]*/,
      //   timeInSecForIosWeb: 3,
      // );
    } else if (result["errorCode"] == -1) {
      Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: result["value"],
        timeInSecForIosWeb: 3,
      );
      isError = true;
      setState(() {});
    } else {
      Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: "error found",
        timeInSecForIosWeb: 3,
      );
      isError = true;
      setState(() {});
    }
  }

  CallApiForUpdateProfile() async {
    Constants.progressDialog(true, context, "please wait");
    String? url = Config().baseurl + "Member/Save";
    String? strJson = UserModel.addUserUploadInfo(
        userid.toString(),
        nameTextController.text,
        SocialFacebookId!,
        SocialFacebookToken!,
        SocialLinkedInId!,
        SocialLinkedInToken!,
        SocialGmailId!,
        SocialAppleId!,
        phonecode!,
        phoneTextController.text,
        countryTextController.text);
    Map? result = await ProfileParser.callApiForUploadUser(url, strJson);
    if (result!["errorCode"] == 0) {
      Constants.progressDialog(false, context, "");
      userInfo = result["value"];
      setValueIntoFields(userInfo!);
      setState(() {
        isLoading = false;
        FocusManager.instance.primaryFocus?.unfocus();
      });
      Navigator.pop(context);
      // Fluttertoast.showToast(
      //   msg: result["value"]/*[0]*/,
      //   timeInSecForIosWeb: 3,
      // );
    } else if (result["errorCode"] == -1) {
      Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: result["value"],
        timeInSecForIosWeb: 3,
      );
    } else {
      Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: "error found",
        timeInSecForIosWeb: 3,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameTextController.dispose();
    emailTextController.dispose();
    countryTextController.dispose();
    phoneTextController.dispose();
  }

  setValueIntoFields(UserInfoModel userInfoModel) {
    setState(() {
      nameTextController.text = userInfo!.name!;
      emailTextController.text = userInfo!.email!;
      countryTextController.text = userInfo!.country!;
      phoneTextController.text = userInfo!.phoneno!;
      phonecode = userInfo!.countrycode!;

      userInfo!.country! != ""
          ? country = userInfo!.country!
          : country = "United States";
    });
  }

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
}
