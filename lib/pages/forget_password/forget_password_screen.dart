import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_string.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/widget_interactions.dart';
import '../../shared/app_button.dart';
import '../../shared/custom_loading.dart';
import '../../shared/custom_text_field.dart';
import '../../shared/parent_widget.dart';
import '../../utils/widget_utils.dart';
import '../login/auth_service.dart';
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  CustomTextField tfEmailAddress = CustomTextField();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
     //   resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.bgColor,
        body: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(AppAssets.bgFooter,height: 250.h)),
            Container(
              padding: EdgeInsets.only(right: 35.h, left: 35.h,top: 35.h),
              child: Column(
                children: [
                  WidgetUtils.appLogo(),

                  SizedBox(
                    height: 35.h,
                  ),
                  SizedBox(height: 20.h,),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.forgetYourPassword,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: AppColors.lightBlackColor),
                      )),

                  SizedBox(
                    height: 35.h,
                  ),


                  SizedBox(height: 20.h,),
                  tfEmailAddress.setHint(AppStrings.emailAddress).setEmailField(true),
                  SizedBox(height: 40.h,),

                  Hero(
                    tag: "appbtn",
                    child: AppButton(
                        buttonText: AppStrings.getVerificationLink,
                        margin: EdgeInsets.symmetric(horizontal: 60.w),
                        height: 30.h,
                        width: 200.w,
                        onClick: () {
                          verifyUser();
                        }),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void verifyUser() async {
    bool hasError = validateAll([
     tfEmailAddress
    ]);

    if (hasError) {
      return;
    }
    resetPassword(tfEmailAddress.tfController.text);
  }

  bool validateAll([List<ParentWidget> args = const []]) {
    bool hasError = false;
    for (ParentWidget inputField in args) {
      bool isError = WidgetInteractions.instance.validateWidget(
          inputField, inputField.tags[AppConstants.FIELD_TYPE].toString());
      if (isError) {
        hasError = true;
      }
    }
    return hasError;
  }

  void resetPassword(String email) async{
    SmartDialog.showLoading(
        msg: "Please wait...",
        builder: (_) => const CustomLoading(
          type: 2,
        ));
    try {
      await _authService.resetPassword(email);
      SmartDialog.dismiss();
      tfEmailAddress.tfController.text="";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A reset link has been sent to $email'),
        ),
      );
    } catch (e) {
      SmartDialog.dismiss();
      tfEmailAddress.tfController.text="";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again'),
        ),
      );
    }
  }
}
