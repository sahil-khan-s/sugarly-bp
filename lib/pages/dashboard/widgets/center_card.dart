import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_colors.dart';
class CenterCard extends StatelessWidget {
  String icon;
  String label;


  CenterCard({
   required this.icon,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 90.h,
        width: 80.w,
        decoration: BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(20)),
            color: AppColors.bgCard
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(icon),
              SizedBox(height: 4.h,),
              Center(child: Text(label,style: TextStyle(color: AppColors.lightBlackColor,fontSize: 10.sp,fontWeight: FontWeight.w500),textAlign: TextAlign.center,)),
            ],),
        ), //declare y
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
