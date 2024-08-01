import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/models/category_model/category_model.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_button.dart';
import 'package:samay_mvp/widget/dotted_line.dart';

class CategoryTap extends StatefulWidget {
  final CategoryModel categoryModel;
  final SalonModel salonModel;
  CategoryTap({
    Key? key,
    required this.categoryModel,
    required this.salonModel,
  }) : super(key: key);

  @override
  State<CategoryTap> createState() => _CategoryTapState();
}

class _CategoryTapState extends State<CategoryTap> {
  List<ServiceModel> serviceModelList = [];
  bool _categoryTapOpen = true; // Set to true to open by default
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchWinderData();
  }

  Future<void> _fetchWinderData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      serviceModelList =
          await FirebaseFirestoreHelper.instance.getServicesListFB(
        widget.salonModel.id,
        widget.salonModel.adminId,
        widget.categoryModel.id,
      );
    } catch (e, stackTrace) {
      // Log the error for debugging purposes
      print('Error fetching services: $e');
      print('Stack trace: $stackTrace');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: Dimensions.dimenisonNo10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.dimenisonNo10),
          child: ListTile(
            title: Text(
              widget.categoryModel.categoryName,
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.dimenisonNo22,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            trailing: Icon(
              _categoryTapOpen
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_up,
            ),
            onTap: () {
              setState(() {
                _categoryTapOpen = !_categoryTapOpen;
              });
            },
          ),
        ),
        if (_categoryTapOpen)
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage != null
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: Dimensions.dimenisonNo55),
                        child: Text(
                          errorMessage!,
                          style: TextStyle(
                            fontSize: Dimensions.dimenisonNo24,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  : serviceModelList.isEmpty
                      ? Center(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: Dimensions.dimenisonNo55),
                            child: Text(
                              "No Service available",
                              style: TextStyle(
                                fontSize: Dimensions.dimenisonNo24,
                                fontFamily: GoogleFonts.roboto().fontFamily,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          // primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: serviceModelList.length,
                          itemBuilder: (context, index) {
                            ServiceModel serviceModel = serviceModelList[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomDotttedLine(),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: Dimensions.dimenisonNo16,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.dimenisonNo16,
                                    horizontal: Dimensions.dimenisonNo16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        serviceModel.servicesName,
                                        style: TextStyle(
                                          color: AppColor.serviceTapTextColor,
                                          fontSize: Dimensions.dimenisonNo24,
                                          fontFamily:
                                              GoogleFonts.lato().fontFamily,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(
                                          height: Dimensions.dimenisonNo10),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.watch_later_outlined,
                                            size: Dimensions.dimenisonNo22,
                                            color: Colors.black,
                                          ),
                                          serviceModel.hours >= 1
                                              ? Text(
                                                  ' ${serviceModel.hours.toInt()}Hr :',
                                                  style: TextStyle(
                                                    color: AppColor
                                                        .serviceTapTextColor,
                                                    fontSize: Dimensions
                                                        .dimenisonNo18,
                                                    fontFamily:
                                                        GoogleFonts.roboto()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                )
                                              : SizedBox(),
                                          Text(
                                            ' ${serviceModel.minutes.toInt()}Min',
                                            style: TextStyle(
                                              color:
                                                  AppColor.serviceTapTextColor,
                                              fontSize:
                                                  Dimensions.dimenisonNo18,
                                              fontFamily: GoogleFonts.roboto()
                                                  .fontFamily,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.currency_rupee_rounded,
                                            size: Dimensions.dimenisonNo20,
                                          ),
                                          Text(
                                            ' ${serviceModel.price}',
                                            style: TextStyle(
                                              color:
                                                  AppColor.serviceTapTextColor,
                                              fontSize:
                                                  Dimensions.dimenisonNo18,
                                              fontFamily: GoogleFonts.roboto()
                                                  .fontFamily,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          CustomButtom(
                                            text: "Add+",
                                            ontap: () {
                                              setState(() {
                                                appProvider
                                                    .addServiceToWatchList(
                                                        serviceModel);
                                              });
                                              appProvider.calculateSubTotal();
                                              appProvider
                                                  .calculateTotalBookingDuration();
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: Dimensions.dimenisonNo16),
                                      Text(
                                        serviceModel.description,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Dimensions.dimenisonNo16,
                                          fontFamily:
                                              GoogleFonts.roboto().fontFamily,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(
                                          height: Dimensions.dimenisonNo16),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
      ],
    );
  }
}
