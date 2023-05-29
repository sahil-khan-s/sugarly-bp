import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget _child;
   EdgeInsetsGeometry padding;

   AppCard(this._child, {this.padding =const EdgeInsets.symmetric(horizontal: 20, vertical: 20) });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: AppColors.bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
          padding:padding ,
          child: _child),
    );
  }

}
