import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tanachyomi/config/config.dart';
import 'package:tanachyomi/models/loginmodel.dart';
import 'package:tanachyomi/models/usermodel.dart';
import 'package:tanachyomi/parsers/login_parser.dart';
import 'package:tanachyomi/screens/forgot_password_screen.dart';
import 'package:tanachyomi/screens/home_screen.dart';
import 'package:tanachyomi/screens/registeration_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/clippath.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/current_userinfo.dart';
import 'package:tanachyomi/utils/encrypter_key.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/validator.dart';

String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

class _LoginScreenState extends State<LoginScreen> {
  String redirectUrl = 'http://localhost:54307/signin-linkedin';
  String clientId = '78pgrr6nj6754c';
  String clientSecret = 'LlqT1Sh5dZjJlJbz';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailOrPhoneTextController =
      TextEditingController(text: "demo@demo.com");
  TextEditingController passwordTextController =
      TextEditingController(text: "test1");
  bool? isHidePassword = true;
  IconData icon = Icons.remove_red_eye;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Map<String, dynamic>? _userData;
  UserModel? user;
  bool logoutUser = true;
  bool isGood = false;
  bool? isemail = false;
  bool? isemailValid = false;
  bool? isPass = false;
  String? email = "";
  static Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regexEmail = new RegExp(emailPattern.toString());
  String? SocialFacebookId = "";
  String? SocialFacebookToken = "";
  String? SocialLinkedInId = "";
  String? SocialLinkedInToken = "";
  String? SocialGmailId = "";
  String? SocialAppleId = "";
  bool? isInternet = true;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    if (mediaQueryData.size <= const Size(360.0, 720.0)) {
      isGood = true;
      setState(() {});
    } else {
      isGood = false;
      setState(() {});
    }
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.grey,
        splashColor: Colors.black,
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.black),
        ),
        colorScheme: ColorScheme.light(
          primary: AppColor.white,
        ),
        dialogBackgroundColor: Colors.white,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: CommonLayoutforSplashLogin(),
      ),
    );
    //);
  }

  Widget CommonLayoutforSplashLogin() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/images/wall4.png',
                  // height: 400,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: new ClipRect(
                            child: new BackdropFilter(
                              filter: new ImageFilter.blur(
                                  sigmaX: 1.0, sigmaY: 1.0),
                              child: new Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                height:
                                    MediaQuery.of(context).size.height / 3.8,
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
                    SizedBox(
                      height: 10,
                    ),
                    loginForm(),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.blueAccent.shade700.withOpacity(0.2),
                      height: 1,
                      width: MediaQuery.of(context).size.width / 1.1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    authlogos()!,
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.blueAccent.shade700.withOpacity(0.2),
                      height: 1,
                      width: MediaQuery.of(context).size.width / 1.1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            SlideRightRoute(widget: RegisterationScreen()));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 21,
                        child: Column(
                          children: [
                            Text(
                              "Don`t Have account?",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Register Now",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.appColorSecondaryValue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                // color: Colors.red,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    ClipPath(
                                      clipper: ClipPathValue(),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20),
                                        child: Container(
                                          padding: EdgeInsets.only(top: 5),
                                          color: AppColor.appColorPrimaryValue,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              13,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          child: Text(
                                              "The Tanach Yomi App is Sponsored by",
                                              style: TextStyle(
                                                  fontSize:
                                                      isGood == true ? 14 : 18,
                                                  color: AppColor.white),
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
                                      child: Container(
                                        height: 2,
                                        margin: EdgeInsets.only(
                                            right: 10, left: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 3,
                                              offset: Offset(
                                                  1, 4), // Shadow position
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Positioned(
                              //     bottom: -45,
                              //     child: textcontent())
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          textcontent()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  loginForm() {
    return Form(
      key: formKey,
      child: Container(
        // height : MediaQuery.of(context).size.height/2.65,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome Back!",
              style: TextStyle(
                  color: AppColor.appColorSecondaryValue, fontSize: 24),
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
                    // SizedBox(
                    //   height: 5,
                    // ),
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
                          // prefixIcon: Icon(Icons.mail,color: AppColor.iconValue),
                          icon: Icon(Icons.mail, color: AppColor.iconValue),
                          suffixIcon: errorMessage()
                          // labelText: "Email",
                          ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
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
                        suffixIcon: isPass == true
                            ? Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Password is required",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : null,
                        // suffixIcon: passwordTextController.text.isNotEmpty
                        //     ? IconButton(
                        //         icon: Icon(icon),
                        //         color: AppColor.grey600,
                        //         onPressed: () {
                        //           hidePassword();
                        //         })
                        //     : null,
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
            SizedBox(
              height: 5,
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
                // onPressedLoginBtn();
                print('Set Dark theme');
                // theme.getTheme() == theme.darkTheme ?
                // theme.setLightMode():
                // theme.setDarkMode();
                onPressedLogin();
              },
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width / 1.3,
                child: Center(
                  child: Text(
                    "Sign In",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context, SlideRightRoute(widget: ForgotpasswordScreen()));
                },
                child: Text(
                  "forgot Password?",
                  style: TextStyle(color: AppColor.appColorPrimaryValue),
                )),
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
              await signInWithGoogle(context);
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
                  builder: (BuildContext context) {
                    return linkedInUserWidget(context);
                  },
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

  LinkedInUserWidget linkedInUserWidget(BuildContext context) {
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
      },
    );
  }

  void onPressedLogin() async {
    isInternet = await Constants.isInternetAvailable();
    if (isInternet!) {
      if (formKey.currentState!.validate() &&
          emailOrPhoneTextController.text.isNotEmpty &&
          passwordTextController.text.isNotEmpty) {
        await CallApiForLogin();
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

  PushtoPage(
      String? authname, String? uid, String? email, String? displayname) {
    return Navigator.push(
      context,
      SlideRightRoute(
        widget: HomeScreen(
          authname: authname,
          uid: uid,
          email: email,
          displayname: displayname,
        ),
      ),
    );
  }

  CallApiForLogin() async {
    Constants.progressDialog(true, context, "please Wait");
    String strJson = UserModel.addUserLoginInfo(
      emailOrPhoneTextController.text.toString(),
      passwordTextController.text.toString(),
      SocialFacebookId!,
      SocialFacebookToken!,
      SocialLinkedInId!,
      SocialLinkedInToken!,
      SocialGmailId!,
      SocialAppleId!,
    );
    String url = Config().baseurl + "Member/Authenticate";
    Map? result = await LoginParser.callApi(url, strJson);
    if (result!["errorCode"] == 0) {
      Constants.progressDialog(false, context, "");
      LoginModel login = result["value"];
      String? mes = login.message;
      int? code = login.errcode;
      if (code == 200) {
        int? id = login.id;
        CurrentUserInfo.currentUserId = id!.toString();
        await CurrentUserInfo.setUserIdInPreferenece(id);
        Fluttertoast.showToast(
          msg: mes!,
          timeInSecForIosWeb: 3,
        );
        PushtoPage("null", "null", "null", "null");
      } else {
        print("LOGIN1::" + mes!);
        Fluttertoast.showToast(
          msg: mes,
          timeInSecForIosWeb: 3,
        );
        // PushtoPage("null","null","null","null");
      }
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

  Widget textcontent() {
    return Container(
      // height: 30,
      width: MediaQuery.of(context).size.width / 1.18,
      child: Text(
          "The Henry, Bertha and Edward Rothman Foundation Rochester NY - Circleville OH - Cleveland OH",
          style: TextStyle(color: Colors.black26, fontSize: 12),
          textAlign: TextAlign.center),
    );
  }

  nextScreen() {
    Navigator.push(context, SlideRightRoute(widget: HomeScreen()));
  }

  FutureOr<bool> OnBackHandled() {
    return true;
  }

  btnAppleSignIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      SocialAppleId = EncryptData.encryptAES(credential.identityToken);
      await CallApiForLogin();
    } catch (error) {
      print(error);
    }
  }

  btnFacebookSignIn() {}

  signInWithGoogle(BuildContext context) async {
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
        await CallApiForLogin();
      }
    } on PlatformException catch (e) {
      print('PlatformException>> $e');
    }
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
    setState(() {
      Navigator.pop(context);
    });
    await CallApiForLogin();
  }
}
