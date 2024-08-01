// import 'package:flutter/material.dart';

// class Dimensions {
//   static late double screenHeight;
//   // screen height 752.0

//   static void init(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//   }

//   static double dimenisonNo10 = screenHeight / 75.2;
//   static double dimenisonNo12 = screenHeight / 62.66;
//   static double dimenisonNo15 = screenHeight / 50.133;
//   static double dimenisonNo18 = screenHeight / 41.77;
//   static double dimenisonNo20 = screenHeight / 37.6;
//   static double dimenisonNo24 = screenHeight / 31.333;
//   static double dimenisonNo30 = screenHeight / 37.9;
//   static double dimenisonNo50 = screenHeight / 15.04;
//   static double dimenisonNo100 = screenHeight / 7.52;
//   static double dimenisonNo300 = screenHeight / 3.79;
//   static double dimenisonNo350 = screenHeight / 2.1485714;
// }
import 'package:flutter/material.dart';

class Dimensions {
  static late double screenHeight;
  static late double screenWidth;
// Emulater
// hight : 866.2857142857143
// Width : 411.42857142857144

// For Mobile screen
//  hight : 936.0
//  Width : 432.0

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  static double dimenisonNo1 = screenHeight / 963;
  static double dimenisonNo5 = screenHeight / 192.6;
  static double dimenisonNo10 = screenHeight / 96.3;
  static double dimenisonNo12 = screenHeight / 80.25;
  static double dimenisonNo14 = screenHeight / 68.7857142;
  static double dimenisonNo15 = screenHeight / 64.2;
  static double dimenisonNo16 = screenHeight / 60.1875;
  static double dimenisonNo18 = screenHeight / 53.5;
  static double dimenisonNo20 = screenHeight / 48.15;
  static double dimenisonNo22 = screenHeight / 39.36363636363;
  static double dimenisonNo24 = screenHeight / 40.125;
  static double dimenisonNo30 = screenHeight / 32.1;
  static double dimenisonNo36 = screenHeight / 26.75;
  static double dimenisonNo40 = screenHeight / 21.65;
  static double dimenisonNo50 = screenHeight / 17.32;
  static double dimenisonNo55 = screenHeight / 17.5090;
  static double dimenisonNo60 = screenHeight / 16.05;
  static double dimenisonNo70 = screenHeight / 13.75714;
  static double dimenisonNo80 = screenHeight / 10.825;
  static double dimenisonNo100 = screenHeight / 9.63;
  static double dimenisonNo110 = screenHeight / 8.754545454545455;
  static double dimenisonNo120 = screenHeight / 8.025;
  static double dimenisonNo150 = screenHeight / 6.42;
  static double dimenisonNo180 = screenHeight / 5.35;
  static double dimenisonNo200 = screenHeight / 4.815;
  static double dimenisonNo250 = screenHeight / 3.464;
  static double dimenisonNo300 = screenHeight / 3.21;
}
