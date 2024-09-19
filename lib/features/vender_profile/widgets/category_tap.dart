import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/features/vender_profile/widgets/service_tap_with_description.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/models/category_model/category_model.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/dimension.dart';

class CategoryTap extends StatefulWidget {
  final CategoryModel categoryModel;
  final SalonModel salonModel;
  const CategoryTap({
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
      AppProvider appProvider =
          Provider.of<AppProvider>(context, listen: false);
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching services: $e';
      });
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

                            return ServiceTapWithDescription(
                                serviceModel: serviceModel);
                          },
                        ),
      ],
    );
  }
}
