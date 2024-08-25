import 'package:intl/intl.dart';

class GlobalVariable {
  static String appointmentID = '';
  static String samayCollectionId = '6fa4GusAyAIkcAuBkYlu';
  static String salonCollectionId = 'j5bzQoxDswYJdSLQI3Lw';
  static num appointmentNO = 0.0;

  // Function to get current date and time in a formatted string
  static String getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(now);
  }

  static String getCurrentTime() {
    DateTime now = DateTime.now();
    return DateFormat('hh:mm a').format(now); // HH:mm a (e.g. 03:45 PM)
  }
}
