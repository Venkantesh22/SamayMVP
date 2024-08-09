import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/constants/global_variable.dart';
import 'package:samay_mvp/models/category_model/category_model.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/models/user_model.dart';
import 'package:samay_mvp/models/user_order/user_order_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _user = FirebaseAuth.instance;

//Fetch List of Salon data
  Future<List<SalonModel>> getSalonListFB() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collectionGroup("salon").get();
    List<SalonModel> salonList =
        querySnapshot.docs.map((e) => SalonModel.fromJson(e.data())).toList();
    return salonList;
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

  // Future<List<AdminModel>> getAdminList() async {
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await _firebaseFirestore.collection("admins").get();
  //   List<AdminModel> adminList =
  //       querySnapshot.docs.map((e) => AdminModel.fromJson(e.data())).toList();
  //   return adminList;
  // }

  // Add upload Appointment to Firebase
  Future<bool> uploadAppointmentInforFB(
    List<ServiceModel> servicelist,
    SalonModel salonModel,
    UserModel userModel,
    double totalPrice,
    String payment,
    String serviceDuration,
    String serviceDate,
    String serviceStartTime,
    String serviceEndTime,
    String userNote,
    String serviceBookDate,
    String serviceBookTime,
    BuildContext context,
  ) async {
    try {
      showLoaderDialog(context);
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
        "phone": userInformation.phone,
        "email": userInformation.email,
        "image": userInformation.image,
      });

      documentReference.set({
        "orderId": documentReference.id,
        "salonModel": salonModel.toJson(), // Convert SalonModel to JSON
        "userModel": userModel.toJson(), // Convert SalonModel to JSON
        "services": servicelist.map((e) => e.toJson()).toList(),
        "status": "Pending",
        "totalPrice": totalPrice,
        "payment": payment,
        "serviceDuration": serviceDuration,
        "serviceDate": serviceDate,
        "serviceStartTime": serviceStartTime,
        "serviceEndTime": serviceEndTime,
        "userNote": userNote,
        "serviceBookDate": serviceBookDate,
        "serviceBookTime": serviceBookTime,
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

      return orderList;
    } catch (e) {
      showMessage('Error ${e.toString()}');
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

  //Get User infor
  Future<UserModel> getUserInforFB() async {
    String? userId = _user.currentUser?.uid;
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection('users').doc(userId).get();

    return UserModel.fromJson(querySnapshot.data()!);
  }
// //Get WatchList for Firebase
  // Stream<List<WatchListServiceModel>> getWatchListServiceFB() {
  //   String? userId = _user.currentUser?.uid;
  //   return _firebaseFirestore
  //       .collection("users")
  //       .doc(userId)
  //       .collection('watchList')
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((doc) => WatchListServiceModel.fromJson(doc.data()))
  //           .toList());
  // }
// delete service for WatchList
  // Future<bool> deleteServiceForWatchListFB(String serviceId) async {
  //   try {
  //     String? userId = _user.currentUser?.uid;
  //     await _firebaseFirestore
  //         .collection("users")
  //         .doc(userId)
  //         .collection('watchList')
  //         .doc(serviceId)
  //         .delete();
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
