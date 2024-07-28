import 'package:flutter/material.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/models/category_model/category_model.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/watchlist_service_model/watchlist_service_model.dart';

class AppProvider with ChangeNotifier {
  final FirebaseFirestoreHelper _firebaseFirestoreHelper =
      FirebaseFirestoreHelper.instance;

  SalonModel? _salonModel;
  List<CategoryModel> _categoryList = [];
  List<WatchListServiceModel> _watchServiceList = [];

  SalonModel? get getSalonInformation => _salonModel;
  List<CategoryModel> get getcategoryList => _categoryList;
  List<WatchListServiceModel> get getWatchServiceList => _watchServiceList;

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

  // Fetch watch list services as a stream
  Stream<List<WatchListServiceModel>> getWatchListStream() {
    return _firebaseFirestoreHelper.getWatchListServiceFB();
  }

  // Fetch watch list services and update _watchServiceList
  Future<void> fetchWatchList() async {
    getWatchListStream().listen((data) {
      _watchServiceList = data;
      notifyListeners();
    });
  }

  // Delete a service from the watch list
  Future<void> deleteServiceForWatchListPro(
      WatchListServiceModel watchListServiceModel) async {
    try {
      bool isDeleted = await _firebaseFirestoreHelper
          .deleteServiceForWatchListFB(watchListServiceModel.id);
      if (isDeleted) {
        _watchServiceList.remove(watchListServiceModel);
        notifyListeners();
      }
    } catch (e) {
      print("Error deleting service from watch list: $e");
    }
  }

  //call back Functon for get Category and Service List
  Future<void> callBackFunctionWinder(
    String salonId,
    adminId,
  ) async {
    await getCategoryListFunPro(salonId, adminId);
  }

  // Fetch salon information from Firebase
  Future<void> getSalonInfoFirebase(String adminId, String salonId) async {
    try {
      Map<String, dynamic>? salonData =
          await _firebaseFirestoreHelper.getSingleSalonInfo(adminId, salonId);
      if (salonData != null) {
        _salonModel = SalonModel.fromJson(salonData);
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching salon information: $e");
    }
  }
}
