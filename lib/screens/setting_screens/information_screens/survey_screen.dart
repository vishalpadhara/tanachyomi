import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tanachyomi/utils/appcolor.dart';
import 'package:tanachyomi/utils/constant.dart';
import 'package:tanachyomi/utils/noleadingspaceformatter.dart';
import 'package:tanachyomi/utils/theme.dart';
import 'package:tanachyomi/utils/validator.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  bool? isdark = false;
  TextEditingController surveyTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      isdark = theme.getTheme() == theme.darkTheme ? true : false;
        return WillPopScope(
          onWillPop: () {
            return handleBackPress();
          },
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.grey600,
                  )),
              backgroundColor: isdark == true ? AppColor.white:AppColor.white,
              elevation: 0,
              bottom: PreferredSize(
                  child: Container(
                    color: AppColor.appColorSecondaryValue,
                    height: 4.0,
                  ),
                  preferredSize: Size.fromHeight(4.0)),
              title: Text(
                "Survey",
                style: TextStyle(color: AppColor.appColorSecondaryValue,fontSize: 18),
              ),
            ),
            body: surveybody(),
          ),
        );
      }
    );
  }

  Widget surveybody(){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text(
                "Provide Feedback to make Nach Nook even better",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                // height: 100,
                padding: EdgeInsets.only(left: 10, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: isdark == true ? AppColor.white:Colors.grey.withOpacity(0.2))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Write here",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColor.appColorPrimaryValue),
                      ),
                    ),
                    TextFormField(
                      cursorColor: AppColor.black,
                      controller: surveyTextController,
                      maxLines: 3,
                      // minLines: 1,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [NoLeadingSpaceFormatter()],
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        // contentPadding: EdgeInsets.only(bottom: 8),
                        // constraints:
                        // BoxConstraints.tight(Size.fromHeight(40)),
                        border: InputBorder.none,
                        labelStyle:
                        Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppColor.grey600,
                          fontSize: 24.0,
                        ),
                      ),

                      textInputAction: TextInputAction.done,
                      // focusNode: secondFocusNode,
                      validator: (value) {
                        return Validator.validateFormField(
                            value,
                            "Survey is required",
                            null,
                            Constants.NORMAL_VALIDATION);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Divider(
              height: 2,
              endIndent: 15,
              indent: 15,
              color: isdark == true ? AppColor.white:Colors.blueAccent.shade700.withOpacity(0.2),
              thickness: 1.0,
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                // elevation: MaterialStateProperty.all(0.0),
                padding: const EdgeInsets.only(left:10.0,right: 10),
                primary: AppColor.appColorPrimaryValue,
                shadowColor: AppColor.appColorPrimaryValue,
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              onPressed: () {},
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                width: MediaQuery.of(context).size.width / 1.15,
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: AppColor.white),
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

}
