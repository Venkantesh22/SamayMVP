import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/constants/global_variable.dart';
import 'package:samay_mvp/models/category_model/category_model.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/models/timestamped_model/date_time_model.dart';
import 'package:samay_mvp/models/user_model/user_model.dart';
import 'package:samay_mvp/models/order/user_order_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _user = FirebaseAuth.instance;

//Fetch List of Salon data
  Future<List<SalonModel>> getSalonListFB() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collectionGroup("salon").get();
    List<SalonModel> salonList = querySnapshot.docs
        .map((e) => SalonModel.fromJson(e.data(), e.id))
        .toList();
    return salonList;
  }

  // Fetch Salon information by id
  Future<Map<String, dynamic>?> getSingleSalonInfoFB(
      String adminId, String salonId) async {
    try {
      DocumentSnapshot doc = await _firebaseFirestore
          .collection("admins")
          .doc(adminId)
          .collection("salon")
          .doc(salonId)
          .get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
    } catch (e) {
      showMessage('Error fetching admin info: ${e.toString()}');
    }
    return null;
  }

//Fetch List of Category data
  Future<List<CategoryModel>> getCategoryListFB(
      String salonId, String adminId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("admins")
              .doc(adminId)
              .collection("salon")
              .doc(salonId)
              .collection("category")
              .get();
      List<CategoryModel> categoryList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data()))
          .toList();
      return categoryList;
    } catch (e) {
      showMessage("Error ${e.toString()}");
      rethrow;
    }
  }

// Fetch category informaton by id
  Future<Map<String, dynamic>?> getSingleCategoryInfoFB(
      String adminId, String salonId, String categoryId) async {
    try {
      DocumentSnapshot doc = await _firebaseFirestore
          .collection("admins")
          .doc(adminId)
          .collection("salon")
          .doc(salonId)
          .collection("category")
          .doc(categoryId)
          .get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
    } catch (e) {
      showMessage('Error fetching Category info: ${e.toString()}');
    }
    return null;
  }

  //Fetch List of Service data
  Future<List<ServiceModel>> getServicesListFB(
      String salonId, String adminId, String categoryId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection("admins")
        .doc(adminId)
        .collection("salon")
        .doc(salonId)
        .collection("category")
        .doc(categoryId)
        .collection('service')
        .get();
    List<ServiceModel> serviceList =
        querySnapshot.docs.map((e) => ServiceModel.fromJson(e.data())).toList();
    return serviceList;
  }

  // Add new upload Appointment to Firebase
  Future<bool> uploadAppointmentInforFB(
      int appointmentNo,
      List<ServiceModel> servicelist,
      // SalonModel salonModel,
      // UserModel userModel,
      String userId,
      String vendorId,
      String adminId,
      String totalPrice,
      String subtatal,
      String platformFees,
      String payment,
      String serviceDuration,
      String serviceDate,
      String serviceStartTime,
      String serviceEndTime,
      String userNote,
      BuildContext context) async {
    try {
      showLoaderDialog(context);

      final List<TimeDateModel> timeDateList = [];

      AppProvider appProvider =
          Provider.of<AppProvider>(context, listen: false);
      String? userId = _user.currentUser?.uid;

      if (userId == null) {
        Navigator.of(context, rootNavigator: true).pop();
        showMessage("Error: User is not logged in.");
        return false;
      }

      final userInformation = appProvider.getUserInfornation;

      if (userInformation == null) {
        Navigator.of(context, rootNavigator: true).pop();
        showMessage("Error: User information is not available.");
        return false;
      }

      DocumentReference documentReference = _firebaseFirestore
          .collection("UserOrder")
          .doc(userId)
          .collection('order')
          .doc();
      DocumentReference userInfor =
          _firebaseFirestore.collection("UserOrder").doc(userId);

      userInfor.set({
        "id": userInfor.id,
        "userId": userInformation.id,
        "userName": userInformation.name,
      });
      TimeDateModel timeDateModel = TimeDateModel(
          id: documentReference.id,
          date: GlobalVariable.getCurrentDate(),
          time: GlobalVariable.getCurrentTime(),
          updateBy: "User");
      timeDateList.add(timeDateModel);

      documentReference.set({
        "orderId": documentReference.id,
        "appointmentNo": appointmentNo,
        // "salonModel": salonModel.toJson(), // Convert SalonModel to JSON
        // "userModel": userModel.toJson(), // Convert SalonModel to JSON
        "userId": userId,
        "vendorId": vendorId,
        "adminId": adminId,
        "services": servicelist.map((e) => e.toJson()).toList(),
        "status": "Pending",
        "totalPrice": totalPrice,
        "platformFees": platformFees,
        "subtatal": subtatal,
        "payment": payment,
        "serviceDuration": serviceDuration,
        "serviceDate": serviceDate,
        "serviceStartTime": serviceStartTime,
        "serviceEndTime": serviceEndTime,
        "userNote": userNote,
        "timeDateList": timeDateList.map((e) => e.toJson()).toList(),
        "isUpdate": false,
        "appointmentStatus": "Pending"
      });

      GlobalVariable.appointmentID = documentReference.id;
      Navigator.of(context, rootNavigator: true).pop();
      // showMessage("Ordered Successfully");

      return true;
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("Error of order ${e.toString()}");
      print("Error of order ${e.toString()}");
      return false;
    }
  }

  //Get Order list
  Future<List<OrderModel>> getUserOrderFB() async {
    try {
      String userId = _user.currentUser!.uid;
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("UserOrder")
              .doc(userId)
              .collection('order')
              .get();
      List<OrderModel> orderList = querySnapshot.docs
          .map((element) => OrderModel.fromJson(element.data()))
          .toList();
      print(orderList);
      return orderList;
    } catch (e) {
      showMessage('Error ${e.toString()}');
      print('Error ${e.toString()}');
      return [];
    }
  }

  //Delete Appointment
  Future<bool> deleteAppointmentFB(String orderId) async {
    try {
      String userId = _user.currentUser!.uid;
      _firebaseFirestore
          .collection("UserOrder")
          .doc(userId)
          .collection('order')
          .doc(orderId)
          .delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  // Update Appointment by Id
  Future<bool> updateAppointmentFB(
      String userId, appointmentId, OrderModel orderModel) async {
    await _firebaseFirestore
        .collection('UserOrder')
        .doc(userId)
        .collection('order')
        .doc(appointmentId)
        .update(orderModel.toJson());

    return true;
  }

  //Get User infor
  Future<UserModel> getUserInforFB() async {
    String? userId = _user.currentUser?.uid;
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection('users').doc(userId).get();
    return UserModel.fromJson(querySnapshot.data()!);
  }

  // Get salon information
  Future<SalonModel?> getSalonInformation(
    String adminId,
    String vendorId,
  ) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("admins")
              .doc(adminId)
              .collection('salon')
              .doc(vendorId)
              .get();
      return SalonModel.fromJson(querySnapshot.data()!, querySnapshot.id);
    } catch (e) {
      showMessage('Error fetching vender: $e');
    }
    return null;
  }

  //Get User by Order userId infor
  Future<UserModel> getUserInforOrderFB(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection('users').doc(userId).get();
    return UserModel.fromJson(querySnapshot.data()!);
  }
}
