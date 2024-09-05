import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/screens/home_screen.dart';
import 'package:tanachyomi/screens/thankyou_sponsor_screen.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/sliderightroute.dart';
import 'package:tanachyomi/utils/theme.dart';
import 'package:tanachyomi/utils/validator.dart';

class SponsorModuleScreen extends StatefulWidget {
  const SponsorModuleScreen({Key? key}) : super(key: key);

  @override
  State<SponsorModuleScreen> createState() => _SponsorModuleScreenState();
}

class _SponsorModuleScreenState extends State<SponsorModuleScreen> {
  TextEditingController fnameTextController =
      TextEditingController(text: "John");
  TextEditingController lnameTextController =
      TextEditingController(text: "Smith");
  TextEditingController emailTextController =
      TextEditingController(text: "johnpaul@myemail.com");
  TextEditingController suggestionTextController =
      TextEditingController(text: "write here");

  final List<String> sponsorModuleItems = [
    'Library Section',
    'Leadership Board Section',
    'Achievement Section',
    'Other',
  ];

  String? selectedValue;
  bool isdark = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isdark = theme.getTheme() == theme.darkTheme ? true : false;
        return WillPopScope(
          onWillPop: (){
            return handleBackPress();
          },
          child: Scaffold(
            body: sponsormodulebody(),
          ),
        );
      }
    );
  }

  Widget sponsormodulebody() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: isdark == true ? Image.asset(
                      "assets/images/amicodark.png",
                      alignment: Alignment.bottomCenter,
                    ):Image.asset(
                      "assets/images/amico.png",
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                    top: 50,
                    left: 15,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 24,
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                "Sponsor a Module",
                style: TextStyle(
                    color: isdark == true ? AppColor.appColorPrimaryValue:AppColor.appColorSecondaryValue,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Center(
                child: Text(
                  "of Tanach Yomi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: isdark == true ? AppColor.appColorSecondaryValue:AppColor.appColorPrimaryValue,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Center(
                child: Text(
                  "Enter your information and select an option for your sponsorship and we will contact you",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "First Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.appColorPrimaryValue),
                            ),
                          ),
                          TextFormField(
                            cursorColor: AppColor.black,
                            controller: fnameTextController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[^\S*]")),
                              NoLeadingSpaceFormatter()
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10),
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
                              // labelText: "Email",
                            ),
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validator.validateFormField(
                                  value,
                                  "firstname is required",
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
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Last Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.appColorPrimaryValue),
                            ),
                          ),
                          TextFormField(
                            cursorColor: AppColor.black,
                            controller: lnameTextController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[^\S*]")),
                              NoLeadingSpaceFormatter()
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 10),
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
                              // labelText: "Email",
                            ),
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              return Validator.validateFormField(
                                  value,
                                  "Lastname is required",
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
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: isdark == true ? AppColor.white: Colors.grey.withOpacity(0.2))),
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
                      controller: emailTextController,
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
                          icon: Icon(Icons.mail, color: AppColor.iconValue)
                          // labelText: "Email",
                          ),
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
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
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 2,
              endIndent: 120,
              indent: 120,
              color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
              thickness: 1.0,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Select one of our modules to sponsor",
                        style: TextStyle(
                            fontSize: 14, color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 1,right: 1),
                        border: InputBorder.none,
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: false,
                      hint: const Text(
                        'Select Sponsor Module',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: isdark == true ? AppColor.white:Colors.black45,
                      ),
                      iconSize: 30,
                      // buttonHeight: 60,
                      // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      // dropdownDecoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      items: sponsorModuleItems
                          .map((item) =>
                          DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select one';
                        }
                      },
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 3.5,
                  color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                ),
                Text("or",
                    style: TextStyle(
                      color: AppColor.appColorSecondaryValue,
                      fontSize: 20
                    )),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 3.5,
                  color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                // margin: EdgeInsets.only(left: 15, right: 15),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: isdark == true ? AppColor.mainbg:AppColor.grey1.shade100,
                  // borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text(
                          "Suggest a new section that you want to sponsor",textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border:
                            Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "Suggestions",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColor.appColorPrimaryValue),
                              ),
                            ),
                            TextFormField(
                              cursorColor: AppColor.black,
                              controller: suggestionTextController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[^\S*]")),
                                NoLeadingSpaceFormatter()
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10),
                                // constraints:
                                // BoxConstraints.tight(Size.fromHeight(35)),
                                border: InputBorder.none,
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                  color: AppColor.grey600,
                                  fontSize: 14.0,
                                ),
                                // labelText: "Email",
                              ),
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                return Validator.validateFormField(
                                    value,
                                    "Suggestion is required",
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
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 2,
              endIndent: 120,
              indent: 120,
              color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
              thickness: 1.0,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // elevation: MaterialStateProperty.all(0.0),
                  padding: const EdgeInsets.all(10.0),
                  primary: isdark == true ? AppColor.appColorSecondaryValue:AppColor.grey600,
                  shadowColor: isdark == true ? AppColor.appColorSecondaryValue:AppColor.grey600,
                  elevation: 2,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                onPressed: () {
                  // Navigator.push(context, SlideRightRoute(
                  //     widget: ThankYouSponsorScreen())
                  // );
                  showDialog(
                    context: context,
                    useSafeArea: true,
                    builder: (_) => /*SponsorScreen()*/ThankYouSponsordialog(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width / 1.15,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/send.png",
                          height: 20,
                          width: 20,
                          color: isdark == true ? AppColor.white:null,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Send",
                          style: TextStyle(color: AppColor.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleBackPress() {
    return Navigator.pop(context);
  }

  Widget ThankYouSponsordialog(){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(15.0),
        color: Colors.transparent,
        // color: AppColor.white,
        // height: MediaQuery.of(context).size.height/1.4,
        child: Card(
          elevation: 10,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: isdark == true ? Image.asset(
                    "assets/images/thankyoudark.png",
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 2,
                  ):Image.asset(
                    "assets/images/thankyou.png",
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 2,
                  endIndent: 20,
                  indent: 20,
                  color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "THANK YOU",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 26),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 2,
                  endIndent: 20,
                  indent: 20,
                  color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Your sponsorship request was sent and will be reviewed as soon as possible and we will contact you through your email",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 2,
                  endIndent: 120,
                  indent: 120,
                  color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // elevation: MaterialStateProperty.all(0.0),
                    padding: const EdgeInsets.all(10.0),
                    primary: isdark == true ? AppColor.appColorPrimaryValue:AppColor.appColorSecondaryValue,
                    shadowColor: isdark == true ? AppColor.appColorPrimaryValue:AppColor.appColorSecondaryValue,
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.push(context, SlideRightRoute(
                        widget: HomeScreen())
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width / 1.25,
                    child: Center(
                      child: Text(
                        "Close",
                        style: TextStyle(color: AppColor.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
