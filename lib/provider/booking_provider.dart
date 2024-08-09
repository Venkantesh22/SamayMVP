// booking_provider.dart
import 'package:flutter/material.dart';

class BookingProvider with ChangeNotifier {
  DateTime? _selectedDate;
  List<DateTime> _selectedTimeSlots = [];
  int _serviceDurationInMinutes = 30; // Default service duration

  DateTime? get selectedDate => _selectedDate;
  List<DateTime> get selectedTimeSlots => _selectedTimeSlots;
  int get serviceDurationInMinutes => _serviceDurationInMinutes;

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void toggleTimeSlot(DateTime timeSlot) {
    if (_selectedTimeSlots.contains(timeSlot)) {
      _selectedTimeSlots.remove(timeSlot);
    } else {
      _selectedTimeSlots.add(timeSlot);
    }
    notifyListeners();
  }

  void setServiceDuration(int durationInMinutes) {
    _serviceDurationInMinutes = durationInMinutes;
    notifyListeners();
  }

  void clearSelection() {
    _selectedDate = null;
    _selectedTimeSlots.clear();
    notifyListeners();
  }
}
