import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTopBar extends StatelessWidget {
  String title;
  Color textColor;
  bool barVisibility;


  AuthTopBar({
    required this.title,
    required this.textColor,
    required this.barVisibility
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 13.sp,
              color: textColor),
        ),
        SizedBox(height: 6.h,),
        Visibility(
            visible:barVisibility,
            child: Container(color: textColor,height: 1.h,width: 30.w,))
      ],
    );
  }
}
