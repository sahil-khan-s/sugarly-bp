
import 'package:bpcheck/pages/doctor/patiens_record_screen.dart';
import 'package:bpcheck/pages/patient_screens/blood_sugar/bs_records_screen.dart';
import 'package:bpcheck/pages/patient_screens/doctors_list/doctors_list_screen.dart';
import 'package:bpcheck/pages/patient_screens/medication/medication_records_screen.dart';
import 'package:bpcheck/pages/patient_screens/statistics/sugar_chart.dart';
import 'package:bpcheck/pages/patient_screens/weight/weight_records_screen.dart';
import 'package:bpcheck/pages/settings/primary_info_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_string.dart';
import '../../dashboard/widgets/drawer_item.dart';
import '../blood_pressure/blood_pressure_screen.dart';
import '../blood_pressure/bp_record_screen.dart';
import '../blood_sugar/blood_sugar_screen.dart';
import '../caretakers_list/caretakers_list_screen.dart';
import '../insulin/insulin_records_screen.dart';
import '../medication/medication_screen.dart';
import '../statistics/statistics_screen.dart';

class DashboardCardData{
  String _icon;
  String _title;
  Widget _screen;
  bool requiresAssignedPatient;

  static String patientId="";

  DashboardCardData(this._icon, this._title, this._screen,
      {this.requiresAssignedPatient = false});

static List<DashboardCardData> itemList=[
  DashboardCardData(AppAssets.stats, AppStrings.statistics,SugarChart()),
  DashboardCardData(AppAssets.icCaretaker, AppStrings.addCaretaker,SelectCaretaker()),
  DashboardCardData(AppAssets.icDoctors, AppStrings.addDoctor,SelectDoctor()),
  DashboardCardData(AppAssets.sugar, AppStrings.bloodSugar, BloodSugarRecords()),
  DashboardCardData(AppAssets.medicine, AppStrings.medication, MedicationRecords()),
  DashboardCardData(AppAssets.icInsuline, AppStrings.insulin, InsulinRecords()),
  DashboardCardData(AppAssets.bloodPressure, AppStrings.bloodPressure, BloodPressureRecords()),
  DashboardCardData(AppAssets.weight, AppStrings.weight, WeightRecords()),
  DashboardCardData(AppAssets.profile, AppStrings.primaryInfo,const PrimaryInfoScreen()),
];

static List<DashboardCardData> doctorList=[
  DashboardCardData(AppAssets.profile, AppStrings.primaryInfo,const PrimaryInfoScreen()),
  DashboardCardData(AppAssets.viewRecord, AppStrings.viewRecords,PatientsRecordScreen()),
];

  static List<DashboardCardData> caretakerList = [
    DashboardCardData(AppAssets.stats, AppStrings.statistics, SugarChart(),
        requiresAssignedPatient: true),
    DashboardCardData(AppAssets.sugar, AppStrings.bloodSugar,
        BloodSugarRecords(), requiresAssignedPatient: true),
    DashboardCardData(AppAssets.medicine, AppStrings.medication,
        MedicationRecords(), requiresAssignedPatient: true),
    DashboardCardData(AppAssets.icInsuline, AppStrings.insulin, InsulinRecords(),requiresAssignedPatient: true),

    DashboardCardData(AppAssets.bloodPressure, AppStrings.bloodPressure,
        BloodPressureRecords(), requiresAssignedPatient: true),
    DashboardCardData(AppAssets.weight, AppStrings.weight,
        WeightRecords(), requiresAssignedPatient: true),
    DashboardCardData(AppAssets.profile, AppStrings.primaryInfo,
        const PrimaryInfoScreen()),
  ];


  static List<DrawerItems> drawerPatientsList = [
    DrawerItems(
        icon: AppAssets.stats,
        title: AppStrings.statistics,
        nextScreen: SugarChart()),
    DrawerItems(
        icon: AppAssets.icCaretaker,
        title: AppStrings.addCaretaker,
        nextScreen: SelectCaretaker()),
    DrawerItems(
        icon: AppAssets.icDoctors,
        title: AppStrings.addDoctor,
        nextScreen: SelectDoctor()),
    DrawerItems(
        icon: AppAssets.sugar,
        title: AppStrings.bloodSugar,
        nextScreen: BloodSugarRecords()),
    DrawerItems(
        icon: AppAssets.medicine,
        title: AppStrings.medication,
        nextScreen: MedicationRecords()),
    DrawerItems(
        icon: AppAssets.icInsuline,
        title: AppStrings.insulin,
        nextScreen: InsulinRecords()),
    DrawerItems(
        icon: AppAssets.bloodPressure,
        title: AppStrings.bloodPressure,
        nextScreen: BloodPressureRecords()),
    DrawerItems(
        icon: AppAssets.weight,
        title: AppStrings.weight,
        nextScreen: WeightRecords()),
    DrawerItems(
        icon: AppAssets.profile,
        title: AppStrings.primaryInfo,
        nextScreen: const PrimaryInfoScreen()),
  ];

  static List<DrawerItems> drawerDoctorList = [
    DrawerItems(
        icon: AppAssets.profile,
        title: AppStrings.primaryInfo,
        nextScreen: const PrimaryInfoScreen()),
    DrawerItems(
        icon: AppAssets.viewRecord,
        title: AppStrings.viewRecords,
        nextScreen: PatientsRecordScreen()),
  ];

  static List<DrawerItems> drawerCaretakerList = [
    DrawerItems(
      icon: AppAssets.stats,
      title: AppStrings.statistics,
      nextScreen: SugarChart(),
    ),
    DrawerItems(
      icon: AppAssets.sugar,
      title: AppStrings.bloodSugar,
      nextScreen: BloodSugarRecords(),
    ),
    DrawerItems(
      icon: AppAssets.medicine,
      title: AppStrings.medication,
      nextScreen: MedicationRecords(),
    ),
    DrawerItems(
      icon: AppAssets.icInsuline,
      title: AppStrings.insulin,
      nextScreen: InsulinRecords(),
    ),
    DrawerItems(
      icon: AppAssets.bloodPressure,
      title: AppStrings.bloodPressure,
      nextScreen: BloodPressureRecords(),
    ),
    DrawerItems(
      icon: AppAssets.weight,
      title: AppStrings.weight,
      nextScreen: WeightRecords(),
    ),
    DrawerItems(
        icon: AppAssets.profile,
        title: AppStrings.primaryInfo,
        nextScreen: const PrimaryInfoScreen()),
  ];


  Widget get screen => _screen;

  set screen(Widget value) {
    _screen = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get icon => _icon;

  set icon(String value) {
    _icon = value;
  }
}