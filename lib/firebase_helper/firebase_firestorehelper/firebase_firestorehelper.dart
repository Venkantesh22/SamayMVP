import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/models/category_model/category_model.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';

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

  // Add service to watchList
  // Future<WatchListServiceModel> addServiceTOWatchListFB(
  //     ServiceModel serviceModel, String salonName) async {
  //   String? userId = _user.currentUser?.uid;
  //   DocumentReference reference = _firebaseFirestore
  //       .collection("users")
  //       .doc(userId)
  //       .collection('watchList')
  //       .doc();
  //   WatchListServiceModel watchListServiceModel = WatchListServiceModel(
  //     id: reference.id,
  //     salonId: serviceModel.salonId,
  //     userId: userId!,
  //     salonName: salonName,
  //     categoryId: serviceModel.categoryId,
  //     servicesName: serviceModel.servicesName,
  //     price: serviceModel.price,
  //     hours: serviceModel.hours,
  //     minutes: serviceModel.minutes,
  //     description: serviceModel.description,
  //     state: serviceModel.state,
  //   );
  //   await reference.set(watchListServiceModel.toJson());
  //   return watchListServiceModel;
  // }
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
