import 'package:flutter/cupertino.dart';

import 'app_colors.dart';
import 'app_dimens.dart';

class AppTextStyles {
  static TextStyle appBarLabelTextStyle = TextStyle(
      color: AppColors.white,
      fontSize: AppDimens.appBarLabelTextSize,
      fontWeight: FontWeight.bold);

  static TextStyle headingTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontSize: AppDimens.headingTextSize,
  );

  static TextStyle normalWhiteTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: AppDimens.normalTextSize,
  );
  static TextStyle smallWhiteTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: AppDimens.smallTextSize,
  );
  static TextStyle normalYellowTextStyle = TextStyle(
    color: AppColors.yellow,
    fontSize: AppDimens.normalTextSize,
  );
  static TextStyle normalBlackTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontSize: AppDimens.normalTextSize,
  );
  static TextStyle smallBlackTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontSize: AppDimens.smallTextSize,
  );

  static TextStyle normalGreenTextStyle = TextStyle(
    color: AppColors.primaryColor,
    fontSize: AppDimens.normalTextSize,
  );

  static TextStyle descriptionTextStyle = TextStyle(
    color: AppColors.descriptionTextColor,
    fontSize: AppDimens.normalTextSize,
  );
  static TextStyle labelTextStyle = TextStyle(
    color: AppColors.labelColor,
    fontSize: AppDimens.normalTextSize,
  );
  static TextStyle hintTextStyle = TextStyle(
    color: AppColors.hintColor,
    fontSize: AppDimens.smallTextSize,
  );

  static TextStyle hintSmallTextStyle = TextStyle(
    color: AppColors.labelColor,
    fontSize: AppDimens.smallTextSize,
  );
  static TextStyle tfInputTextStyle = TextStyle(
    color: AppColors.tfTextColor,
    fontSize: AppDimens.normalTextSize,
  );

  static TextStyle errorTextStyle = TextStyle(
      height: 0.5,
      color: AppColors.tfErrorBorderColor,
      fontSize: AppDimens.smallTextSize);

  static TextStyle dropDownTextStyle = TextStyle(
    color: AppColors.labelColor,
    fontSize: AppDimens.normalTextSize,
  );
}
