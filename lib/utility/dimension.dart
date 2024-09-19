// import 'package:flutter/material.dart';

// class Dimensions {
//   static late double screenHeight;
//   static late double screenWidth;
// // Emulater
// // hight : 866.2857142857143
// // Width : 411.42857142857144

// // For Mobile screen
// //  hight : 936.0
// //  Width : 432.0

//   static void init(BuildContext context) {
//     screenWidth = MediaQuery.of(context).size.width;
//     screenHeight = MediaQuery.of(context).size.height;
//   }

//   static double dimenisonNo1 = screenHeight / 963;
//   static double dimenisonNo5 = screenHeight / 192.6;
//   static double dimenisonNo8 = screenHeight / 108.25;
//   static double dimenisonNo10 = screenHeight / 96.3;
//   static double dimenisonNo12 = screenHeight / 80.25;
//   static double dimenisonNo14 = screenHeight / 68.7857142;
//   static double dimenisonNo15 = screenHeight / 64.2;
//   static double dimenisonNo16 = screenHeight / 60.1875;
//   static double dimenisonNo18 = screenHeight / 53.5;
//   static double dimenisonNo20 = screenHeight / 48.15;
//   static double dimenisonNo22 = screenHeight / 39.36363636363;
//   static double dimenisonNo24 = screenHeight / 40.125;
//   static double dimenisonNo30 = screenHeight / 32.1;
//   static double dimenisonNo36 = screenHeight / 26.75;
//   static double dimenisonNo40 = screenHeight / 21.65;
//   static double dimenisonNo50 = screenHeight / 17.32;
//   static double dimenisonNo55 = screenHeight / 17.5090;
//   static double dimenisonNo60 = screenHeight / 16.05;
//   static double dimenisonNo70 = screenHeight / 13.75714;
//   static double dimenisonNo80 = screenHeight / 10.825;
//   static double dimenisonNo100 = screenHeight / 9.63;
//   static double dimenisonNo110 = screenHeight / 8.754545454545455;
//   static double dimenisonNo120 = screenHeight / 8.025;
//   static double dimenisonNo130 = screenHeight / 6.661538461;
//   static double dimenisonNo150 = screenHeight / 6.42;
//   static double dimenisonNo180 = screenHeight / 5.35;
//   static double dimenisonNo200 = screenHeight / 4.815;
//   static double dimenisonNo250 = screenHeight / 3.464;
//   static double dimenisonNo300 = screenHeight / 3.21;
// }

import 'package:flutter/material.dart';

class Dimensions {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  // Emulator Dimensions (for reference)
  // Height: 866.29
  // Width: 411.43

  // Mobile screen (for reference)
  // Height: 936.0
  // Width: 432.0

  static bool _isInitialized = false;

  /// Initializes the screen dimensions, ensuring it is called only once.
  static void init(BuildContext context) {
    if (!_isInitialized) {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;
      _isInitialized = true;
    }
  }

  /// Ensures that the screen dimensions are initialized before accessing.
  static bool _validateInitialization() {
    if (!_isInitialized || screenHeight == 0.0 || screenWidth == 0.0) {
      print(
          'Error: Dimensions.init() must be called before accessing screen dimensions.');
      return false;
    }
    return true;
  }

  static double get dimenisonNo1 =>
      _validateInitialization() ? screenHeight / 963 : 0.0;
  static double get dimenisonNo5 =>
      _validateInitialization() ? screenHeight / 192.6 : 0.0;
  static double get dimenisonNo8 =>
      _validateInitialization() ? screenHeight / 108.25 : 0.0;
  static double get dimenisonNo10 =>
      _validateInitialization() ? screenHeight / 96.3 : 0.0;
  static double get dimenisonNo12 =>
      _validateInitialization() ? screenHeight / 80.25 : 0.0;
  static double get dimenisonNo14 =>
      _validateInitialization() ? screenHeight / 68.79 : 0.0;
  static double get dimenisonNo15 =>
      _validateInitialization() ? screenHeight / 64.2 : 0.0;
  static double get dimenisonNo16 =>
      _validateInitialization() ? screenHeight / 60.19 : 0.0;
  static double get dimenisonNo18 =>
      _validateInitialization() ? screenHeight / 53.5 : 0.0;
  static double get dimenisonNo20 =>
      _validateInitialization() ? screenHeight / 48.15 : 0.0;
  static double get dimenisonNo22 =>
      _validateInitialization() ? screenHeight / 39.36 : 0.0;
  static double get dimenisonNo24 =>
      _validateInitialization() ? screenHeight / 40.12 : 0.0;
  static double get dimenisonNo30 =>
      _validateInitialization() ? screenHeight / 32.1 : 0.0;
  static double get dimenisonNo36 =>
      _validateInitialization() ? screenHeight / 26.75 : 0.0;
  static double get dimenisonNo40 =>
      _validateInitialization() ? screenHeight / 21.65 : 0.0;
  static double get dimenisonNo50 =>
      _validateInitialization() ? screenHeight / 17.32 : 0.0;
  static double get dimenisonNo55 =>
      _validateInitialization() ? screenHeight / 17.51 : 0.0;
  static double get dimenisonNo60 =>
      _validateInitialization() ? screenHeight / 16.05 : 0.0;
  static double get dimenisonNo70 =>
      _validateInitialization() ? screenHeight / 13.76 : 0.0;
  static double get dimenisonNo80 =>
      _validateInitialization() ? screenHeight / 10.83 : 0.0;
  static double get dimenisonNo100 =>
      _validateInitialization() ? screenHeight / 9.63 : 0.0;
  static double get dimenisonNo110 =>
      _validateInitialization() ? screenHeight / 8.75 : 0.0;
  static double get dimenisonNo120 =>
      _validateInitialization() ? screenHeight / 8.03 : 0.0;
  static double get dimenisonNo130 =>
      _validateInitialization() ? screenHeight / 6.66 : 0.0;
  static double get dimenisonNo150 =>
      _validateInitialization() ? screenHeight / 6.42 : 0.0;
  static double get dimenisonNo180 =>
      _validateInitialization() ? screenHeight / 5.35 : 0.0;
  static double get dimenisonNo200 =>
      _validateInitialization() ? screenHeight / 4.82 : 0.0;
  static double get dimenisonNo250 =>
      _validateInitialization() ? screenHeight / 3.46 : 0.0;
  static double get dimenisonNo300 =>
      _validateInitialization() ? screenHeight / 3.21 : 0.0;
}
