import 'package:bpcheck/pages/patient_screens/medication/medication_record.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_string.dart';
import '../../../shared/app_button.dart';
import '../../../shared/custom_text_field.dart';
import '../../../shared/parent_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/widget_interactions.dart';
import '../../login/database_service.dart';
import '../blood_sugar/widgets/icon_text.dart';
class MedicationScreen extends StatefulWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  final DateFormat _dateFormat = DateFormat('MMM d, y');
  final DateFormat _timeFormat = DateFormat('h:mm a');
  CustomTextField tfMedication = CustomTextField();
  CustomTextField tfDosage = CustomTextField();
  CustomTextField tfNotes = CustomTextField();
  String unit = 'mg';

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final dateString = _dateFormat.format(currentDate);
    final timeString = _timeFormat.format(currentDate);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(AppStrings.medication),
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
        padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconText(text:  dateString,icon: Icons.date_range),
                  IconText(text: timeString,icon: Icons.access_time,),
                ],
              ),
              SizedBox(height: 30.h,),
              Text(AppStrings.medication,style: TextStyle(color: AppColors.bgBoarding,fontSize: 12.sp)),

              SizedBox(height: 10.h,),
              tfMedication.setHint(AppStrings.medication).setSuffixIcon(Icons.add),
              SizedBox(height: 20.h,),
              Row(
                children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(AppStrings.dosage,style: TextStyle(color: AppColors.bgBoarding,fontSize: 12.sp)),
                    SizedBox(height: 8.h,),
                    tfDosage.setHint(AppStrings.dosage).setSuffixIcon(Icons.add),

                  ],),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(AppStrings.measured,style: TextStyle(color: AppColors.bgBoarding,fontSize: 12.sp)),
                    SizedBox(height: 8.h,),
                    Container(
                      height: 40.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.greyText),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: DropdownButtonFormField(
                        value: unit,
                        style: TextStyle(
                            color: AppColors.greyText, fontSize: 10.sp),
                        decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none),
                        items:const [
                          DropdownMenuItem(
                            child: Text('mg'),
                            value: 'mg',
                          ),
                          DropdownMenuItem(
                            child: Text('unit'),
                            value: 'unit',
                          ),
                          DropdownMenuItem(
                            child: Text('ml'),
                            value: 'ml',
                          ),
                          DropdownMenuItem(
                            child: Text('tablet'),
                            value: 'tablet',
                          ),

                        ],
                        onChanged: (value) {
                          setState(() {
                            unit = value!;
                          });
                        },
                      ),
                    ),
                  ],),
                ),
              ],),



              SizedBox(height: 20.h,),
              Text(AppStrings.notes,style: TextStyle(color: AppColors.bgBoarding,fontSize: 12.sp)),
              SizedBox(height: 10.h,),
              tfNotes.setHint(AppStrings.notes).setSuffixIcon(Icons.notes),
              SizedBox(height: 20.h,),

              Align(
                alignment: Alignment.center,
                child: AppButton(
                    buttonText: AppStrings.save,
                    margin: EdgeInsets.zero,
                    height: 30.h,
                    onClick: () {
                      saveSugarData();
                    }),
              )
            ],),
        ),
      ),
    );
  }
  void saveSugarData() {
    bool hasError = validateAll([
      tfMedication,
      tfDosage,
      tfNotes
    ]);
    if (hasError) {
      return;
    }
    MedicationRecord medicationRecord=MedicationRecord(medication: tfMedication.tfController.text,dosage: tfDosage.tfController.text,
    notes: tfNotes.tfController.text,unit: unit
    );

    Provider.of<DatabaseService>(context,listen: false).addRecord('medication', medicationRecord.toJson());
    tfMedication.tfController.text="";
    tfDosage.tfController.text="";
    tfNotes.tfController.text="";
  }

  bool validateAll([List<ParentWidget> args = const []]) {
    bool hasError = false;
    for (ParentWidget inputField in args) {
      bool isError = WidgetInteractions.instance.validateWidget(
          inputField, inputField.tags[AppConstants.FIELD_TYPE].toString());
      if (isError) {
        hasError = true;
      }
    }
    return hasError;
  }

}
