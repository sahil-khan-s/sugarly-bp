import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_colors.dart';

class CustomAlertDialogs {

  static TextStyle normalWhiteTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 13,
  );
  static simpleAlertDialog(BuildContext context,
      {String? title,
      description,
      button1Text,
      button2Text,
      VoidCallback? btn1CallBack,
      btn2CallBack,
      Color? bgColor,
      double? radius}) {
    Widget cancelButton = TextButton(
      child: Text(button1Text ?? "Cancel"),
      onPressed: btn1CallBack,
    );
    Widget continueButton = TextButton(
      child: Text(button2Text ?? "Continue"),
      onPressed: btn2CallBack,
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 0)),
      title: Text(title ?? "AlertDialog"),
      content: Text(description ?? "Would you like to continue to next Page?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showBasicAlertDialog(BuildContext context,String text) {
    Widget okButton = TextButton(
      child:const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(text),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




  static loadingDialog(BuildContext context,
      {message = "Please wait...", Duration? duration}) {
    var dialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(8), child: CircularProgressIndicator()),
            const SizedBox(
              width: 30,
            ),
            Text(message),
          ],
        ),
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(onWillPop: () async => false, child: dialog),
    );

    if (duration != null) {
      Future.delayed(
        duration,
        () {
          Navigator.of(context).pop();
        },
      );
    }
  }


  static alertDialog(BuildContext context,
      {String? title,
        DialogType dialogType=DialogType.info,
      description,
      btnCancelText,
      btnOkIcon,
      double? width,
      bool showCloseIcon = false,headerAnimationLoop=false,
      Color? btnCancelColor,
      btnOkColor,
      VoidCallback? btn1CallBack,
      btn2CallBack,
      Widget? closeIcon,
      btnLeft,
      btnRight,
        AnimType animType=AnimType.bottomSlide,
        TextStyle? titleTextStyle,descriptionTextStyle
      }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      borderSide:  BorderSide(
        color: AppColors.primaryColor,
        width: 2,
      ),
      width: width ?? 500,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      headerAnimationLoop: headerAnimationLoop,
      animType:animType,

      title: title ?? 'TITLE',
      padding: EdgeInsets.all(20),
      titleTextStyle: titleTextStyle,
      descTextStyle: descriptionTextStyle,
      desc: description ?? "",
      showCloseIcon: showCloseIcon,
      closeIcon: closeIcon,
      btnCancel:btnLeft,
      btnOk: btnRight,
    ).show();
  }


  static Widget dialogButton(String btnText, VoidCallback onClick,
      {double height = 35,
      EdgeInsets margin = const EdgeInsets.all(8),
      Color bgColor = Colors.red}) {
    return Container(
      height: height,
      margin: margin,
      child: MaterialButton(
        child: Text(
          btnText,
          style: normalWhiteTextStyle,
        ),
        onPressed: () {
          onClick();
        },
        color: bgColor,
        minWidth: double.infinity,
      ),
    );
  }

}
