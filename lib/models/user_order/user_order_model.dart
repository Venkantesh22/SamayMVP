import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/models/user_model.dart';

class OrderModel {
  final String orderId;
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
      orderId: json['orderId'],
      services: (json['services'] as List)
          .map((item) => ServiceModel.fromJson(item))
          .toList(),
      status: json['status'],
      totalPrice: json['totalPrice'],
      payment: json['payment'],
      serviceDuration: json['serviceDuration'],
      serviceDate: json['serviceDate'],
      serviceStartTime: json['serviceStartTime'],
      serviceEndTime: json['serviceEndTime'],
      userNote: json['userNote'],
      serviceBookDate: json['serviceBookDate'],
      serviceBookTime: json['serviceBookTime'],
      salonModel: SalonModel.fromJson(json['salonModel']),
      userModel: UserModel.fromJson(json['userModel']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
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
    String? orderId,
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
    SalonModel? salonModel,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
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
      salonModel: salonModel ?? this.salonModel,
      userModel: userModel,
    );
  }
}
