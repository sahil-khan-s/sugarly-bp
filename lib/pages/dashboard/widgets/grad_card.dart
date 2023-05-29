import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_string.dart';
class GradCard extends StatelessWidget {

  List<Color> gradientColors;
  String label;
  String counter;

  GradCard({super.key,
    required this.gradientColors,
    required this.counter,
    required this.label});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 70.h,
      width: 70.w,
      decoration: BoxDecoration(
        borderRadius:const BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors:gradientColors,
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(counter,style: TextStyle(color: AppColors.white,fontSize: 14.sp),),
          SizedBox(height: 4.h,),
          Text(label,style: TextStyle(color: AppColors.white,fontSize: 10.sp)),
        ],), //declare your widget here
    );
  }
}
