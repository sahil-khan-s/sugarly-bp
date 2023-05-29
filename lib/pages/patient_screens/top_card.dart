import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_colors.dart';
class TopCard extends StatelessWidget {
String icon;
String title;
Color bgColor=AppColors.bgColor;

TopCard({
  required this.icon,
  required this.title,
});

TopCard setBgColor(Color color){
  bgColor=color;
  return this;
}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        height: 65.h,
        width: 65.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(icon,height: 40.h,width: 40.w,fit: BoxFit.fill),
          SizedBox(height: 8.h,),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: bgColor == AppColors.primaryColor? AppColors.btnSkip: AppColors.lightBlackColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600
              ))
        ],),
      ),
    );
  }
}
