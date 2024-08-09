import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:samay_mvp/utility/dimension.dart';

class TimeSlot extends StatelessWidget {
  final String section;
  final List<String> timeSlots;
  final String? selectedTimeSlot;
  final int serviceDurationInMinutes;
  final DateTime? endTime;
  final ValueChanged<String> onTimeSlotSelected;

  const TimeSlot({
    required this.section,
    required this.timeSlots,
    required this.selectedTimeSlot,
    required this.serviceDurationInMinutes,
    required this.endTime,
    required this.onTimeSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (timeSlots.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          section,
          style: TextStyle(
              fontSize: Dimensions.dimenisonNo22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: Dimensions.dimenisonNo16),
        // Time slots grid
        Container(
          color: Colors.white,
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
              crossAxisSpacing: Dimensions.dimenisonNo10,
              mainAxisSpacing: Dimensions.dimenisonNo10,
            ),
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              final timeSlot = timeSlots[index];
              final DateTime slotStartTime =
                  DateFormat('hh:mm a').parse(timeSlot);
              final DateTime slotEndTime = slotStartTime
                  .add(Duration(minutes: serviceDurationInMinutes));

              bool isWithinDuration = slotEndTime.isBefore(endTime!) ||
                  slotEndTime.isAtSameMomentAs(endTime!);

              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedTimeSlot == timeSlot
                      ? Colors.blue
                      : isWithinDuration
                          ? Colors.green
                          : Colors.grey,
                  foregroundColor: selectedTimeSlot == timeSlot
                      ? Colors.white
                      : Colors.black,
                  side: const BorderSide(color: Colors.black),
                ),
                onPressed: isWithinDuration
                    ? () => onTimeSlotSelected(timeSlot)
                    : null,
                child: Text(timeSlot),
              );
            },
          ),
        ),
        SizedBox(height: Dimensions.dimenisonNo16),
      ],
    );
  }
}
