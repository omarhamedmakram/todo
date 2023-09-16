import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Color(0xFFDFECDB),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF5D9CEC),
      centerTitle: false,
      titleTextStyle: GoogleFonts.poppins(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: Colors.blue,
      ),
      unselectedIconTheme: IconThemeData(color: Colors.grey),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
  );

  static ThemeData darkTheme = ThemeData(
      canvasColor: Color(0xFF141922),
      scaffoldBackgroundColor: Color(0xFF060E1E),
      appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF5D9CEC),
          centerTitle: false,
          titleTextStyle: GoogleFonts.poppins(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF141922),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
          color: Colors.blue,
        ),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black));
}
