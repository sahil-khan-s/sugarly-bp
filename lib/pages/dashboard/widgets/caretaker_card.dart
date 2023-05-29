import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_string.dart';
import '../../../shared/app_button.dart';
import '../../../shared/app_card.dart';
import 'card_label.dart';

class CaretakerCard extends StatelessWidget {
  const CaretakerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: AppCard(
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 5.w, vertical: 5.h),
          child: Column(
            children: [
              CardLabel(
                  icon: AppAssets.records,
                  label: AppStrings.records),
              SizedBox(
                height: 8.h,
              ),
              AppCard(Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AppAssets.patients,width: 25.w,height: 25.h,fit: BoxFit.contain),

                  Text(AppStrings.viewAllPatients,
                      style: TextStyle(
                        color: AppColors.lightBlackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      )),
                  AppButton(
                    buttonText: AppStrings.view,
                    margin: EdgeInsets.zero,
                    onClick: () {},
                    height: 30.h,
                  )
                ],
              )),
              SizedBox(height: 5.h),
              AppCard(Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AppAssets.report,width: 25.w,height: 20.h,fit: BoxFit.contain),

                  Text(AppStrings.addYourReports,
                      style: TextStyle(
                        color: AppColors.lightBlackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      )),
                  AppButton(
                    buttonText: AppStrings.view,
                    margin: EdgeInsets.zero,
                    onClick: () {},
                    height: 30.h,
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
