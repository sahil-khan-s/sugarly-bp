import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;

  IconText({required this.text,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        SizedBox(width: 8.w),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}