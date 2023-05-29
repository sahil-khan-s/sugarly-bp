import 'package:bpcheck/models/user_data.dart';
import 'package:bpcheck/pages/dashboard/widgets/card_label.dart';
import 'package:bpcheck/pages/dashboard/widgets/caretaker_card.dart';
import 'package:bpcheck/pages/dashboard/widgets/data_text.dart';
import 'package:bpcheck/pages/dashboard/widgets/doctor_card.dart';
import 'package:bpcheck/pages/dashboard/widgets/drawer.dart';
import 'package:bpcheck/pages/dashboard/widgets/patient_card.dart';
import 'package:bpcheck/shared/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/app_string.dart';
import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../shared/app_button.dart';
import '../../shared/app_card.dart';
import '../../shared/top_bar.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  CustomTextField tfTrackingNo = CustomTextField();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
          child: Scaffold(
            //drawer: DrawerMenu(Dash),
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                children: [
                  AppTopBar(
                      rightIcon: AppAssets.notification,
                      rightIconBgColor: AppColors.bgNotification,
                      toolbarLabel: AppStrings.myDashboard),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        child: Column(
                          children: [
                            if(UserData.instance.role == "doctor")
                              DoctorCard(),
                            if(UserData.instance.role == "patient")
                              PatientCard(),
                            if(UserData.instance.role == "caretaker")
                              CaretakerCard(),

                            CardLabel(
                                icon: AppAssets.personPng,
                                label: AppStrings.primaryInfo),
                            SizedBox(
                              height: 8.h,
                            ),
                            Card(
                              elevation: 5,
                              color: AppColors.bgColor,
                              shape: Border(
                                  bottom: BorderSide(
                                      color: AppColors.greyText, width: 5)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 20.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    DataText(
                                      title: AppStrings.fullName,
                                      description: "${UserData.instance.name}",
                                    ),
                                    DataText(
                                      title: AppStrings.phNo,
                                      description:
                                      "${UserData.instance.phoneNumber}",
                                    ),
                                    DataText(
                                      title: AppStrings.address,
                                      description: "${UserData.instance
                                          .address}",
                                    ),


                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(AppStrings.howToTypeAddress,
                                            style: TextStyle(
                                              color: AppColors.bgNotification,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ))),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<bool> _onBackPressed() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(AppStrings.areYouSure),
            content: Text(AppStrings.doYouWantToLogout),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppStrings.no),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppStrings.yes),
              ),
            ],
          ),
    )) ??
        false;
  }
}
