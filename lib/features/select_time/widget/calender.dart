// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:samay_mvp/utility/color.dart';
// import 'package:samay_mvp/utility/dimension.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:samay_mvp/constants/constants.dart';
// import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';

// class CustomCalender extends StatefulWidget {
//   final SalonModel salonModel;
//   final TextEditingController controller;
//   const CustomCalender({
//     Key? key,
//     required this.salonModel,
//     required this.controller,
//   }) : super(key: key);

//   @override
//   State<CustomCalender> createState() => _CustomCalenderState();
// }

// class _CustomCalenderState extends State<CustomCalender> {
//   DateTime _selectedDate = DateTime.now();
//   List<String> _closedDays = [];

//   @override
//   void initState() {
//     super.initState();
//     _findClosedDays();
//   }

//   // Function to populate the list of closed days based on the salon model
//   void _findClosedDays() {
//     _closedDays.clear();
//     if (widget.salonModel.monday?.toLowerCase() == 'close') {
//       _closedDays.add('Monday');
//     }
//     if (widget.salonModel.tuesday?.toLowerCase() == 'close') {
//       _closedDays.add('Tuesday');
//     }
//     if (widget.salonModel.wednesday?.toLowerCase() == 'close') {
//       _closedDays.add('Wednesday');
//     }
//     if (widget.salonModel.thursday?.toLowerCase() == 'close') {
//       _closedDays.add('Thursday');
//     }
//     if (widget.salonModel.friday?.toLowerCase() == 'close') {
//       _closedDays.add('Friday');
//     }
//     if (widget.salonModel.saturday?.toLowerCase() == 'close') {
//       _closedDays.add('Saturday');
//     }
//     if (widget.salonModel.sunday?.toLowerCase() == 'close') {
//       _closedDays.add('Sunday');
//     }
//   }

//   // Function to check if the salon is closed on a given date
//   bool _isSalonClosed(DateTime date) {
//     switch (date.weekday) {
//       case DateTime.monday:
//         return widget.salonModel.monday?.toLowerCase() == 'close';
//       case DateTime.tuesday:
//         return widget.salonModel.tuesday?.toLowerCase() == 'close';
//       case DateTime.wednesday:
//         return widget.salonModel.wednesday?.toLowerCase() == 'close';
//       case DateTime.thursday:
//         return widget.salonModel.thursday?.toLowerCase() == 'close';
//       case DateTime.friday:
//         return widget.salonModel.friday?.toLowerCase() == 'close';
//       case DateTime.saturday:
//         return widget.salonModel.saturday?.toLowerCase() == 'close';
//       case DateTime.sunday:
//         return widget.salonModel.sunday?.toLowerCase() == 'close';
//       default:
//         return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.green[200],
//         borderRadius: BorderRadius.circular(Dimensions.dimenisonNo20),
//       ),
//       child: TableCalendar(
//         focusedDay: _selectedDate,
//         firstDay: DateTime.now(),
//         lastDay: DateTime.now().add(Duration(days: 30)),
//         holidayPredicate: (day) {
//           // Highlight days as holidays if the salon is closed
//           return _isSalonClosed(day);
//         },
//         selectedDayPredicate: (day) {
//           return isSameDay(_selectedDate, day);
//         },
//         onDaySelected: (selectedDay, focusedDay) {
//           if (_isSalonClosed(selectedDay)) {
//             showMeassgeAlertDialog(context, "Weekday Holiday",
//                 'The salon is closed on the selected date');
//           } else {
//             setState(() {
//               _selectedDate = selectedDay;
//               widget.controller.text =
//                   DateFormat('dd/MM/yyyy').format(_selectedDate);
//             });
//           }
//         },
//         calendarBuilders: CalendarBuilders(
//           holidayBuilder: (context, date, _) {
//             return Center(
//               child: Container(
//                 margin: const EdgeInsets.all(4.0),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.red, // Red color for holidays
//                 ),
//                 child: Center(
//                   child: Text(
//                     date.day.toString(),
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             );
//           },
//           selectedBuilder: (context, date, events) {
//             return Center(
//               child: Container(
//                 margin: const EdgeInsets.all(4.0),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColor.buttonColor, // Green color for selected date
//                   // color: Colors.green, // Green color for selected date
//                 ),
//                 child: Center(
//                   child: Text(
//                     date.day.toString(),
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),

//       );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';

class CustomCalendar extends StatefulWidget {
  final SalonModel salonModel;
  final TextEditingController controller;

  const CustomCalendar({
    Key? key,
    required this.salonModel,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _selectedDate = DateTime.now();
  List<String> _closedDays = [];

  @override
  void initState() {
    super.initState();
    _findClosedDays();
  }

  void _findClosedDays() {
    _closedDays.clear();
    if (widget.salonModel.monday?.toLowerCase() == 'close') {
      _closedDays.add('Monday');
    }
    if (widget.salonModel.tuesday?.toLowerCase() == 'close') {
      _closedDays.add('Tuesday');
    }
    if (widget.salonModel.wednesday?.toLowerCase() == 'close') {
      _closedDays.add('Wednesday');
    }
    if (widget.salonModel.thursday?.toLowerCase() == 'close') {
      _closedDays.add('Thursday');
    }
    if (widget.salonModel.friday?.toLowerCase() == 'close') {
      _closedDays.add('Friday');
    }
    if (widget.salonModel.saturday?.toLowerCase() == 'close') {
      _closedDays.add('Saturday');
    }
    if (widget.salonModel.sunday?.toLowerCase() == 'close') {
      _closedDays.add('Sunday');
    }
  }

  bool _isSalonClosed(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return widget.salonModel.monday?.toLowerCase() == 'close';
      case DateTime.tuesday:
        return widget.salonModel.tuesday?.toLowerCase() == 'close';
      case DateTime.wednesday:
        return widget.salonModel.wednesday?.toLowerCase() == 'close';
      case DateTime.thursday:
        return widget.salonModel.thursday?.toLowerCase() == 'close';
      case DateTime.friday:
        return widget.salonModel.friday?.toLowerCase() == 'close';
      case DateTime.saturday:
        return widget.salonModel.saturday?.toLowerCase() == 'close';
      case DateTime.sunday:
        return widget.salonModel.sunday?.toLowerCase() == 'close';
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(Dimensions.dimenisonNo20),
      ),
      child: TableCalendar(
        focusedDay: _selectedDate,
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(Duration(days: 30)),
        holidayPredicate: _isSalonClosed,
        selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
        onDaySelected: (selectedDay, focusedDay) {
          if (_isSalonClosed(selectedDay)) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Weekday Holiday'),
                content: Text('The salon is closed on the selected date.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          } else {
            setState(() {
              _selectedDate = selectedDay;
              widget.controller.text =
                  DateFormat('dd/MM/yyyy').format(_selectedDate);
            });
          }
        },
        calendarBuilders: CalendarBuilders(
          holidayBuilder: (context, date, _) => Center(
            child: Container(
              margin: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          selectedBuilder: (context, date, events) => Center(
            child: Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.buttonColor,
              ),
              child: Center(
                child: Text(
                  date.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
