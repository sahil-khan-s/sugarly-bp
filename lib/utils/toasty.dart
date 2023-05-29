import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasty {
  static error(String msg) {
    _showToast(msg, Colors.red);
  }

  static success(String msg) {
    _showToast(msg, Colors.green);
  }

  static _showToast(String msg, Color bgColor) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: bgColor, textColor: Colors.white);
  }
}
