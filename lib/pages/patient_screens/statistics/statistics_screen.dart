import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'blood_sugar_chart.dart';
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Sugar Chart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        height: 250.h,
        margin:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),

        child: BloodSugarChart(
          bloodSugarData: [
            BloodSugarData(date: 'Apr 1', value: 1.5),
            BloodSugarData(date: 'Apr 2', value: 2.0),
            BloodSugarData(date: 'Apr 3', value: 3.8),
            BloodSugarData(date: 'Apr 4', value: 5.2),
            BloodSugarData(date: 'Apr 5', value: 6.5),
            BloodSugarData(date: 'Apr 6', value: 5.9),
            BloodSugarData(date: 'Apr 7', value: 4.4),
          ],
        ),
      ),
    );
  }
}