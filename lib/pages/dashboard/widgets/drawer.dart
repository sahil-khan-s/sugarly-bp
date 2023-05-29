import 'package:bpcheck/pages/settings/primary_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../config/app_string.dart';
import '../../doctor/patiens_record_screen.dart';
import '../../patient_screens/blood_pressure/bp_record_screen.dart';
import '../../patient_screens/blood_sugar/bs_records_screen.dart';
import '../../patient_screens/caretakers_list/caretakers_list_screen.dart';
import '../../patient_screens/doctors_list/doctors_list_screen.dart';
import '../../patient_screens/insulin/insulin_records_screen.dart';
import '../../patient_screens/medication/medication_records_screen.dart';
import '../../patient_screens/statistics/sugar_chart.dart';
import '../../patient_screens/weight/weight_records_screen.dart';
import '../dashboard_screen.dart';
import 'drawer_item.dart';

class DrawerMenu extends StatelessWidget {

  List<DrawerItems> list;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      child: Drawer(
        backgroundColor: AppColors.bgDrawer,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 30.h),
          children: list,
        ),
      ),
    );
  }

  DrawerMenu(this.list);
}
