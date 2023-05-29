import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_string.dart';

class AppTopBar extends StatelessWidget {
  String rightIcon;
  String leftIcon;
  Color rightIconBgColor;
  String toolbarLabel;

  AppTopBar(
      {required this.rightIcon,
      required this.rightIconBgColor,
      required this.toolbarLabel,
      this.leftIcon=AppAssets.btnMenu});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              width: 50.w,
              height: 35.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: AppColors.bgBoarding,
              ),
              child: Center(
                  child: Image.asset(
                leftIcon,
                width: 30.w,
                height: 30.h,
              )),
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                toolbarLabel,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: AppColors.lightBlackColor),
              )),
          Visibility(
            visible: false,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 50.w,
                height: 35.h,
                decoration:  BoxDecoration(
                  borderRadius:const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  color: rightIconBgColor,
                ),
                child: Center(
                    child: Image.asset(rightIcon,
                        width: 30.w, height: 30.h)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
