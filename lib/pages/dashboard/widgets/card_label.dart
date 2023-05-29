import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_colors.dart';
class CardLabel extends StatelessWidget {

  CardLabel({
    required this.icon,
    required this.label});
  String icon;
  String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(icon,width: 20.w,height: 20.h,fit: BoxFit.contain),
        SizedBox(width: 10.w,),
        Text(label,style: TextStyle(color: AppColors.blackColor,fontSize: 14.sp,fontWeight: FontWeight.w700,))
      ],
    );
  }

}
