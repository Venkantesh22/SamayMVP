import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/features/select_time/screen/select_time_section.dart';
import 'package:samay_mvp/features/select_time/widget/calender.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/utility/dimension.dart';

class SelectBooking extends StatefulWidget {
  final SalonModel salonModel;

  const SelectBooking({Key? key, required this.salonModel}) : super(key: key);

  @override
  State<SelectBooking> createState() => _SelectBookingState();
}

class _SelectBookingState extends State<SelectBooking> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _timeController = TextEditingController();
  bool _showCalender = false;
  bool selectTime = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        key: _scaffoldKey,
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.dimenisonNo16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Your Date',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.dimenisonNo24,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: Dimensions.dimenisonNo16),
                _showCalender
                    ? CustomCalender(
                        salonModel: widget.salonModel,
                        controller: _timeController)
                    : SizedBox(),
                SizedBox(height: Dimensions.dimenisonNo16),
                SizedBox(
                  height: Dimensions.dimenisonNo50,
                  child: TextField(
                    onTap: () {
                      setState(() {
                        _showCalender = !_showCalender;
                      });
                    },
                    controller: _timeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.dimenisonNo14),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.dimenisonNo14),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.dimenisonNo14),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      hintStyle: TextStyle(
                        color: const Color(0xFF959595),
                        fontSize: Dimensions.dimenisonNo16,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                      hintText: 'DD/MM/YY',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showCalender = !_showCalender;
                          });
                        },
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.dimenisonNo16,
                ),
                Text(
                  'Select Your Time',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.dimenisonNo24,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: Dimensions.dimenisonNo10),

                // _buildTimeSlots(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // // Function to build time slots based on openTime and closeTime
  // Widget _buildTimeSlots() {
  //   final DateFormat timeFormat = DateFormat('hh:mm a');
  //   DateTime openTime, closeTime;

  //   // Normalize time strings (remove extra spaces and ensure format consistency)
  //   final openTimeString = widget.salonModel.openTime.replaceAll(' ', '');
  //   final closeTimeString = widget.salonModel.closeTime.replaceAll(' ', '');

  //   try {
  //     openTime = timeFormat.parse(_normalizeTimeString(openTimeString));
  //     closeTime = timeFormat.parse(_normalizeTimeString(closeTimeString));
  //   } catch (e) {
  //     // Handle parsing error, perhaps show a message to the user
  //     print('Error parsing time: $e');
  //     return Center(child: Text('Error parsing time data'));
  //   }

  //   List<Widget> timeSlots = [];
  //   DateTime currentTime = openTime;
  //   while (currentTime.isBefore(closeTime)) {
  //     timeSlots.add(
  //       SizedBox(
  //         height: Dimensions.dimenisonNo70,
  //         child: ElevatedButton(
  //           onPressed: () {
  //             setState(() {
  //               _timeController.text = timeFormat.format(currentTime);
  //             });
  //             setState(() {
  //               selectTime = !selectTime;
  //             });
  //           },
  //           style: ElevatedButton.styleFrom(
  //             padding: EdgeInsets.symmetric(
  //               horizontal: Dimensions.dimenisonNo15,
  //             ),
  //             backgroundColor: selectTime
  //                 ? AppColor.buttonColor
  //                 : Color.fromARGB(255, 218, 216, 216),
  //             foregroundColor: Colors.white,
  //             side: const BorderSide(
  //               width: 3,
  //               color: Color(0x3F000000),
  //             ),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //           ),
  //           child: Text(
  //             timeFormat.format(currentTime),
  //             style: TextStyle(
  //               color: selectTime ? Colors.white : Colors.black,
  //               fontSize: Dimensions.dimenisonNo20,
  //               fontFamily: GoogleFonts.roboto().fontFamily,
  //               fontWeight: FontWeight.bold,
  //               letterSpacing: 1,
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  //     currentTime = currentTime.add(Duration(minutes: 30));
  //   }

  //   return Center(
  //     child: Wrap(
  //       spacing:
  //           Dimensions.dimenisonNo16, // Horizontal spacing between time slots
  //       runSpacing: Dimensions.dimenisonNo20, // Vertical spacing between lines
  //       children: timeSlots,
  //     ),
  //   );
  // }

  // // Helper function to normalize time strings
  // String _normalizeTimeString(String timeString) {
  //   // Ensure there is a space before AM/PM and remove any extra spaces
  //   return timeString.replaceAllMapped(
  //     RegExp(r'(\d+)(AM|PM)'),
  //     (match) => '${match[1]} ${match[2]}',
  //   );
  // }
}
