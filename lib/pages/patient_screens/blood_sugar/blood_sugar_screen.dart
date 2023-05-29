import 'package:bpcheck/pages/patient_screens/blood_sugar/widgets/icon_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
import 'bs_record_model.dart';

class BloodSugarScreen extends StatefulWidget {
  const BloodSugarScreen({Key? key}) : super(key: key);

  @override
  State<BloodSugarScreen> createState() => _BloodSugarScreenState();
}

class _BloodSugarScreenState extends State<BloodSugarScreen> {
  final DateFormat _dateFormat = DateFormat('MMM d, y');
  final DateFormat _timeFormat = DateFormat('h:mm a');
  CustomTextField tfSugarConcentration = CustomTextField();
  CustomTextField tfNotes = CustomTextField();
  String measured = 'Before Breakfast';
  final currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final dateString = _dateFormat.format(currentDate);
    final timeString = _timeFormat.format(currentDate);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('Blood Sugar'),
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
          Text(AppStrings.sugarConcentration,style: TextStyle(color: AppColors.bgBoarding,fontSize: 12.sp)),
            SizedBox(height: 10.h,),

            tfSugarConcentration.setHint(AppStrings.sugarConcentration).setSuffixIcon(Icons.add),
            SizedBox(height: 20.h,),
            Text(AppStrings.measured,style: TextStyle(color: AppColors.bgBoarding,fontSize: 12.sp)),
              SizedBox(height: 10.h,),
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
                  value: measured,
                  style: TextStyle(
                      color: AppColors.greyText, fontSize: 10.sp),
                  decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none),
                  items:const [
                    DropdownMenuItem(
                      child: Text('Before Breakfast'),
                      value: 'Before Breakfast',
                    ),
                    DropdownMenuItem(
                      child: Text('After Breakfast'),
                      value: 'After Breakfast',
                    ),
                    DropdownMenuItem(
                      child: Text('Before Lunch'),
                      value: 'Before Lunch',
                    ),
                    DropdownMenuItem(
                      child: Text('After Lunch'),
                      value: 'After Lunch',
                    ),
                    DropdownMenuItem(
                      child: Text('Before Dinner'),
                      value: 'Before Dinner',
                    ),
                    DropdownMenuItem(
                      child: Text('After Dinner'),
                      value: 'After Dinner',
                    ),
                    DropdownMenuItem(
                      child: Text('Before Sleep'),
                      value: 'Before Sleep',
                    ),
                    DropdownMenuItem(
                      child: Text('After Sleep'),
                      value: 'After Sleep',
                    ),
                    DropdownMenuItem(
                      child: Text('Fasting'),
                      value: 'Fasting',
                    ),
                    DropdownMenuItem(
                      child: Text('Others'),
                      value: 'Others',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      measured = value!;
                    });
                  },
                ),
              ),


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
    tfSugarConcentration,
      tfNotes
    ]);
    if (hasError) {
      return;
    }
    BSRecord bsRecord=BSRecord(sugarConcentration: tfSugarConcentration.tfController.text,measured: measured,notes: tfNotes.tfController.text,date: _dateFormat.format(currentDate));

    Provider.of<DatabaseService>(context,listen: false).addRecord('bloodSugar', bsRecord.toJson());
    tfSugarConcentration.tfController.text="";
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
