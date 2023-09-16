import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tost {
  static void tost(String massage) {
    Fluttertoast.showToast(
        msg: "${massage}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
