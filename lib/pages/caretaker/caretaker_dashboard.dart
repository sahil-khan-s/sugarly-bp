import 'package:bpcheck/config/app_colors.dart';
import 'package:flutter/material.dart';

import '../../config/app_assets.dart';
import '../../config/app_string.dart';
import '../../models/user_data.dart';
import '../../shared/top_bar.dart';
import '../dashboard/widgets/card_label.dart';
import '../dashboard/widgets/data_text.dart';
import '../dashboard/widgets/drawer.dart';
import '../login/database_service.dart';
// class CaretakerDashboard extends StatefulWidget {
//
//
//   @override
//   _CaretakerDashboardState createState() => _CaretakerDashboardState();
// }
//
// class _CaretakerDashboardState extends State<CaretakerDashboard> {
//   final DatabaseService _databaseService = DatabaseService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Caretaker Dashboard'),backgroundColor: AppColors.primaryColor,),
//       body: StreamBuilder<String?>(
//         stream: _databaseService.assignedPatientIdStream(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           if (snapshot.hasData) {
//             final patientId = snapshot.data;
//             if (patientId != null) {
//               return Text('Patient ID: $patientId');
//             }
//             return Text('No patient assigned');
//           }
//
//           return Center(child: Text('No patient assigned'));
//         },
//       ),
//     );
//   }
// }



import 'package:bpcheck/pages/patient_screens/top_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/app_colors.dart';
import '../../utils/widget_utils.dart';
import '../dashboard/dashboard_screen.dart';
import '../login/login_screen.dart';
import '../patient_screens/blood_pressure/bp_record_screen.dart';
import '../patient_screens/blood_sugar/bs_records_screen.dart';
import '../patient_screens/caretakers_list/caretakers_list_screen.dart';
import '../patient_screens/medication/medication_records_screen.dart';
import '../patient_screens/models/dashboard_card_data.dart';
import '../patient_screens/statistics/sugar_chart.dart';
import '../patient_screens/weight/weight_records_screen.dart';
import '../settings/primary_info_screen.dart';
class CaretakerDashboard extends StatefulWidget {
  const CaretakerDashboard({Key? key}) : super(key: key);

  @override
  State<CaretakerDashboard> createState() => _CaretakerDashboardState();
}

class _CaretakerDashboardState extends State<CaretakerDashboard> {
  final DatabaseService _databaseService = DatabaseService();
  Future<String?> _getPatientName(String patientId) async {
    final patient = await _databaseService.getPatient(patientId);
    return patient?['name'];
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          drawer: DrawerMenu(DashboardCardData.drawerCaretakerList),
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
                child: StreamBuilder<String?>(
                  stream: _databaseService
                      .assignedPatientIdStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    List<DashboardCardData> filteredItems = [];
                    Widget? patientNameLabel;

                    if (snapshot.hasData) {
                      final String? patientId = snapshot.data;
                      filteredItems = DashboardCardData.caretakerList
                          .where((item) => !item.requiresAssignedPatient ||
                          (item.requiresAssignedPatient &&
                              patientId != null))
                          .toList();

                      if (patientId != null) {
                        DashboardCardData.patientId=patientId;
                        patientNameLabel = FutureBuilder<String?>(
                          future: _getPatientName(patientId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            }
                            return Text("Patient: ${snapshot.data}",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor));
                          },
                        );
                      }
                    } else {
                      filteredItems = DashboardCardData.caretakerList
                          .where((item) => !item.requiresAssignedPatient)
                          .toList();
                    }

                    return Column(
                      children: [
                        if (patientNameLabel != null)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: patientNameLabel,
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
                              children: List.generate(filteredItems.length, (index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                        filteredItems[index].screen));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    child: TopCard(
                                        icon: filteredItems[index].icon,
                                        title: filteredItems[index].title),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
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
