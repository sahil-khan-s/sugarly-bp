
import 'package:bpcheck/pages/patient_screens/weight/weight_record_model.dart';
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

class WeightScreen extends StatefulWidget {
  const WeightScreen({Key? key}) : super(key: key);

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final DateFormat _dateFormat = DateFormat('MMM d, y');
  final DateFormat _timeFormat = DateFormat('h:mm a');
  CustomTextField tfWeight = CustomTextField();
  CustomTextField tfNotes = CustomTextField();

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
        title: Text('Weight'),
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
              Text(AppStrings.weight,style: TextStyle(color: AppColors.bgBoarding,fontSize: 12.sp)),
              SizedBox(height: 10.h,),

              tfWeight.setHint(AppStrings.weight).setSuffixIcon(Icons.add),
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
      tfWeight,
      tfNotes
    ]);
    if (hasError) {
      return;
    }
    WeightRecordModel weightRecordModel=WeightRecordModel(weight: tfWeight.tfController.text,notes: tfNotes.tfController.text);

    Provider.of<DatabaseService>(context,listen: false).addRecord('weight', weightRecordModel.toJson());
    tfWeight.tfController.text="";
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
