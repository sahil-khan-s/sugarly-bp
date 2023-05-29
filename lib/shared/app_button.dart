import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
class AppButton extends StatelessWidget {
  final String buttonText;
  final EdgeInsets margin;
  final Function onClick;
  double? height;
  double? width;
  AppButton({
    required this.buttonText,
    required this.margin,
    required this.onClick,
    this.height,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      height: height ?? 40.h,
      width: width ?? 80.h,
      margin: margin,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),
        child: Text(
          buttonText,
          style:TextStyle(
            color: AppColors.white,
            fontSize: 12.sp,
          ),
        ),
        onPressed: () {
          onClick();
        },
        color: AppColors.primaryColor,
        minWidth: double.infinity,
      ),
    );
  }
}
class AppButtonBordered extends StatelessWidget {
  final String buttonText;
  final EdgeInsets margin;
  final Function onClick;
  double? height;
  double? width;
  AppButtonBordered({
    required this.buttonText,
    required this.margin,
    required this.onClick,
    this.height,
    this.width
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color:AppColors.blackColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      height: height ?? 40.h,
      width: width ?? 80.h,
      margin: margin,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0) ),
        child: Text(
          buttonText,
          style:TextStyle(
            color: AppColors.blackColor,
            fontSize: 12.sp,
          ),
        ),
        onPressed: () {
          onClick();
        },
        color: AppColors.white,
        minWidth: double.infinity,
      ),
    );
  }
}

