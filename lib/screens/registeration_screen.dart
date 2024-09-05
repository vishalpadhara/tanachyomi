import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tanachyomi/config/config.dart';
import 'package:tanachyomi/models/countrymodel.dart';
import 'package:tanachyomi/models/registerationmodel.dart';
import 'package:tanachyomi/models/usermodel.dart';
import 'package:tanachyomi/parsers/registeration_parser.dart';
import 'package:tanachyomi/screens/home_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/encrypter_key.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/validator.dart';
import 'package:http/http.dart' as http;

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailOrPhoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController conformPasswordTextController = TextEditingController();

  // List<String> countryItems = [];
  List<CountryModel>? countrylist/*= <CountryModel>[]*/;

  String? selectedValue;
  String? selectedCountryCode = "+1";
  String? selectedCountry = "United State";
  bool? isHidePassword = true;
  IconData icon = Icons.remove_red_eye;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Map<String, dynamic>? _userData;
  UserModel? user;
  bool logoutUser = true;
  String redirectUrl = 'http://localhost:54307/signin-linkedin';
  String clientId = '78pgrr6nj6754c';
  String clientSecret = 'LlqT1Sh5dZjJlJbz';
  bool? isName = false;
  bool? isemail = false;
  bool? isemailValid = false;
  bool? isPhone = false;
  bool? isPass = false;
  bool? isPass1 = false;
  String? email = "";
  static Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regexEmail = new RegExp(emailPattern.toString());
  final ImagePicker _picker = ImagePicker();
  File? _imageFromPicker;
  String? imageName, contentType, newimage;
  String? SocialFacebookId = "";
  String? SocialFacebookToken = "";
  String? SocialLinkedInId = "";
  String? SocialLinkedInToken = "";
  String? SocialGmailId = "";
  String? SocialAppleId = "";
  File? newFile;
  bool? isInternet = true;

  @override
  initState() {
    super.initState();
    // callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.grey,
        splashColor: Colors.black,
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.black),
        ),
        colorScheme: ColorScheme.light(
          primary: AppColor.grey1.shade700,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: CommonLayoutforSplashLogin(),
      ),
    );
  }

  Widget CommonLayoutforSplashLogin() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          primary: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Container(
                  //   height: MediaQuery.of(context).size.height,
                  //   width: MediaQuery.of(context).size.width,
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2.8,
                    width: MediaQuery.of(context).size.width,
                    child: /*Image.asset(
      'assets/images/wall4.png',
      // height: 400,
      fit: BoxFit.fill,
        ),*/
                        ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        'assets/images/wall4.png',
                        // height: 400,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: new ClipRect(
                          child: new BackdropFilter(
                            filter:
                                new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                            child: new Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: MediaQuery.of(context).size.height / 3.8,
                              decoration: new BoxDecoration(
                                  color: Colors.black12.withOpacity(0.3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                            ),
                          ),
                        ),
                      ),
                      Center(
                          child: Image.asset(
                        "assets/images/tanachyomi.png",
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 7,
                        fit: BoxFit.fill,
                      ))
                    ],
                  ),
                  Positioned(
                      left: 20,
                      top: 50,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColor.mainbg,
                          )))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              loginForm(),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.blueAccent.shade700.withOpacity(0.2),
                height: 1,
                width: MediaQuery.of(context).size.width / 1.1,
              ),
              SizedBox(
                height: 10,
              ),
              authlogos()!,
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.blueAccent.shade700.withOpacity(0.2),
                height: 1,
                width: MediaQuery.of(context).size.width / 1.1,
              ),
              SizedBox(
                height: 10,
              ),
              Text("Already have an account?"),
              Text(
                "Login",
                style: TextStyle(color: AppColor.appColorSecondaryValue),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  // Container(
  //   height: MediaQuery.of(context).size.height,
  //   width: MediaQuery.of(context).size.width,
  // ),
  // Container(
  //   height: MediaQuery.of(context).size.height / 1.7,
  //   width: MediaQuery.of(context).size.width,
  //   child: /*Image.asset(
  //     'assets/images/wall4.png',
  //     // height: 400,
  //     fit: BoxFit.fill,
  //   ),*/
  //       ShaderMask(
  //     shaderCallback: (rect) {
  //       return LinearGradient(
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         colors: [Colors.black, Colors.transparent],
  //       ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
  //     },
  //     blendMode: BlendMode.dstIn,
  //     child: Image.asset(
  //       'assets/images/wall4.png',
  //       // height: 400,
  //       fit: BoxFit.fill,
  //     ),
  //   ),
  // ),

  // Positioned(
  //     left: 20,
  //     top: 50,
  //     child: InkWell(
  //         onTap: () {
  //           Navigator.pop(context);
  //         },
  //         child: Icon(
  //           Icons.arrow_back_ios,
  //           color: AppColor.mainbg,
  //         )))

  loginForm() {
    return Form(
      key: formKey,
      child: Container(
        // height : MediaQuery.of(context).size.height/3.5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign Up",
              style: TextStyle(
                  color: AppColor.appColorSecondaryValue, fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.deepPurple,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 15),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: /*isdark == true ? AppColor.appColorPrimarydull:*/
                        AppColor.appColorPrimaryValue,
                    child: CircleAvatar(
                      radius: 75,
                      // backgroundImage: AssetImage("assets/images/usa.png"),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: _imageFromPicker == null
                                ? DecorationImage(
                                    image: AssetImage(
                                      "assets/images/wall1.jpg",
                                    ),
                                    fit: BoxFit.fill)
                                : DecorationImage(
                                    image: FileImage(_imageFromPicker!),
                                    fit: BoxFit.fill)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: MediaQuery.of(context).size.width / 1.65,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: InkWell(
                        onTap: () async {
                          await AllPermission();
                          await showImagePickerDialog(context);
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColor.grey600,
                          child: Center(
                              child: Icon(
                            Icons.camera_alt,
                            color: /* isdark == true ? AppColor.white:*/
                                AppColor.white,
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.withOpacity(0.2))),
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
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: nameTextController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                        NoLeadingSpaceFormatter()
                      ],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10),
                          constraints:
                              BoxConstraints.tight(Size.fromHeight(35)),
                          border: InputBorder.none,
                          labelStyle:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: AppColor.grey600,
                                    fontSize: 14.0,
                                  ),
                          suffixIcon: isName == true
                              ? Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "name is required",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              : null,
                          icon: Icon(Icons.account_circle_outlined,
                              color: AppColor.iconValue)
                          // labelText: "Email",
                          ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            isName = true;
                          });
                        } else {
                          setState(() {
                            isName = false;
                          });
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          isName = true;
                        } else {
                          isName = false;
                        }
                        // return Validator.validateFormField(
                        //     value,
                        //     "name is required",
                        //     null,
                        //     Constants.NORMAL_VALIDATION);
                        // },
                        // onFieldSubmitted: (String value) {
                        //   FocusScope.of(context).requestFocus(secondFocusNode);
                      },
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
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.withOpacity(0.2))),
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
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: emailOrPhoneTextController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                        NoLeadingSpaceFormatter()
                      ],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10),
                          constraints:
                              BoxConstraints.tight(Size.fromHeight(35)),
                          border: InputBorder.none,
                          labelStyle:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: AppColor.grey600,
                                    fontSize: 14.0,
                                  ),
                          icon: Icon(Icons.mail, color: AppColor.iconValue),
                          suffixIcon: errorMessage()
                          // labelText: "Email",
                          ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        // return Validator.validateFormField(
                        //     value,
                        //     "Email is required",
                        //     "Invalid Email",
                        //     Constants.EMAIL_VALIDATION);
                        if (value!.isEmpty) {
                          email = Validator.validateFormField(
                              value,
                              "Email is required",
                              "Invalid Email",
                              Constants.EMAIL_VALIDATION);
                          isemail = true;
                        } else {
                          if (regexEmail.hasMatch(value)) {
                            email = Validator.validateFormField(
                                value,
                                "Email is required",
                                "Invalid Email",
                                Constants.EMAIL_VALIDATION);
                            isemailValid = false;
                            isemail = false;
                          } else {
                            email = Validator.validateFormField(
                                value,
                                "Email is required",
                                "Invalid Email",
                                Constants.EMAIL_VALIDATION);
                            isemailValid = true;
                            isemail = false;
                          }
                        }
                      },
                      onChanged: (value) {
                        // print("EMAIL:"+email!);
                        if (value.isEmpty) {
                          setState(() {
                            email = Validator.validateFormField(
                                value,
                                "Email is required",
                                "Invalid Email",
                                Constants.EMAIL_VALIDATION);
                            isemail = true;
                          });
                        } else {
                          if (regexEmail.hasMatch(value)) {
                            setState(() {
                              email = Validator.validateFormField(
                                  value,
                                  "Email is required",
                                  "Invalid Email",
                                  Constants.EMAIL_VALIDATION);
                              isemailValid = false;
                              isemail = false;
                            });
                          } else {
                            setState(() {
                              email = Validator.validateFormField(
                                  value,
                                  "Email is required",
                                  "Invalid Email",
                                  Constants.EMAIL_VALIDATION);
                              isemailValid = true;
                              isemail = false;
                            });
                          }
                        }
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
                // padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: /*isdark == true ? AppColor.white:*/
                            Colors.grey.withOpacity(0.2))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 10),
                      child: Text(
                        "Country",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    // DropdownButtonFormField(
                    //   decoration: InputDecoration(
                    //     isDense: true,
                    //     contentPadding: EdgeInsets.only(left: 1, right: 1),
                    //     border: InputBorder.none,
                    //   ),
                    //   isExpanded: true,
                    //   hint: const Text(
                    //     'Select Country',
                    //     style: TextStyle(fontSize: 14),
                    //   ),
                    //   icon: Icon(
                    //     Icons.keyboard_arrow_down,
                    //     color: /*isdark == true ? AppColor.white:*/ Colors
                    //         .black45,
                    //   ),
                    //   iconSize: 30,
                    //   // buttonHeight: 60,
                    //   // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    //   // dropdownDecoration: BoxDecoration(
                    //   //   borderRadius: BorderRadius.circular(15),
                    //   // ),
                    //   items: countrylist!
                    //       .map((item) => DropdownMenuItem<CountryModel>(
                    //             value: item,
                    //             child: Text(
                    //               item.name!,
                    //               style: const TextStyle(
                    //                 fontSize: 14,
                    //               ),
                    //             ),
                    //           ))
                    //       .toList(),
                    //   validator: (value) {
                    //     if (value == null) {
                    //       return 'Please select one';
                    //     }
                    //   },
                    //   onChanged: (value) {
                    //     //Do something when changing the item if you want.
                    //     selectedValue = value.toString();
                    //     for (int i = 0; i < countrylist!.length; i++) {
                    //       if (countrylist![i] == value) {
                    //         setState(() {
                    //           selectedCountryCode = countrylist![i].code;
                    //         });
                    //       }
                    //     }
                    //     print("VALUE::" + selectedCountryCode!.toString());
                    //   },
                    //   onSaved: (value) {
                    //     selectedValue = value.toString();
                    //     print("VALUE::" + selectedValue.toString());
                    //   },
                    // ),
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
                                    Text(countryCode.name!),
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
                            showEnglishName: true,
                          ),
                          // Set default value
                          initialSelection: 'United States',
                          // or
                          // initialSelection: 'United States',
                          onChanged: (CountryCode? code) {
                            print(code!.name);
                            print(code.code);
                            print(code.dialCode);
                            print(code.flagUri);
                            setState(() {
                              selectedCountryCode = code.dialCode;
                              selectedCountry = code.name;
                            });
                          },
                          // Whether to allow the widget to set a custom UI overlay
                          useUiOverlay: true,
                          // Whether the country list should be wrapped in a SafeArea
                          useSafeArea: false),
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
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.withOpacity(0.2))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          alignment: Alignment.center,
                          child: Text(
                            selectedCountryCode!.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                            // color: Colors.indigo,
                            child: TextFormField(
                              cursorColor: AppColor.black,
                              controller: phoneTextController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[^\S*]")),
                                NoLeadingSpaceFormatter()
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 13),
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
                                suffixIcon: isPhone == true
                                    ? Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Phone is required",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    : null,
                                // icon: Icon(Icons.phone,color: AppColor.iconValue)
                                // labelText: "Email",
                              ),
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    isPhone = true;
                                  });
                                } else {
                                  setState(() {
                                    isPhone = false;
                                  });
                                }
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  isPhone = true;
                                } else {
                                  isPhone = false;
                                }
                                //   return Validator.validateFormField(
                                //       value,
                                //       "phone number is required",
                                //       null,
                                //       Constants.PHONE_VALIDATION);
                                // },
                                // onFieldSubmitted: (String value) {
                                //   FocusScope.of(context).requestFocus(secondFocusNode);
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
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.withOpacity(0.2))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: passwordTextController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                        NoLeadingSpaceFormatter()
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10),
                        constraints: BoxConstraints.tight(Size.fromHeight(35)),
                        border: InputBorder.none,
                        labelStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: AppColor.grey600,
                                  fontSize: 14.0,
                                ),
                        icon: Icon(
                          Icons.lock,
                          color: AppColor.iconValue,
                        ),

                        // labelText: "Password",
                        // prefixIcon: Icon(Icons.lock,color: Color.fromRGBO(229, 229, 229,1),),
                        // suffixIcon: passwordTextController.text.isNotEmpty
                        //     ? IconButton(
                        //         icon: Icon(icon),
                        //         color: AppColor.grey600,
                        //         onPressed: () {
                        //           hidePassword();
                        //         })
                        //     : null,
                        suffixIcon: isPass == true
                            ? Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Password is required",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : null,
                      ),

                      textInputAction: TextInputAction.done,
                      // focusNode: secondFocusNode,
                      obscureText: isHidePassword!,
                      obscuringCharacter: "*",
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            isPass = true;
                          });
                        } else {
                          setState(() {
                            isPass = false;
                          });
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          isPass = true;
                        } else {
                          isPass = false;
                        }
                        //   return Validator.validateFormField(
                        //       value,
                        //       "Password is required",
                        //       null,
                        //       Constants.NORMAL_VALIDATION);
                      },
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
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey.withOpacity(0.2))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: conformPasswordTextController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[^\*]")),
                        NoLeadingSpaceFormatter()
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10),
                        constraints: BoxConstraints.tight(Size.fromHeight(35)),
                        border: InputBorder.none,
                        labelStyle:
                            Theme.of(context).textTheme.bodyText2!.copyWith(
                                  color: AppColor.grey600,
                                  fontSize: 14.0,
                                ),
                        icon: Icon(
                          Icons.lock,
                          color: AppColor.iconValue,
                        ),

                        // labelText: "Password",
                        // prefixIcon: Icon(Icons.lock,color: Color.fromRGBO(229, 229, 229,1),),
                        // suffixIcon:
                        //     conformPasswordTextController.text.isNotEmpty
                        //         ? IconButton(
                        //             icon: Icon(icon),
                        //             color: AppColor.grey600,
                        //             onPressed: () {
                        //               hidePassword();
                        //             })
                        //         : null,
                        suffixIcon: isPass1 == true
                            ? Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Password is required",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : null,
                      ),

                      textInputAction: TextInputAction.done,
                      // focusNode: secondFocusNode,
                      obscureText: isHidePassword!,
                      obscuringCharacter: "*",
                      validator: (value) {
                        value!.isEmpty ? isPass1 = true : isPass1 = false;
                        // return Validator.validateFormField(
                        //     value,
                        //     "Confirm Password is required",
                        //     null,
                        //     Constants.NORMAL_VALIDATION);
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            isPass1 = true;
                          });
                        } else {
                          setState(() {
                            isPass1 = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // elevation: MaterialStateProperty.all(0.0),
                padding: const EdgeInsets.all(10.0),
                primary: AppColor.appColorSecondaryValue,
                shadowColor: AppColor.appColorSecondaryValue,
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              onPressed: () {
                onPressedRegister();
              },
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width / 1.3,
                child: Center(
                  child: Text(
                    "Register",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Or continue with",
              style: TextStyle(color: AppColor.appColorPrimaryValue),
            ),
          ],
        ),
      ),
    );
  }

  Widget errorMessage() {
    if (isemail == true) {
      return Text(
        email!,
        style: TextStyle(color: Colors.red),
      );
    } else {
      if (isemailValid == true && isemail == false) {
        return Text(
          email!,
          style: TextStyle(color: Colors.red),
        );
      } else if (isemailValid == false && isemail == false) {
        return Text("");
      } else {
        return Text("");
      }
    }
  }

  hidePassword() {
    if (isHidePassword!) {
      isHidePassword = false;
      icon = Icons.visibility_off;
    } else {
      isHidePassword = true;
      icon = Icons.remove_red_eye;
    }
    setState(() {});
  }

  Widget? authlogos() {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              await showToast(
                'Google',
                context: context,
                animation: StyledToastAnimation.fadeScale,
                backgroundColor: AppColor.appColorPrimaryValue,
              );
              await btnGoogleSignIn();
            },
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColor.appColorPrimaryValue,
              child: Icon(
                FontAwesomeIcons.google,
                size: 20,
                color: AppColor.white,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          if (Constants.isIOS())
            InkWell(
              onTap: () async {
                await showToast(
                  'Apple',
                  context: context,
                  animation: StyledToastAnimation.fadeScale,
                  backgroundColor: AppColor.appColorPrimaryValue,
                );
                await btnAppleSignIn();
              },
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppColor.appColorPrimaryValue,
                child: Icon(
                  FontAwesomeIcons.apple,
                  size: 20,
                  color: AppColor.white,
                ),
              ),
            ),
          if (Constants.isIOS())
            SizedBox(
              width: 20,
            ),
          // InkWell(
          //   onTap: () async {
          //     await showToast(
          //       'Facebook',
          //       context: context,
          //       animation: StyledToastAnimation.fadeScale,
          //       backgroundColor: AppColor.appColorPrimaryValue,
          //     );
          //     await btnFacebookSignIn();
          //   },
          //   child: CircleAvatar(
          //     radius: 16,
          //     backgroundColor: AppColor.appColorPrimaryValue,
          //     child: Icon(
          //       FontAwesomeIcons.facebook,
          //       size: 20,
          //       color: AppColor.white,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: 20,
          // ),
          InkWell(
            onTap: () async {
              await showToast(
                'LinkedIn',
                context: context,
                animation: StyledToastAnimation.fadeScale,
                backgroundColor: AppColor.appColorPrimaryValue,
              );
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      linkedInUserWidget(context),
                  fullscreenDialog: true,
                ),
              );
            },
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColor.appColorPrimaryValue,
              child: Icon(
                FontAwesomeIcons.linkedin,
                size: 20,
                color: AppColor.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  FutureOr btnFacebookSignIn() async {
    try {} catch (e) {
      print(e);
    }
  }

  PushtoPage(
      String? authname, String? uid, String? email, String? displayname) {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(
                authname: authname,
                uid: uid,
                email: email,
                displayname: displayname,
              )),
    );
  }

  Widget textcontent() {
    return Container(
      // height: 30,
      width: MediaQuery.of(context).size.width,
      child: Text(
          "The Henry, Bertha and Edward Rothman Foundation Rochester NY - Circleville OH - Cleveland OH",
          style: TextStyle(color: Colors.black26, fontSize: 12),
          textAlign: TextAlign.center),
    );
  }

  FutureOr callApi() async {
    countrylist = <CountryModel>[];
    String url =
        "https://assets.api-cdn.com/serpwow/serpwow_google_countries.json";
    var response = await http.get(Uri.parse(url));
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      if (response.body != null) {
        List country = jsonDecode(response.body);
        countrylist = country.map((e) => CountryModel.fromJson(e)).toList();
        setState(() {});
        return countrylist;
      } else {
        setState(() {});
        return "body is Null";
      }
    }
  }

  FutureOr? CallApiForRegisteration() async {
    Constants.progressDialog(true, context, "please Wait");
    String strJson = UserModel.addUserRegisterationInfo(
      nameTextController.text.toString(),
      emailOrPhoneTextController.text.toString(),
      SocialFacebookId!,
      SocialFacebookToken!,
      SocialLinkedInId!,
      SocialLinkedInToken!,
      SocialGmailId!,
      SocialAppleId!,
      selectedCountryCode!,
      selectedCountry!,
      phoneTextController.text.toString(),
      passwordTextController.text.toString(),
    );
    String url = Config().baseurl + "Member/Register";
    Map? result = await RegisterationParser.callApiforRegister(url, strJson);
    if (result!["errorCode"] == 0) {
      int? id;
      RegisterationModel? reg;
      reg = result["value"][1];
      //id = reg!.id!;
      if (_imageFromPicker != null) {
        await CallApiForUploadImage(id);
      } else {
        Constants.progressDialog(false, context, "");
        Fluttertoast.showToast(
          msg: result["value"][0],
          timeInSecForIosWeb: 3,
        );
      }

      Navigator.pop(context);
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

  CallApiForUploadImage(int? id) async {
    String? url = Config().baseurl + "Member/Upload";
    // Map strJson = UserModel.addUserUploadImageInfo(id!.toString(), _imageFromPicker!.path);
    Map? result = await RegisterationParser.callApiforUploadImage(
        url, _imageFromPicker!.path, id!);
    if (result!["errorCode"] == 0) {
      Constants.progressDialog(false, context, "");
      // print("IMAGEData:"+result["value"][1]);
      Fluttertoast.showToast(
        msg: result["value"][0],
        timeInSecForIosWeb: 3,
      );
    } else {
      Constants.progressDialog(false, context, "");
      print("ERRORIMAGE:" + result["value"]);
    }
  }

  void onPressedRegister() async {
    isInternet = await Constants.isInternetAvailable();
    if (isInternet!) {
      if (formKey.currentState!.validate() &&
          emailOrPhoneTextController.text.isNotEmpty &&
          nameTextController.text.isNotEmpty &&
          passwordTextController.text.isNotEmpty &&
          phoneTextController.text.isNotEmpty &&
          conformPasswordTextController.text.isNotEmpty) {
        if (conformPasswordTextController.text == passwordTextController.text) {
          await CallApiForRegisteration();
        } else {
          Fluttertoast.showToast(
            msg: "Password & Confirm Password aren't matching up.",
            timeInSecForIosWeb: 3,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Some fields are not filled yet",
          timeInSecForIosWeb: 3,
        );
      }
      setState(() {});
    } else {
      Fluttertoast.showToast(
        msg: "Internet not Active",
      );
    }
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
  }

  showImagePickerDialog(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom]);
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
                        primary: Colors.black,
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
                        primary: Colors.black,
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
        } else {}
        if (_imageFromPicker != null) {}
      });
    } catch (e) {
      print(e);
      if (imageSource == ImageSource.camera) {
      } else if (imageSource == ImageSource.gallery) {}
    }
  }

  nextScreen() {
    Navigator.push(context, SlideRightRoute(widget: HomeScreen()));
  }

  linkedInUserWidget(BuildContext context) {
    return LinkedInUserWidget(
      appBar: AppBar(
        title: const Text('OAuth User'),
      ),
      destroySession: logoutUser,
      redirectUrl: redirectUrl,
      clientId: clientId,
      clientSecret: clientSecret,
      projection: [
        ProjectionParameters.id,
        ProjectionParameters.localizedFirstName,
        ProjectionParameters.localizedLastName,
        ProjectionParameters.firstName,
        ProjectionParameters.lastName,
        ProjectionParameters.profilePicture,
      ],
      onError: (value) async {
        return print('ishtiaq error ${value}');
      },
      onGetUserProfile: (UserSucceededAction linkedInUser) async {
        await linkedInLogin(linkedInUser, context);
        Navigator.pop(context);
      },
    );
  }

  linkedInLogin(UserSucceededAction linkedInUser, BuildContext context) async {
    SocialLinkedInId =
        linkedInUser.user.email?.elements![0].handleDeep!.emailAddress;
    SocialLinkedInToken = linkedInUser.user.token.accessToken;

    final email =
        linkedInUser.user.email?.elements![0].handleDeep!.emailAddress ?? "";
    setState(
      () {
        emailOrPhoneTextController.text = email ?? "";
      },
    );
    SocialLinkedInToken = EncryptData.encryptAES(email);
    SocialLinkedInId = EncryptData.encryptAES(email);
  }

  btnGoogleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        var googleEmail = await googleSignInAccount.email;
        setState(
          () {
            emailOrPhoneTextController.text = googleEmail;
          },
        );
        SocialGmailId = EncryptData.encryptAES(googleEmail);
      }
    } catch (error) {
      print(error);
    }
  }

  btnAppleSignIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final email = credential.email ?? "";
      setState(
        () {
          emailOrPhoneTextController.text = email;
        },
      );
      SocialAppleId = EncryptData.encryptAES(credential.identityToken);
    } catch (error) {
      print(error);
    }
  }
}
