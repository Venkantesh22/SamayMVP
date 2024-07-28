import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: Color(0xFF06240A),
        )),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
  ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: AppColor.authBackgroundColor,
  //     disabledBackgroundColor: Colors.grey,
  //     side: const BorderSide(width: 2, color: Color(0xFF4CF753)),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
  //     textStyle: const TextStyle(
  //       color: Colors.white,
  //       fontSize: 16,
  //       fontFamily: 'Roboto',
  //       letterSpacing: 1.25,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  // ),
);
