import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:provider/provider.dart';

class SelectTimeSection extends StatefulWidget {
  final SalonModel salonModel;

  const SelectTimeSection({
    Key? key,
    required this.salonModel,
  }) : super(key: key);

  @override
  State<SelectTimeSection> createState() => _SelectTimeSectionState();
}

class _SelectTimeSectionState extends State<SelectTimeSection> {
  DateTime? _selectedStartTime;
  DateTime? _selectedEndTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTimeSlots(),
        SizedBox(height: Dimensions.dimenisonNo20),
        if (_selectedStartTime != null && _selectedEndTime != null) ...[
          Text(
            'Selected Start Time: ${DateFormat('hh:mm a').format(_selectedStartTime!)}',
            style: TextStyle(
              fontSize: Dimensions.dimenisonNo18,
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: Dimensions.dimenisonNo10),
          Text(
            'Selected End Time: ${DateFormat('hh:mm a').format(_selectedEndTime!)}',
            style: TextStyle(
              fontSize: Dimensions.dimenisonNo18,
              fontFamily: GoogleFonts.roboto().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTimeSlots() {
    final DateFormat timeFormat = DateFormat('hh:mm a');
    DateTime openTime, closeTime;

    // Parse and normalize time strings from the salon model
    final openTimeString = widget.salonModel.openTime.replaceAll(' ', '');
    final closeTimeString = widget.salonModel.closeTime.replaceAll(' ', '');

    try {
      openTime = timeFormat.parse(_normalizeTimeString(openTimeString));
      closeTime = timeFormat.parse(_normalizeTimeString(closeTimeString));
    } catch (e) {
      print('Error parsing time: $e');
      return Center(child: Text('Error parsing time data'));
    }

    // Debug: Print parsed open and close times
    print('Parsed Open Time: ${DateFormat('hh:mm a').format(openTime)}');
    print('Parsed Close Time: ${DateFormat('hh:mm a').format(closeTime)}');

    // Get service duration from provider
    final appProvider = Provider.of<AppProvider>(context);
    final serviceBookingDuration = appProvider.getServiceBookingDuration;
    final List<String> durationParts = serviceBookingDuration.split(' ');
    final int durationHours =
        int.tryParse(durationParts[0].replaceAll('h', '')) ?? 0;
    final int durationMinutes =
        int.tryParse(durationParts[1].replaceAll('m', '')) ?? 0;

    List<Widget> timeSlots = [];
    DateTime currentTime = openTime;

    // Generate time slot buttons
    while (currentTime.isBefore(closeTime)) {
      final endTime = currentTime
          .add(Duration(hours: durationHours, minutes: durationMinutes));

      // Check if the current time slot is within the selected range
      final isSelected = _selectedStartTime != null &&
          _selectedEndTime != null &&
          currentTime.isBefore(_selectedEndTime!) &&
          endTime.isAfter(_selectedStartTime!);

      // Debug: Print the current time being processed
      print(
          'Processing Time Slot: ${DateFormat('hh:mm a').format(currentTime)}');

      timeSlots.add(
        SizedBox(
          height: Dimensions.dimenisonNo70,
          child: ElevatedButton(
            onPressed: () =>
                _onTimeSlotPressed(currentTime, durationHours, durationMinutes),
            style: ElevatedButton.styleFrom(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.dimenisonNo15),
              backgroundColor: isSelected
                  ? AppColor.buttonColor
                  : Color.fromARGB(255, 218, 216, 216),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              timeFormat.format(currentTime),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: Dimensions.dimenisonNo20,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      );
      currentTime = currentTime.add(Duration(minutes: 30));
    }

    return Center(
      child: Wrap(
        spacing: Dimensions.dimenisonNo16,
        runSpacing: Dimensions.dimenisonNo20,
        children: timeSlots,
      ),
    );
  }

  /// Normalizes the time string to ensure correct parsing.
  String _normalizeTimeString(String timeString) {
    return timeString.replaceAllMapped(
      RegExp(r'(\d+)(AM|PM)'),
      (match) => '${match[1]} ${match[2]}',
    );
  }

  /// Handles the logic when a time slot is pressed.
  void _onTimeSlotPressed(
      DateTime startTime, int durationHours, int durationMinutes) {
    setState(() {
      _selectedStartTime = startTime;
      _selectedEndTime = startTime
          .add(Duration(hours: durationHours, minutes: durationMinutes));

      // Debugging outputs to trace the time selection
      print(
          'Selected Start Time: ${DateFormat('hh:mm a').format(_selectedStartTime!)}');
      print(
          'Computed End Time: ${DateFormat('hh:mm a').format(_selectedEndTime!)}');

      // Adjust for time slots crossing over midnight
      if (_selectedEndTime!.isBefore(_selectedStartTime!)) {
        _selectedEndTime = _selectedEndTime!.add(Duration(days: 1));
        print(
            'Adjusted End Time for crossing midnight: ${DateFormat('hh:mm a').format(_selectedEndTime!)}');
      }
    });
  }
}
