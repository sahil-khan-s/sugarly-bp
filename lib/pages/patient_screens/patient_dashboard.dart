
import 'package:bpcheck/pages/patient_screens/top_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_string.dart';
import '../../models/user_data.dart';
import '../../shared/top_bar.dart';
import '../../utils/widget_utils.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard/widgets/card_label.dart';
import '../dashboard/widgets/data_text.dart';
import '../dashboard/widgets/drawer.dart';
import '../login/login_screen.dart';
import 'models/dashboard_card_data.dart';
class PatientDashboard extends StatefulWidget {
  const PatientDashboard({Key? key}) : super(key: key);

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,

      child: SafeArea(
        child: Scaffold(
          drawer: DrawerMenu(DashboardCardData.drawerPatientsList),
          backgroundColor: AppColors.bgColor,
          body: Column(
            children: [
              SizedBox(height:20.h),
              AppTopBar(
                  rightIcon: AppAssets.notification,
                  rightIconBgColor: AppColors.bgNotification,
                  toolbarLabel: AppStrings.myDashboard),
              SizedBox(height:10.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child:Column(children: [
                  //WidgetUtils.appLogo(),

                  CardLabel(
                      icon: AppAssets.personPng,
                      label: AppStrings.primaryInfo),
                  SizedBox(
                    height: 8.h,
                  ),
                  Card(
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
                            description: "${UserData.instance.name}",
                          ),
                          DataText(
                            title: AppStrings.emailAddress,
                            description:
                            "${UserData.instance.email}",
                          ),
                          DataText(
                            title: AppStrings.phNo,
                            description:
                            "${UserData.instance.phoneNumber}",
                          ),
                          DataText(
                            title: AppStrings.address,
                            description: "${UserData.instance
                                .address}",
                          ),


                          SizedBox(
                            height: 4.h,
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],)


              ),


              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w,),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: List.generate(DashboardCardData.itemList.length, (index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardCardData.itemList[index].screen));
                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                            child:  TopCard(icon: DashboardCardData.itemList[index].icon, title:  DashboardCardData.itemList[index].title)),
                      );

                    },),
                  ),
                ),
              ),
              SizedBox(height: 20.h,)
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return ( await showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
        title:  Text(AppStrings.areYouSure),
        content:  Text(AppStrings.doYouWantToLogout),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:  Text(AppStrings.no),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginScreen())),
            child:  Text(AppStrings.yes),
          ),
        ],
      ),
    )) ?? false;
  }
}
