import 'package:bpcheck/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_string.dart';
import '../../shared/app_button.dart';
import '../../shared/app_card.dart';
import '../../shared/auth_top_bar.dart';
import '../../shared/custom_text_field.dart';
import '../../shared/parent_widget.dart';
import '../../shared/top_bar.dart';
import '../../utils/app_constants.dart';
import '../../utils/widget_interactions.dart';
import '../login/database_service.dart';

class PrimaryInfoScreen extends StatefulWidget {
  const PrimaryInfoScreen({Key? key}) : super(key: key);

  @override
  State<PrimaryInfoScreen> createState() => _PrimaryInfoScreenState();
}

class _PrimaryInfoScreenState extends State<PrimaryInfoScreen> {
  CustomTextField tfName = CustomTextField();
  CustomTextField tfPhoneNo = CustomTextField();
  CustomTextField tfEmailAddress = CustomTextField();
  CustomTextField tfAddress = CustomTextField();

  @override
  Widget build(BuildContext context) {
    UserData userData=UserData.instance;

    tfName.tfController.text=userData.name!;
    tfPhoneNo.tfController.text=userData.phoneNumber!;
    tfEmailAddress.tfController.text=userData.email!;
    tfAddress.tfController.text=userData.address!;


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(AppStrings.settings),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the previous screen
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        SizedBox(
                          height: 8.h,
                        ),
                        AppCard(Column(
                          children: [

                            CircleAvatar(
                                radius: 35.sp,
                                backgroundColor: AppColors.white,
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.bgGrey,
                                  size: 60.sp,
                                )),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "${userData.name}",
                              style: TextStyle(color: AppColors.lightBlackColor, fontSize: 12.sp,fontWeight: FontWeight.w600),
                            ),

                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                                height: 30.h,
                                child: tfName
                                    .setHint(AppStrings.fullName)
                                    .setSuffixIconVisible(true)),
                            SizedBox(
                              height: 10.h,
                            ),

                            SizedBox(
                                height: 30.h,
                                child: tfEmailAddress
                                    .setHint(AppStrings.emailAddress)
                                    .setSuffixIconVisible(true)
                                    .setIsEnabled(false)
                            .setSuffixIcon(Icons.email)),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                                height: 30.h,
                                child: tfPhoneNo
                                    .setHint(AppStrings.phoneNumber)
                                    .setSuffixIconVisible(true)),
                            SizedBox(
                              height: 10.h,
                            ),

                            SizedBox(
                                height: 30.h,
                                child: tfAddress
                                    .setHint(AppStrings.address)
                                    .setSuffixIconVisible(false)),
                            SizedBox(
                              height: 10.h,
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: AppButton(
                                buttonText: AppStrings.update,
                                margin: EdgeInsets.zero,
                                width: 80.w,
                                onClick: () {
                                  updateUser();
                                },
                                height: 25.h,
                              ),
                            ),

                          ],
                        )),
                        SizedBox(
                          height: 20.h,
                        ),

                        SizedBox(
                          height: 8.h,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void updateUser() {
    bool hasError = validateAll([
      tfName,
      tfPhoneNo,
      tfAddress,
    ]);
    if (hasError) {
      return;
    }
    Provider.of<DatabaseService>(context,listen: false).updateUserData(tfName.tfController.text,
        tfPhoneNo.tfController.text,
        tfAddress.tfController.text,);


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

}