import 'package:flutter/material.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/modules/login_screan/login_screan.dart';

import 'cash_helper.dart';

class SharedPrefrancMethod {
  static ThemeMode CheekTheme() {
    if (CashHelper.getData(key: "Theme") != null) {
      if (CashHelper.getData(key: "Theme")) {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    } else {
      return ThemeMode.light;
    }
  }

  static String CheekLan() {
    if (CashHelper.getData(key: "lenguge") != null) {
      if (CashHelper.getData(key: "lenguge")) {
        return "ar";
      } else {
        return "en";
      }
    }
    return "en";
  }

  static String CheekLogin() {
    if (CashHelper.getData(key: "login") != null) {
      if (CashHelper.getData(key: "login") == true) {
        return HomeLayout.routeName;
      } else {
        return LoginScreen.routeName;
      }
    } else {
      return LoginScreen.routeName;
    }
  }
}
