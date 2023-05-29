import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_string.dart';
import '../../shared/top_bar.dart';
import '../dashboard/widgets/data_text.dart';
class PatientScreen extends StatefulWidget {
  List<Map<String, dynamic>> usersList;

  PatientScreen({required this.usersList});
  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [
              AppTopBar(
                  rightIcon: AppAssets.icBackArrow,
                  rightIconBgColor: AppColors.primaryColor,
                  toolbarLabel: AppStrings.patients),
              SizedBox(
                height: 20.h,
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,),
                  child:  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: widget.usersList.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return  Card(
                        elevation: 5,
                        color: AppColors.bgColor,
                        shape: Border(
                            bottom: BorderSide(
                                color: AppColors.greyText, width: 5)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              DataText(
                                title: AppStrings.fullName,
                                description: "${widget.usersList[index]["name"]}",
                              ),
                              DataText(
                                title: AppStrings.phNo,
                                description:
                                "${widget.usersList[index]["phone_number"]}",
                              ),
                              DataText(
                                title: AppStrings.address,
                                description: "${widget.usersList[index]["address"]}",
                              ),
                              DataText(
                                title: AppStrings.emailAddress,
                                description: "${widget.usersList[index]["email"]}",
                              ),

                              SizedBox(
                                height: 4.h,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
