import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/models/timestamped_model/date_time_model.dart';
import 'package:samay_mvp/models/user_model/user_model.dart';

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
  final SalonModel salonModel;
  final UserModel userModel;
  final List<TimeDateModel> timeDateList;

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
    required this.salonModel,
    required this.userModel,
    required this.timeDateList,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] ?? '',
      appointmentNo: (json['appointmentNo'] ?? 0) as int,
      services: (json['services'] as List?)
              ?.map((item) => ServiceModel.fromJson(item))
              .toList() ??
          [],
      status: json['status'] ?? 'Pending',
      totalPrice: (json['totalPrice'] ?? 0.0) as double,
      payment: json['payment'] ?? 'Unknown',
      serviceDuration: json['serviceDuration'] ?? '0h 0m',
      serviceDate: json['serviceDate'] ?? 'Unknown Date',
      serviceStartTime: json['serviceStartTime'] ?? 'Unknown Start Time',
      serviceEndTime: json['serviceEndTime'] ?? 'Unknown End Time',
      userNote: json['userNote'] ?? '',
      salonModel: SalonModel.fromJson(json['salonModel'] ?? {}),
      userModel: UserModel.fromJson(json['userModel'] ?? {}),
      timeDateList: (json['timeDateList'] as List?)
              ?.map((item) => TimeDateModel.fromJson(item))
              .toList() ??
          [],
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
      'salonModel': salonModel.toJson(),
      'userModel': userModel.toJson(),
      'timeDateList': timeDateList.map((e) => e.toJson()).toList(),
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
    SalonModel? salonModel,
    UserModel? userModel,
    List<TimeDateModel>? timeDateList,
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
      salonModel: salonModel ?? this.salonModel,
      userModel: userModel ?? this.userModel,
      timeDateList: timeDateList ?? this.timeDateList,
    );
  }
}
