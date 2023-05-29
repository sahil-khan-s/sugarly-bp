import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bpcheck/pages/caretaker/caretaker_dashboard.dart';
import 'package:bpcheck/pages/doctor/doctor_dashboard.dart';
import 'package:bpcheck/utils/alert_dialogs.dart';
import 'package:bpcheck/utils/toasty.dart';
import 'package:bpcheck/utils/widget_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/widget_interactions.dart';
import '../../config/app_string.dart';
import '../../models/user_data.dart';
import '../../shared/app_button.dart';
import '../../shared/auth_top_bar.dart';
import '../../shared/custom_loading.dart';
import '../../shared/custom_text_field.dart';
import '../../shared/parent_widget.dart';
import '../../utils/app_utils.dart';
import '../forget_password/forget_password_screen.dart';
import '../patient_screens/patient_dashboard.dart';
import '../register/register_screen.dart';
import 'auth_service.dart';
import 'database_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CustomTextField tfEmail = CustomTextField();
  CustomTextField tfPassword = CustomTextField();


  @override
  Widget build(BuildContext context) {
//tfEmail.tfController.text="dsa@gmail.com"; //doc
//tfEmail.tfController.text="qwe@gmail.com";  //caretaker
/*tfEmail.tfController.text="asd@gmail.com"; //patient
tfPassword.tfController.text="123456789";*/
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
         // resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.bgColor,
          body: Stack(
            children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(AppAssets.bgFooter,height: 250.h
                  )),
              Container(
                padding: EdgeInsets.only(right: 35.h, left: 35.h,top: 35.h),
                child: Column(
                  children: [
                    WidgetUtils.appLogo(),
                    SizedBox(
                      height: 35.h,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.welcome,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: AppColors.lightBlackColor),
                        )),
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: AuthTopBar(
                                barVisibility: true,
                                title: AppStrings.LOGIN,
                                textColor: AppColors.primaryColor,
                              )),
                          Expanded(
                              child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                                  },
                                  child: AuthTopBar(
                                    barVisibility: false,
                                    title: AppStrings.REGISTER,
                                    textColor: AppColors.greyText,
                                  ))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    tfEmail.setHint(AppStrings.emailAddress).setEmailField(true),
                    SizedBox(
                      height: 20.h,
                    ),
                    tfPassword
                        .setHint(AppStrings.PASSWORD)
                        .setFieldType(TextFieldType.PASSWORD),
                    SizedBox(
                      height: 20.h,
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {

                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
                        },
                        child: Text(
                          AppStrings.forgetPassword,
                          style:
                          TextStyle(fontSize: 12.sp, color: AppColors.greyText),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: "appbtn",
                          child: AppButton(
                              buttonText: AppStrings.login,
                              margin: EdgeInsets.zero,
                              height: 25.h,
                              onClick: () {
                                loginUser();
                              }),
                        ),
                        Row(
                          children: [
                            Text(
                              AppStrings.newUser,
                              style:
                              TextStyle(fontSize: 12.sp, color: AppColors.greyText),
                            ),

                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                              },
                              child: Text(
                                AppStrings.register,
                                style:
                                TextStyle(fontSize: 12.sp, color: AppColors.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );

  }
  Future<bool> _onBackPressed() async{
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Do you want to exit the App'),
          actions: <Widget>[
            AppButton(
              onClick: (){ Navigator.of(context).pop(false);},
              buttonText: "No",
              margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
              height: 25.h,
              width: 50.w,
            ),
            AppButton(
              onClick: (){ Navigator.of(context).pop(true);},
              buttonText: "Yes",
              margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
              height: 25.h,
              width: 50.w,
            ),

          ],
        );
      },
    ) ?? false;
  }
  void loginUser() async{

     bool hasError = validateAll([
      tfEmail,
       tfPassword,
    ]);
    if (hasError) {
      return;
    }
   /*  if (AppUtils.isPasswordValid(
         tfPassword.tfController.text) ==
         false) {
      Toasty.error("Password must contains lower , upper, digits & special chars");
       return;
     }*/
    loginThisUser();
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
  void loginThisUser() async{
    SmartDialog.showLoading(
        msg: "Please wait...",
        builder: (_) => const CustomLoading(
          type: 2,
        ));
    dynamic result = await Provider.of<AuthService>(context,listen: false).signInWithEmail(
        tfEmail.tfController.text, tfPassword.tfController.text);
    if (result is UserCredential) {
      Provider.of<DatabaseService>(context,listen: false).getUserData();
      Timer(Duration(seconds: 2), () {
        SmartDialog.dismiss();

            if(UserData.instance.role == "doctor")
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorDashboard()));

        if(UserData.instance.role == "caretaker")
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CaretakerDashboard()));
        if(UserData.instance.role == "patient")
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientDashboard()));

      });
      print('Login successful $result');

    } else {
      SmartDialog.dismiss();
      CustomAlertDialogs.alertDialog(context,title: "Error",description: result,dialogType: DialogType.error);
      print('Error: $result');
    }
  }

}
