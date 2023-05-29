import 'package:bpcheck/config/app_string.dart';
import 'package:bpcheck/config/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_colors.dart';
class WidgetUtils{

  static appLogo(){
    return   Row(
      children: [
        Text("S",style: TextStyle(fontSize: 44.sp,color: AppColors.bgBoarding),),
        SizedBox(width: 5.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.sugarly,style: TextStyle(fontSize: 16.sp,color: AppColors.primaryColor),),
            Text(AppStrings.bpManagement,style: TextStyle(fontSize: 12.sp,color: AppColors.bgBoarding),),

          ],),
      ],);
  }
}