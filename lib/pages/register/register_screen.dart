import 'package:bpcheck/pages/login/login_screen.dart';
import 'package:bpcheck/utils/widget_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/widget_interactions.dart';
import '../../config/app_string.dart';
import '../../shared/app_button.dart';
import '../../shared/auth_top_bar.dart';
import '../../shared/custom_loading.dart';
import '../../shared/custom_text_field.dart';
import '../../shared/parent_widget.dart';
import '../../utils/toasty.dart';
import '../login/auth_service.dart';
import '../login/database_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  CustomTextField tfName = CustomTextField();
  CustomTextField tfPhoneNo = CustomTextField();
  CustomTextField tfEmailAddress = CustomTextField();
  CustomTextField tfPassword = CustomTextField();
  CustomTextField tfAddress = CustomTextField();
  String _role = 'patient';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.bgColor,
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 35.h),
            child: Column(
              children: [
                WidgetUtils.appLogo(),
                SizedBox(
                  height: 35.h,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.registerHeader,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: AppColors.lightBlackColor),
                    )),
                SizedBox(
                  height: 35.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                        child: AuthTopBar(
                          barVisibility: false,
                          title: AppStrings.LOGIN,
                          textColor: AppColors.greyText,
                        ),
                      )),
                      Expanded(
                          child: AuthTopBar(
                        barVisibility: true,
                        title: AppStrings.REGISTER,
                        textColor: AppColors.primaryColor,
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        tfName.setHint(AppStrings.fullName),
                        SizedBox(
                          height: 20.h,
                        ),
                        tfEmailAddress
                            .setHint(AppStrings.emailAddress)
                            .setEmailField(true)
                            .setSuffixIcon(Icons.email_outlined),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 40.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.greyText),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: DropdownButtonFormField(
                            value: _role,
                            style: TextStyle(
                                color: AppColors.greyText, fontSize: 10.sp),
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none),
                            items: [
                              DropdownMenuItem(
                                child: Text('Patient'),
                                value: 'patient',
                              ),
                              DropdownMenuItem(
                                child: Text('Doctor'),
                                value: 'doctor',
                              ),
                              DropdownMenuItem(
                                child: Text('Caretaker'),
                                value: 'caretaker',
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _role = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        tfPhoneNo
                            .setHint(AppStrings.phoneNumber)
                            .setSuffixIcon(Icons.phone)
                            .setKeyboardType(TextInputType.number)
                            .setInputValidators([
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ]),
                        SizedBox(
                          height: 20.h,
                        ),
                        tfAddress
                            .setHint(AppStrings.address)
                            .setSuffixIcon(Icons.details),
                        SizedBox(
                          height: 20.h,
                        ),

                        tfPassword
                            .setHint(AppStrings.password)
                            .setFieldType(TextFieldType.PASSWORD),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Hero(
                  tag: "appbtn",
                  child: AppButton(
                      buttonText: AppStrings.register,
                      margin: EdgeInsets.zero,
                      height: 30.h,
                      onClick: () {
                        registerUser();
                      }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    AppStrings.alreadyHaveAnAccount,
                    style:
                        TextStyle(fontSize: 12.sp, color: AppColors.greyText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return (await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen()))) ??
        false;
  }

  void registerUser() {
    bool hasError = validateAll([
      tfName,
      tfPhoneNo,
      tfEmailAddress,
      tfPassword,
      tfAddress,
    ]);
    if (hasError) {
      return;
    }
    registerUserInDb(tfName, tfPhoneNo, tfEmailAddress, tfPassword);
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

  void registerUserInDb(CustomTextField tfName, CustomTextField tfPhoneNo,
      CustomTextField tfEmailAddress, CustomTextField tfPassword) async {
    SmartDialog.showLoading(
        msg: "please wait...",
        builder: (_) => const CustomLoading(
              type: 2,
            ));
    dynamic result = await Provider.of<AuthService>(context, listen: false)
        .signUpWithEmail(
            tfEmailAddress.tfController.text, tfPassword.tfController.text);
    if (result is UserCredential) {
      await Provider.of<DatabaseService>(context, listen: false).createUser(
        result.user!.uid,
        _role,
        tfName.tfController.text,
        tfEmailAddress.tfController.text,
        tfPhoneNo.tfController.text,
        tfAddress.tfController.text,
      );
      SmartDialog.dismiss();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginScreen()));
      Toasty.success('Sign up successful');
    } else {
      SmartDialog.dismiss();
      Toasty.error('$result');
    }
  }
}
