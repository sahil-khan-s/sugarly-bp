import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/app_colors.dart';
class DataText extends StatelessWidget {

  String title;
  String description;

  DataText({
    required this.title,
    required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Expanded(child: Text(title,style: TextStyle(color: AppColors.bgBoarding,fontSize: 12.sp),)),
          Expanded(child: Text(description,style: TextStyle(color: AppColors.greyText,fontSize: 12.sp)))
        ],
      ),
    );
  }
}
