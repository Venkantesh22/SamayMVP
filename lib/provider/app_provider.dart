import 'package:flutter/material.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/models/category_model/category_model.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/models/user_model.dart';

class AppProvider with ChangeNotifier {
  final FirebaseFirestoreHelper _firebaseFirestoreHelper =
      FirebaseFirestoreHelper.instance;

  SalonModel? _salonModel;
  CategoryModel? _categoryModel;
  UserModel? _userModel;

  List<CategoryModel> _categoryList = [];
  List<ServiceModel> _watchList = [];

  double _subTotal = 0.0;
  double _finalTotal = 0.0;
  String _serviceBookingDuration = "0h 0m";

  SalonModel? get getSalonInformation => _salonModel;
  CategoryModel? get getCategoryInformation => _categoryModel;
  UserModel? get getUserInfornation => _userModel;
  List<CategoryModel> get getcategoryList => _categoryList;
  List<ServiceModel> get getWatchList => _watchList;
  double get getSubTotal => _subTotal;
  double get getfinalTotal => _finalTotal;
  String get getServiceBookingDuration => _serviceBookingDuration;

//add service to Watch List
  void addServiceToWatchList(ServiceModel serviceModel) {
    _watchList.add(serviceModel);
    notifyListeners();
  }

//remove service to Watch List
  void removeServiceToWatchList(ServiceModel serviceModel) {
    _watchList.remove(serviceModel);
    notifyListeners();
  }

//SubTotal
  void calculateSubTotal() {
    _subTotal = _watchList.fold(0.0, (sum, item) => sum + item.price);
    print("subTotal :- $_subTotal");
    _finalTotal = _subTotal + 20;
    print("finalTotal :- $_finalTotal");
    notifyListeners();
  }

  // Calculate total time for all services in the watch list
  void calculateTotalBookingDuration() {
    double totalHours = 0;
    double totalMinutes = 0;

    for (var service in _watchList) {
      totalHours += service.hours;
      totalMinutes += service.minutes;
    }

    // Convert total minutes to hours and minutes
    totalHours += (totalMinutes / 60).floor();
    totalMinutes = totalMinutes % 60;

    // Update the serviceBookingDuration with formatted time
    _serviceBookingDuration = "${totalHours.floor()}h ${totalMinutes.toInt()}m";

    // Notify listeners about the change
    notifyListeners();
  }

  // Fetch the list of categories from Firebase and update _categoryList
  Future<void> getCategoryListFunPro(String salonId, String adminId) async {
    try {
      List<CategoryModel> allCategories =
          await _firebaseFirestoreHelper.getCategoryListFB(salonId, adminId);
      _categoryList =
          allCategories.where((category) => category.haveData).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  //call back Functon for get Category and Service List
  Future<void> callBackFunctionWinder(
    String salonId,
    adminId,
  ) async {
    await getCategoryListFunPro(salonId, adminId);
    calculateSubTotal();
  }

  // Fetch salon information from Firebase
  Future<void> getSalonInfoFirebasePro(String adminId, String salonId) async {
    try {
      Map<String, dynamic>? salonData =
          await _firebaseFirestoreHelper.getSingleSalonInfoFB(adminId, salonId);
      if (salonData != null) {
        _salonModel = SalonModel.fromJson(salonData);
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching salon information: $e");
    }
  }

  // Fetch Category information from Firebase
  Future<void> getCategoryInfoFirebasePro(
      String adminId, String salonId, String categoryId) async {
    try {
      Map<String, dynamic>? categoryData = await _firebaseFirestoreHelper
          .getSingleCategoryInfoFB(adminId, salonId, categoryId);
      if (categoryData != null) {
        _categoryModel = CategoryModel.fromJson(categoryData);
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching category information: $e");
    }
  }

//Fetch User information from Firebase
  void getUserInfoFirebasePro() async {
    _userModel = await _firebaseFirestoreHelper.getUserInforFB();
    notifyListeners();
  }

// Fetch watch list services as a stream
  // Stream<List<WatchListServiceModel>> getWatchListStream() {
  //   return _firebaseFirestoreHelper.getWatchListServiceFB();
  // }
  // Fetch watch list services and update _watchServiceList
  // Future<void> fetchWatchList() async {
  //   getWatchListStream().listen((data) {
  //     _watchServiceList = data;
  //     notifyListeners();
  //   });
  // }
  // // Delete a service from the watch list
  // Future<void> deleteServiceForWatchListPro(
  //     WatchListServiceModel watchListServiceModel) async {
  //   try {
  //     bool isDeleted = await _firebaseFirestoreHelper
  //         .deleteServiceForWatchListFB(watchListServiceModel.id);
  //     if (isDeleted) {
  //       _watchServiceList.remove(watchListServiceModel);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print("Error deleting service from watch list: $e");
  //   }
  // }
}
