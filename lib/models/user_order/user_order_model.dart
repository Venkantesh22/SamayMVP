import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/models/user_model.dart';

class OrderModel {
  final String orderId;
  final int appointmentNo;
  final List<ServiceModel> services;
  final String status;
  final double totalPrice;
  final String payment;
  final String serviceDuration;
  final String serviceDate;
  final String serviceStartTime;
  final String serviceEndTime;
  final String userNote;
  final String serviceBookDate;
  final String serviceBookTime;
  final SalonModel salonModel;
  final UserModel userModel;

  OrderModel({
    required this.orderId,
    required this.appointmentNo,
    required this.services,
    required this.status,
    required this.totalPrice,
    required this.payment,
    required this.serviceDuration,
    required this.serviceDate,
    required this.serviceStartTime,
    required this.serviceEndTime,
    required this.userNote,
    required this.serviceBookDate,
    required this.serviceBookTime,
    required this.salonModel,
    required this.userModel,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] ?? '', // Default to empty string if null
      appointmentNo: (json['appointmentNo'] ?? '').toInt(),
      services: (json['services'] as List)
          .map((item) => ServiceModel.fromJson(item))
          .toList(),
      status: json['status'] ?? 'Pending', // Default to 'Pending' if null
      totalPrice:
          (json['totalPrice'] ?? 0.0).toDouble(), // Default to 0.0 if null
      payment: json['payment'] ?? 'Unknown', // Default to 'Unknown' if null
      serviceDuration:
          json['serviceDuration'] ?? '0h 0m', // Default to '0h 0m' if null
      serviceDate: json['serviceDate'] ??
          'Unknown Date', // Default to 'Unknown Date' if null
      serviceStartTime: json['serviceStartTime'] ??
          'Unknown Start Time', // Default to 'Unknown Start Time' if null
      serviceEndTime: json['serviceEndTime'] ??
          'Unknown End Time', // Default to 'Unknown End Time' if null
      userNote: json['userNote'] ?? '', // Default to empty string if null
      serviceBookDate: json['serviceBookDate'] ??
          'Unknown Booking Date', // Default to 'Unknown Booking Date' if null
      serviceBookTime: json['serviceBookTime'] ??
          'Unknown Booking Time', // Default to 'Unknown Booking Time' if null
      salonModel: SalonModel.fromJson(
        json['salonModel'],
      ),
      userModel: UserModel.fromJson(json['userModel']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'appointmentNo': appointmentNo,
      'services': services.map((e) => e.toJson()).toList(),
      'status': status,
      'totalPrice': totalPrice,
      'payment': payment,
      'serviceDuration': serviceDuration,
      'serviceDate': serviceDate,
      'serviceStartTime': serviceStartTime,
      'serviceEndTime': serviceEndTime,
      'userNote': userNote,
      'serviceBookDate': serviceBookDate,
      'serviceBookTime': serviceBookTime,
      'salonModel': salonModel.toJson(),
      'userModel': userModel.toJson(),
    };
  }

  OrderModel copyWith({
    int? appointmentNo,
    List<ServiceModel>? services,
    String? status,
    double? totalPrice,
    String? payment,
    String? serviceDuration,
    String? serviceDate,
    String? serviceStartTime,
    String? serviceEndTime,
    String? userNote,
    String? serviceBookDate,
    String? serviceBookTime,
  }) {
    return OrderModel(
      orderId: orderId,
      appointmentNo: appointmentNo ?? this.appointmentNo,
      services: services ?? this.services,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
      payment: payment ?? this.payment,
      serviceDuration: serviceDuration ?? this.serviceDuration,
      serviceDate: serviceDate ?? this.serviceDate,
      serviceStartTime: serviceStartTime ?? this.serviceStartTime,
      serviceEndTime: serviceEndTime ?? this.serviceEndTime,
      userNote: userNote ?? this.userNote,
      serviceBookDate: serviceBookDate ?? this.serviceBookDate,
      serviceBookTime: serviceBookTime ?? this.serviceBookTime,
      salonModel: salonModel,
      userModel: userModel,
    );
  }
}
