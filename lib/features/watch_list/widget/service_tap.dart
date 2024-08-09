// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:samay_mvp/constants/constants.dart';
// import 'package:samay_mvp/models/service_model/service_model.dart';
// import 'package:samay_mvp/provider/app_provider.dart';
// import 'package:samay_mvp/utility/color.dart';
// import 'package:samay_mvp/utility/dimension.dart';
// import 'package:samay_mvp/widget/custom_chip.dart';

// class SingleServiceTap extends StatefulWidget {
//   final ServiceModel serviceModel;

//   const SingleServiceTap({
//     Key? key,
//     required this.serviceModel,
//   }) : super(key: key);

//   @override
//   State<SingleServiceTap> createState() => _SingleServiceTapState();
// }

// class _SingleServiceTapState extends State<SingleServiceTap> {
//   bool isLoading = false;
//   String categoryName = '';

//   void initState() {
//     // TODO: implement initState
//     getDate();
//     super.initState();
//   }

//   void getDate() async {
//     setState(() {
//       isLoading = true;
//     });
//     AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

//     categoryName = appProvider.getCategoryInformation!.categoryName;
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppProvider appProvider = Provider.of<AppProvider>(context);

//     return Container(
//       margin: EdgeInsets.only(bottom: Dimensions.dimenisonNo12),
//       padding: EdgeInsets.symmetric(
//           vertical: Dimensions.dimenisonNo10,
//           horizontal: Dimensions.dimenisonNo14),
//       decoration: BoxDecoration(
//           border: Border.all(width: 1, color: Colors.black),
//           borderRadius: BorderRadius.circular(Dimensions.dimenisonNo10)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(right: Dimensions.dimenisonNo12),
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: Dimensions.dimenisonNo200,
//                   child: Text(
//                     '▪️ ${widget.serviceModel.servicesName}',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: Dimensions.dimenisonNo20,
//                       fontFamily: GoogleFonts.roboto().fontFamily,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 CustomChip(
//                   text: widget.serviceModel.categoryName,
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo10),
//             child: const Divider(),
//           ),
//           Row(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: Dimensions.dimenisonNo5,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "During : ",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: Dimensions.dimenisonNo18,
//                           fontFamily: GoogleFonts.roboto().fontFamily,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                       widget.serviceModel.hours >= 1
//                           ? Text(
//                               ' ${widget.serviceModel.hours.toInt()}Hr :',
//                               style: TextStyle(
//                                 color: AppColor.serviceTapTextColor,
//                                 fontSize: Dimensions.dimenisonNo18,
//                                 fontFamily: GoogleFonts.roboto().fontFamily,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 1,
//                               ),
//                             )
//                           : SizedBox(),
//                       Text(
//                         "${widget.serviceModel.minutes.toInt()}Min",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: Dimensions.dimenisonNo18,
//                           fontFamily: GoogleFonts.roboto().fontFamily,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: Dimensions.dimenisonNo5,
//                   ),
//                   SizedBox(
//                     height: Dimensions.dimenisonNo5,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'Total Amount :  ',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: Dimensions.dimenisonNo16,
//                           fontFamily: GoogleFonts.roboto().fontFamily,
//                           fontWeight: FontWeight.w400,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                       Icon(
//                         Icons.currency_rupee_outlined,
//                         size: Dimensions.dimenisonNo16,
//                       ),
//                       Text(
//                         widget.serviceModel.price.toString(),
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: Dimensions.dimenisonNo16,
//                           fontFamily: GoogleFonts.roboto().fontFamily,
//                           fontWeight: FontWeight.w400,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               IconButton(
//                 onPressed: () {
//                   try {
//                     showLoaderDialog(context);
//                     appProvider.removeServiceToWatchList(widget.serviceModel);
//                     appProvider.calculateSubTotal();
//                     appProvider.calculateTotalBookingDuration();

//                     Navigator.of(context, rootNavigator: true).pop();

//                     showMessage('Service is remove for Watch List');
//                   } catch (e) {
//                     showMessage(
//                         'Error occur not remove service for Watch List ${e.toString()}');
//                   }
//                 },
//                 icon: Icon(
//                   Icons.delete,
//                   color: AppColor.pendingColor,
//                   size: Dimensions.dimenisonNo40,
//                 ),
//               ),
//               SizedBox(
//                 width: Dimensions.dimenisonNo12,
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_chip.dart';

class SingleServiceTap extends StatefulWidget {
  final ServiceModel serviceModel;

  const SingleServiceTap({
    Key? key,
    required this.serviceModel,
  }) : super(key: key);

  @override
  State<SingleServiceTap> createState() => _SingleServiceTapState();
}

class _SingleServiceTapState extends State<SingleServiceTap> {
  bool isLoading = false;
  String categoryName = '';

  @override
  void initState() {
    super.initState();
    getDate();
  }

  void getDate() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    // Use null-aware operator to safely access category information
    categoryName =
        appProvider.getCategoryInformation?.categoryName ?? 'Unknown';
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.dimenisonNo12),
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.dimenisonNo10,
          horizontal: Dimensions.dimenisonNo14),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(Dimensions.dimenisonNo10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: Dimensions.dimenisonNo12),
            child: Row(
              children: [
                SizedBox(
                  width: Dimensions.dimenisonNo200,
                  child: Text(
                    '▪️ ${widget.serviceModel.servicesName}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.dimenisonNo20,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Spacer(),
                CustomChip(
                  text: widget.serviceModel.categoryName,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo10),
            child: const Divider(),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.dimenisonNo5,
                  ),
                  Row(
                    children: [
                      Text(
                        "During : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.dimenisonNo18,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      widget.serviceModel.hours >= 1
                          ? Text(
                              ' ${widget.serviceModel.hours.toInt()}Hr :',
                              style: TextStyle(
                                color: AppColor.serviceTapTextColor,
                                fontSize: Dimensions.dimenisonNo18,
                                fontFamily: GoogleFonts.roboto().fontFamily,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            )
                          : SizedBox(),
                      Text(
                        "${widget.serviceModel.minutes.toInt()}Min",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.dimenisonNo18,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.dimenisonNo5,
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Amount :  ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.dimenisonNo16,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                      Icon(
                        Icons.currency_rupee_outlined,
                        size: Dimensions.dimenisonNo16,
                      ),
                      Text(
                        widget.serviceModel.price.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.dimenisonNo16,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  try {
                    showLoaderDialog(context);
                    appProvider.removeServiceToWatchList(widget.serviceModel);
                    appProvider.calculateSubTotal();
                    appProvider.calculateTotalBookingDuration();

                    Navigator.of(context, rootNavigator: true).pop();

                    showMessage('Service is removed from Watch List');
                  } catch (e) {
                    showMessage(
                        'Error occurred while removing service from Watch List: ${e.toString()}');
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: AppColor.pendingColor,
                  size: Dimensions.dimenisonNo40,
                ),
              ),
              SizedBox(
                width: Dimensions.dimenisonNo12,
              )
            ],
          ),
        ],
      ),
    );
  }
}
