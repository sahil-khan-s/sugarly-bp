import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_colors.dart';

class DrawerItems extends StatelessWidget {
  String icon;
  String title;
  Widget nextScreen;

  DrawerItems({super.key,
     required this.icon,
     required this.title,
     required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
     //   Navigator.pop(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => nextScreen));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
        child: Row(children: [
          Image.asset(
            icon,
            color: AppColors.white,
            width: 20.w,
            height: 20.h,
          ),
          SizedBox(width: 16.w,),
          Text(title,style: TextStyle(color: AppColors.white,fontSize: 12.sp),)
        ],),
      ),
    );
  }
}
