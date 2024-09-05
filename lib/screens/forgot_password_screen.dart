import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tanachyomi/config/config.dart';
import 'package:tanachyomi/models/forgorpasswordmodel.dart';
import 'package:tanachyomi/models/usermodel.dart';
import 'package:tanachyomi/parsers/forgot_password_parser.dart';
import 'package:tanachyomi/screens/home_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/validator.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailOrPhoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool? isVerifed = false;
  int? id;
  bool logoutUser = true;
  Widget? svg;
  bool? isemail = false;
  bool? isemailValid = false;
  String? email ="";
  bool? isPass = false;
  static Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regexEmail = new RegExp(emailPattern.toString());

  @override
  initState() {
    super.initState();
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
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
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
                      colors: [AppColor.black, Colors.transparent],
                    ).createShader(Rect.fromCenter(
                        center: Offset.fromDirection(100, 1),
                        height: rect.height,
                        width: rect.width));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/images/wall4.png',
                    // height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height / 12,
                  child: SingleChildScrollView(
                    primary: true,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColor.appColorPrimaryValue)),
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColor.appColorPrimaryValue)),
                              child: CircleAvatar(
                                radius: 95,
                                backgroundColor: Colors.transparent,
                                child: Image.asset("assets/images/forgetpassword.png",fit: BoxFit.fill,
                                height: 120,width: 120,),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                color: AppColor.appColorSecondaryValue,
                                fontSize: 26),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        loginForm(),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: Colors.blueAccent.shade700.withOpacity(0.2),
                          height: 1,
                          width: MediaQuery.of(context).size.width / 1.1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Return to"),
                        Text(
                          "Login",
                          style: TextStyle(color: AppColor.appColorSecondaryValue),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                  left: 20,
                  top: 55,
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        debugPrint("CLICKED::");
                      },
                      child: Icon(Icons.arrow_back_ios,color: AppColor.mainbg,)))
            ],
          )),
    );
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
                            fontSize: 14,
                            color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: emailOrPhoneTextController,
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp("[^\S*]")),
                        NoLeadingSpaceFormatter()
                      ],
                      enabled: isVerifed == true ? false:true,
                      readOnly: isVerifed == true ? true:false,
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
                          icon: Icon(Icons.mail,
                              color: AppColor.iconValue),
                          suffixIcon: errorMessage(),
                          // labelText: "Email",
                          ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value){
                        // print("EMAIL:"+email!);
                        if(value.isEmpty){ setState((){
                          email = Validator.validateFormField(
                              value,
                              "Email is required",
                              "Invalid Email",
                              Constants.EMAIL_VALIDATION);
                          isemail = true;
                        }); }
                        else{
                          if (regexEmail.hasMatch(value)) {
                            setState((){
                              email = Validator.validateFormField(
                                  value,
                                  "Email is required",
                                  "Invalid Email",
                                  Constants.EMAIL_VALIDATION);
                              isemailValid = false;
                              isemail = false;
                            });
                          } else {
                            setState((){
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
             SizedBox(
              height: 5,
            ),
            isVerifed == true ? Padding(
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
                        "New Password",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: passwordTextController,
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp("[^\S*]")),
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
                          icon: Icon(Icons.lock,
                              color: AppColor.iconValue),
                        suffixIcon: isPass == true
                            ? Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Password is required",
                            style: TextStyle(color: Colors.red),
                          ),
                        ) : null,
                          // labelText: "Email",
                          ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      onChanged: (value){
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
                        // }
                        // return Validator.validateFormField(
                        //     value,
                        //     "Password is required",
                        //     "",
                        //     Constants.NORMAL_VALIDATION);
                      },
                      // onFieldSubmitted: (String value) {
                      //   FocusScope.of(context).requestFocus(secondFocusNode);
                      // },
                    ),
                  ],
                ),
              ),
            ) : Container(),
            const SizedBox(
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
                onPressedResetPassword();
              },
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width / 1.3,
                child: Center(
                  child: Text(
                    isVerifed == true ? "Reset Password" : "Get Otp",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onPressedResetPassword()async {
    if(isVerifed == false){
      if(formKey.currentState!.validate() && emailOrPhoneTextController.text.isNotEmpty){
        await CallApiForSendOtp();
      }
      else{
      Fluttertoast.showToast(
        msg: "Please enter the Email",
        timeInSecForIosWeb: 3,
      );

      }
      setState(() {});
    }
    else{
      if(passwordTextController.text.isNotEmpty){
        await CallApiForResetPassword();
      }
      else{
        Fluttertoast.showToast(
          msg: "Please enter the password",
          timeInSecForIosWeb: 3,
        );
      }
    }
  }

  CallApiForSendOtp()async{
    Constants.progressDialog(true, context, "please Wait");
    String? strJson = UserModel.addUserGetOtpInfo(
      emailOrPhoneTextController.text
    );
    String? url = Config().baseurl+"Member/GetOtp";
    Map? result = await ForgotPasswordParser.callApi(url, strJson);
    if(result!["errorCode"] == 0){
      // Constants.progressDialog(false, context, "");
      ForgotPasswordModel _forgotpass = result["value"];
      String? otp = _forgotpass.OTP;
      id = _forgotpass.memberId;
      bool? isexist = _forgotpass.isExist;
      if(isexist == true){
        await CallApiForVerifyOtp(otp,id);
      }
      else{
        Constants.progressDialog(false, context, "");
        Fluttertoast.showToast(
          msg: "User not Existed",
          timeInSecForIosWeb: 3,
        );
      }
    }
    else if(result["errorCode"] == -1){
      Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: result["value"],
        timeInSecForIosWeb: 3,
      );
    }
    else{
      Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: "error found",
        timeInSecForIosWeb: 3,
      );
    }
  }

  CallApiForVerifyOtp(String? otp,int? id) async {
    String? strJson = UserModel.addUserValidateOtpInfo(
      otp!,
      id.toString()
    );
    String? url = Config().baseurl+"Member/ValidateOtp";
    Map? result = await ForgotPasswordParser.callApiForValidateOtp(url, strJson);
    if(result!["errorCode"] == 0){
      Constants.progressDialog(false, context, "");
      String? otpValid = result["value"];
      if(otpValid == "VALID"){
        Fluttertoast.showToast(
          msg: "Otp Successfully Verified",
          timeInSecForIosWeb: 3,
        );
        setState((){
          isVerifed = true;
        });
      }
      else{
        Fluttertoast.showToast(
          msg: "Otp is Invalid",
          timeInSecForIosWeb: 3,
        );
      }
    }
    else if(result["errorCode"] == -1){
      Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: result["value"],
        timeInSecForIosWeb: 3,
      );
    }
    else{
      Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: "error found",
        timeInSecForIosWeb: 3,
      );
    }

  }

  CallApiForResetPassword() async{
    Constants.progressDialog(true, context, "please Wait");
    String? strJson = UserModel.addUserResetPasswordInfo(
        id.toString(),
        passwordTextController.text.toString()
    );
    String? url = Config().baseurl+"Member/SavePassword";
    Map? result = await ForgotPasswordParser.callApiForResetPassword(url, strJson);
    if(result!["errorCode"] == 0){
      Constants.progressDialog(false, context, "");
      String? mes = result["value"];
        Fluttertoast.showToast(
          msg: mes!,
          timeInSecForIosWeb: 3,
        );
        Navigator.pop(context);
    }
    else if(result["errorCode"] == -1){
      Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: result["value"],
        timeInSecForIosWeb: 3,
      );
    }
    else{
      Constants.progressDialog(false, context, "");
      Fluttertoast.showToast(
        msg: "error found",
        timeInSecForIosWeb: 3,
      );
    }
  }

  Widget errorMessage(){
    if(isemail == true){
      return Text(
        email!,
        style: TextStyle(color: Colors.red),
      );
    }
    else {
      if(isemailValid == true && isemail == false){
        return Text(
          email!,
          style: TextStyle(color: Colors.red),
        );
      }
      else if(isemailValid == false && isemail == false){
        return Text("");
      }
      else{
        return Text("");
      }
    }
  }

  nextScreen() {
    Navigator.push(context, SlideRightRoute(widget: HomeScreen()));
  }
}
