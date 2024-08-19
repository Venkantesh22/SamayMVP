//! above code propert
//! blow code is with last slop of

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/features/select_time/widget/calender.dart';
import 'package:samay_mvp/features/select_time/widget/time_tap.dart';
import 'package:samay_mvp/features/summary/screen/booking_summary.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_button.dart';

import '../../../constants/router.dart';

class SelectBooking extends StatefulWidget {
  final SalonModel salonModel;

  const SelectBooking({
    Key? key,
    required this.salonModel,
  }) : super(key: key);

  @override
  _SelectBookingState createState() => _SelectBookingState();
}

class _SelectBookingState extends State<SelectBooking> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _selectedTimeSlot;
  String? _serviceEndTime;

  DateTime? _startTime;
  DateTime? _endTime;

  Map<String, List<String>> _categorizedTimeSlots = {
    'Morning': [],
    'Afternoon': [],
    'Evening': [],
    'Night': [],
  };

  @override
  void initState() {
    super.initState();
    _initializeTimes();
  }

  void _initializeTimes() {
    try {
      String openTimeString = _normalizeTimeString(widget.salonModel.openTime);
      String closeTimeString =
          _normalizeTimeString(widget.salonModel.closeTime);

      _startTime = DateFormat('hh:mm a').parse(openTimeString);
      _endTime = DateFormat('hh:mm a').parse(closeTimeString);
    } catch (e) {
      print('Error parsing time: $e');
    }
  }

  String _normalizeTimeString(String timeString) {
    return timeString.replaceAllMapped(
      RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)'),
      (match) => '${match[1]?.padLeft(2, '0')}:${match[2]} ${match[3]}',
    );
  }

  int parseDuration(String duration) {
    final regex = RegExp(r'(\d+)h (\d+)m');
    final match = regex.firstMatch(duration);

    if (match != null) {
      final hours = int.parse(match.group(1)!);
      final minutes = int.parse(match.group(2)!);
      return hours * 60 + minutes;
    }

    return 0; // Default to 0 if parsing fails
  }

  void _generateTimeSlots(int serviceDurationInMinutes) {
    if (_startTime != null && _endTime != null) {
      DateTime currentTime = _startTime!;
      _categorizedTimeSlots.forEach((key, value) => value.clear());

      while (currentTime.isBefore(_endTime!)) {
        final slotEndTime =
            currentTime.add(Duration(minutes: serviceDurationInMinutes));

        String formattedTime = DateFormat('hh:mm a').format(currentTime);

        if (currentTime.hour < 12) {
          _categorizedTimeSlots['Morning']!.add(formattedTime);
        } else if (currentTime.hour < 17) {
          _categorizedTimeSlots['Afternoon']!.add(formattedTime);
        } else if (currentTime.hour < 21) {
          _categorizedTimeSlots['Evening']!.add(formattedTime);
        } else {
          _categorizedTimeSlots['Night']!.add(formattedTime);
        }

        currentTime =
            currentTime.add(Duration(minutes: 30)); // Adjust as needed
      }

      // Ensure the last slot includes the closing time
      String lastSlotFormattedTime = DateFormat('hh:mm a').format(_endTime!);
      if (_categorizedTimeSlots['Night']!.last != lastSlotFormattedTime) {
        _categorizedTimeSlots['Night']!.add(lastSlotFormattedTime);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dateController.dispose();
    _timeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final serviceBookingDuration = provider.getServiceBookingDuration;
    final serviceDurationInMinutes = parseDuration(serviceBookingDuration);

    _generateTimeSlots(serviceDurationInMinutes); // Generate time slots

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        key: _scaffoldKey,
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.dimenisonNo16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select a Date:',
                style: TextStyle(
                    fontSize: Dimensions.dimenisonNo22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Dimensions.dimenisonNo12),
              CustomCalendar(
                salonModel: widget.salonModel,
                controller: _dateController,
              ),
              SizedBox(height: Dimensions.dimenisonNo20),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Selected Date',
                  // border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Dimensions.dimenisonNo12,
                    vertical: Dimensions.dimenisonNo12,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.dimenisonNo16),
              TimeSlot(
                section: 'Morning',
                timeSlots: _categorizedTimeSlots['Morning'] ?? [],
                selectedTimeSlot: _selectedTimeSlot,
                serviceDurationInMinutes: serviceDurationInMinutes,
                endTime: _endTime,
                onTimeSlotSelected: (selectedSlot) {
                  setState(() {
                    _selectedTimeSlot = selectedSlot;
                    _timeController.text = selectedSlot;
                  });
                },
              ),
              TimeSlot(
                section: 'Afternoon',
                timeSlots: _categorizedTimeSlots['Afternoon'] ?? [],
                selectedTimeSlot: _selectedTimeSlot,
                serviceDurationInMinutes: serviceDurationInMinutes,
                endTime: _endTime,
                onTimeSlotSelected: (selectedSlot) {
                  setState(() {
                    _selectedTimeSlot = selectedSlot;
                    _timeController.text = selectedSlot;
                  });
                },
              ),
              TimeSlot(
                section: 'Evening',
                timeSlots: _categorizedTimeSlots['Evening'] ?? [],
                selectedTimeSlot: _selectedTimeSlot,
                serviceDurationInMinutes: serviceDurationInMinutes,
                endTime: _endTime,
                onTimeSlotSelected: (selectedSlot) {
                  setState(() {
                    _selectedTimeSlot = selectedSlot;
                    _timeController.text = selectedSlot;
                  });
                },
              ),
              TimeSlot(
                section: 'Night',
                timeSlots: _categorizedTimeSlots['Night'] ?? [],
                selectedTimeSlot: _selectedTimeSlot,
                serviceDurationInMinutes: serviceDurationInMinutes,
                endTime: _endTime,
                onTimeSlotSelected: (selectedSlot) {
                  setState(() {
                    _selectedTimeSlot = selectedSlot;
                    _timeController.text = selectedSlot;
                  });
                },
              ),
              Text(
                'Add Note',
                style: TextStyle(
                  fontSize: Dimensions.dimenisonNo18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: "Write a note for stylist.",
                  errorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.dimenisonNo16),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.dimenisonNo16),
              if (_dateController != null)
                Container(
                  padding: EdgeInsets.all(Dimensions.dimenisonNo10),
                  decoration: BoxDecoration(
                    color: AppColor.grey,
                    borderRadius:
                        BorderRadius.circular(Dimensions.dimenisonNo10),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.dimenisonNo16),
                        if (_selectedTimeSlot != null)
                          Text(
                            'Service Time:',
                            style: TextStyle(
                              fontSize: Dimensions.dimenisonNo22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        Divider(
                          color: Colors.white,
                        ),
                        if (_selectedTimeSlot != null) ...[
                          SizedBox(height: Dimensions.dimenisonNo10),
                          Row(
                            children: [
                              Text(
                                'Appointment Date',
                                style: TextStyle(
                                  fontSize: Dimensions.dimenisonNo18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.90,
                                ),
                              ),
                              Spacer(),
                              Text(
                                _dateController.text,
                                style: TextStyle(
                                  fontSize: Dimensions.dimenisonNo18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.dimenisonNo10),
                          Row(
                            children: [
                              Text(
                                'Appointment Start Time',
                                style: TextStyle(
                                  fontSize: Dimensions.dimenisonNo18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.90,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '$_selectedTimeSlot',
                                style: TextStyle(
                                  fontSize: Dimensions.dimenisonNo18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.90,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.dimenisonNo10),
                          Row(
                            children: [
                              Text(
                                'Appointment End Time',
                                style: TextStyle(
                                  fontSize: Dimensions.dimenisonNo18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.90,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                DateFormat('hh:mm a').format(
                                    DateFormat('hh:mm a')
                                        .parse(_selectedTimeSlot!)
                                        .add(Duration(
                                            minutes:
                                                serviceDurationInMinutes))),
                                style: TextStyle(
                                  fontSize: Dimensions.dimenisonNo18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.90,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.dimenisonNo16),
                        ],
                      ]),
                ),
              SizedBox(
                height: Dimensions.dimenisonNo16,
              ),
              SizedBox(
                height: Dimensions.dimenisonNo55,
                width: double.infinity,
                child: CustomButtom(
                  text: "Confirm Appointment",
                  ontap: () {
                    bool isNoteAdd = false;
                    setState(() {
                      _serviceEndTime = DateFormat('hh:mm a').format(
                          DateFormat('hh:mm a').parse(_selectedTimeSlot!).add(
                              Duration(minutes: serviceDurationInMinutes)));
                      isNoteAdd =
                          _noteController.text.isNotEmpty ? true : false;
                    });
                    if (_dateController.text.isEmpty ||
                        _timeController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please select a date, time, not for the Appointment.'),
                        ),
                      );
                    } else {
                      Routes.instance.push(
                          widget: SummaryScreen(
                            salonModel: widget.salonModel,
                            serviceDate: _dateController.text,
                            serviceStartTime: _selectedTimeSlot!,
                            serviceEndTime: _serviceEndTime!,
                            userNote: _noteController.text.isNotEmpty
                                ? _noteController.text
                                : '',
                            isNodeAdd: isNoteAdd,
                          ),
                          context: context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
