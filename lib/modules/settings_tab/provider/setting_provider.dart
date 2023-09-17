import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  ChangeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  String Lenguge = "en";

  ChangeLanguge(String newLen) {
    if (Lenguge == newLen) return;
    Lenguge = newLen;
    notifyListeners();
  }
}
