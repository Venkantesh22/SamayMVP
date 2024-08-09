// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:samay_mvp/features/app_bar/app_bar.dart';
// import 'package:samay_mvp/features/drawer/app_drawer.dart';
// import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
// import 'package:samay_mvp/models/service_model/service_model.dart';
// import 'package:samay_mvp/provider/app_provider.dart';
// import 'package:samay_mvp/utility/color.dart';
// import 'package:samay_mvp/utility/dimension.dart';
// import 'package:samay_mvp/widget/custom_button.dart';

// class SummaryScreen extends StatefulWidget {
//   SalonModel salonModel;
//   final String serviceDate;
//   final String serviceStartTime;
//   final String serviceEndTime;
//   final String userNote;
//   final bool isNodeAdd;

//   SummaryScreen({
//     Key? key,
//     required this.salonModel,
//     required this.serviceDate,
//     required this.serviceStartTime,
//     required this.serviceEndTime,
//     required this.userNote,
//     required this.isNodeAdd,
//   }) : super(key: key);

//   @override
//   State<SummaryScreen> createState() => _SummaryScreenState();
// }

// class _SummaryScreenState extends State<SummaryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//     AppProvider appProvider = Provider.of<AppProvider>(context);

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF3F3F3),
//         key: _scaffoldKey,
//         appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
//         drawer: const CustomDrawer(),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(Dimensions.dimenisonNo16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: Dimensions.dimenisonNo20,
//                 ),
//                 Text(
//                   'Appointment Detail',
//                   style: TextStyle(
//                     fontSize: Dimensions.dimenisonNo22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Divider(),
//                 SizedBox(height: Dimensions.dimenisonNo10),
//                 Container(
//                   padding: EdgeInsets.all(Dimensions.dimenisonNo12),
//                   decoration: BoxDecoration(
//                     color: AppColor.grey,
//                     borderRadius:
//                         BorderRadius.circular(Dimensions.dimenisonNo10),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             'Booking Date',
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             widget.serviceDate,
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: Dimensions.dimenisonNo10),
//                       Row(
//                         children: [
//                           Text(
//                             'Booking Duration',
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             appProvider.getServiceBookingDuration,
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: Dimensions.dimenisonNo10),
//                       Row(
//                         children: [
//                           Text(
//                             'Booking Start Time',
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             widget.serviceStartTime,
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: Dimensions.dimenisonNo10),
//                       Row(
//                         children: [
//                           Text(
//                             'Booking End Time',
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             widget.serviceEndTime,
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: Dimensions.dimenisonNo20,
//                 ),
//                 if (widget.isNodeAdd) ...[
//                   Text(
//                     "Note : ",
//                     style: TextStyle(
//                       fontSize: Dimensions.dimenisonNo20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.90,
//                     ),
//                   ),
//                   SizedBox(height: Dimensions.dimenisonNo5),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: Dimensions.dimenisonNo12),
//                     child: Text(
//                       widget.userNote,
//                       style: TextStyle(
//                         fontSize: Dimensions.dimenisonNo18,
//                         letterSpacing: 0.90,
//                       ),
//                     ),
//                   ),
//                 ],
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo12),
//                   child: Divider(),
//                 ),
//                 Text(
//                   'Service Summery (${appProvider.getWatchList.length})',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: Dimensions.dimenisonNo22,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: Dimensions.dimenisonNo16),
//                 Container(
//                   padding: EdgeInsets.all(Dimensions.dimenisonNo12),
//                   decoration: BoxDecoration(
//                       borderRadius:
//                           BorderRadius.circular(Dimensions.dimenisonNo10),
//                       border: Border.all(width: 1, color: Colors.black)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: appProvider.getWatchList.length,
//                         itemBuilder: (context, index) {
//                           ServiceModel serviceModel =
//                               appProvider.getWatchList[index];
//                           index = index + 1;
//                           return Row(
//                             children: [
//                               Text(
//                                 '$index. ${serviceModel.servicesName}',
//                                 style: TextStyle(
//                                   fontSize: Dimensions.dimenisonNo18,
//                                   fontWeight: FontWeight.w500,
//                                   letterSpacing: 0.90,
//                                 ),
//                               ),
//                               Spacer(),
//                               Icon(
//                                 Icons.currency_rupee,
//                                 size: Dimensions.dimenisonNo20,
//                               ),
//                               Text(
//                                 serviceModel.price.toString(),
//                                 style: TextStyle(
//                                   fontSize: Dimensions.dimenisonNo18,
//                                   fontWeight: FontWeight.w500,
//                                   letterSpacing: 0.90,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: Dimensions.dimenisonNo30,
//                               )
//                             ],
//                           );
//                         },
//                       ),
//                       SizedBox(
//                         height: Dimensions.dimenisonNo22,
//                       ),
//                       Divider(),
//                       SizedBox(
//                         height: Dimensions.dimenisonNo12,
//                       ),
//                       Text(
//                         widget.salonModel.name,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: Dimensions.dimenisonNo20,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                       SizedBox(
//                         height: Dimensions.dimenisonNo5,
//                       ),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.location_on_rounded,
//                             size: Dimensions.dimenisonNo22,
//                           ),
//                           SizedBox(
//                             width: Dimensions.dimenisonNo5,
//                           ),
//                           Text(
//                             widget.salonModel.address,
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: Dimensions.dimenisonNo20,
//                 ),
//                 Text(
//                   'Price Details',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: Dimensions.dimenisonNo22,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 1,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(Dimensions.dimenisonNo12),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             'Price',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo16,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           SizedBox(
//                             width: Dimensions.dimenisonNo5,
//                           ),
//                           Text(
//                             '(service ${appProvider.getWatchList.length})',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo16,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Icon(
//                             Icons.currency_rupee,
//                             size: Dimensions.dimenisonNo18,
//                           ),
//                           Text(
//                             appProvider.getSubTotal.toString(),
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo16,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: Dimensions.dimenisonNo12,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             'Platform fees',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo16,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Icon(
//                             Icons.currency_rupee,
//                             size: Dimensions.dimenisonNo18,
//                           ),
//                           Text(
//                             '20.0',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo16,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: Dimensions.dimenisonNo20,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             'Total Amount',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo20,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Icon(
//                             Icons.currency_rupee,
//                             size: Dimensions.dimenisonNo18,
//                           ),
//                           Text(
//                             appProvider.getfinalTotal.toString(),
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo20,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: Dimensions.dimenisonNo10,
//                 ),
//                 SizedBox(
//                     height: Dimensions.dimenisonNo55,
//                     width: double.infinity,
//                     child: CustomButtom(text: "Confime & Pay", ontap: () {}))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//!!
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:samay_mvp/constants/router.dart';
// import 'package:samay_mvp/features/Payment/screen/payment_screen.dart';
// import 'package:samay_mvp/features/app_bar/app_bar.dart';
// import 'package:samay_mvp/features/drawer/app_drawer.dart';
// import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
// import 'package:samay_mvp/models/service_model/service_model.dart';
// import 'package:samay_mvp/provider/app_provider.dart';
// import 'package:samay_mvp/utility/color.dart';
// import 'package:samay_mvp/utility/dimension.dart';
// import 'package:samay_mvp/widget/custom_button.dart';

// class SummaryScreen extends StatefulWidget {
//   final SalonModel salonModel;
//   final String serviceDate;
//   final String serviceStartTime;
//   final String serviceEndTime;
//   final String userNote;
//   final bool isNodeAdd;

//   SummaryScreen({
//     Key? key,
//     required this.salonModel,
//     required this.serviceDate,
//     required this.serviceStartTime,
//     required this.serviceEndTime,
//     required this.userNote,
//     required this.isNodeAdd,
//   }) : super(key: key);

//   @override
//   State<SummaryScreen> createState() => _SummaryScreenState();
// }

// class _SummaryScreenState extends State<SummaryScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//     AppProvider appProvider = Provider.of<AppProvider>(context);

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF3F3F3),
//         key: _scaffoldKey,
//         appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
//         drawer: const CustomDrawer(),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(Dimensions.dimenisonNo16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: Dimensions.dimenisonNo20,
//                 ),
//                 // Appointment Detail Section
//                 Text(
//                   'Appointment Details',
//                   style: TextStyle(
//                     fontSize: Dimensions.dimenisonNo22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Divider(),
//                 SizedBox(height: Dimensions.dimenisonNo10),
//                 Container(
//                   padding: EdgeInsets.all(Dimensions.dimenisonNo12),
//                   decoration: BoxDecoration(
//                     color: AppColor.grey,
//                     borderRadius:
//                         BorderRadius.circular(Dimensions.dimenisonNo10),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Booking Date
//                       Row(
//                         children: [
//                           Text(
//                             'Booking Date',
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             widget.serviceDate,
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: Dimensions.dimenisonNo10),
//                       // Booking Duration
//                       Row(
//                         children: [
//                           Text(
//                             'Booking Duration',
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             appProvider.getServiceBookingDuration,
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: Dimensions.dimenisonNo10),
//                       // Booking Start Time
//                       Row(
//                         children: [
//                           Text(
//                             'Booking Start Time',
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             widget.serviceStartTime,
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: Dimensions.dimenisonNo10),
//                       // Booking End Time
//                       Row(
//                         children: [
//                           Text(
//                             'Booking End Time',
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             widget.serviceEndTime,
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: Dimensions.dimenisonNo20,
//                 ),
//                 // User Note Section
//                 if (widget.isNodeAdd) ...[
//                   Text(
//                     "Note:",
//                     style: TextStyle(
//                       fontSize: Dimensions.dimenisonNo20,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.90,
//                     ),
//                   ),
//                   SizedBox(height: Dimensions.dimenisonNo5),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: Dimensions.dimenisonNo12),
//                     child: Text(
//                       widget.userNote,
//                       style: TextStyle(
//                         fontSize: Dimensions.dimenisonNo18,
//                         letterSpacing: 0.90,
//                       ),
//                     ),
//                   ),
//                 ],
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo12),
//                   child: Divider(),
//                 ),
//                 // Service Summary Section
//                 Text(
//                   'Service Summary (${appProvider.getWatchList.length})',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: Dimensions.dimenisonNo22,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(height: Dimensions.dimenisonNo16),
//                 Container(
//                   padding: EdgeInsets.all(Dimensions.dimenisonNo12),
//                   decoration: BoxDecoration(
//                     borderRadius:
//                         BorderRadius.circular(Dimensions.dimenisonNo10),
//                     border: Border.all(width: 1, color: Colors.black),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: appProvider.getWatchList.length,
//                         itemBuilder: (context, index) {
//                           ServiceModel serviceModel =
//                               appProvider.getWatchList[index];
//                           index = index + 1;
//                           return Row(
//                             children: [
//                               Text(
//                                 '$index. ${serviceModel.servicesName}',
//                                 style: TextStyle(
//                                   fontSize: Dimensions.dimenisonNo18,
//                                   fontWeight: FontWeight.w500,
//                                   letterSpacing: 0.90,
//                                 ),
//                               ),
//                               Spacer(),
//                               Icon(
//                                 Icons.currency_rupee,
//                                 size: Dimensions.dimenisonNo20,
//                               ),
//                               Text(
//                                 serviceModel.price.toString(),
//                                 style: TextStyle(
//                                   fontSize: Dimensions.dimenisonNo18,
//                                   fontWeight: FontWeight.w500,
//                                   letterSpacing: 0.90,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: Dimensions.dimenisonNo30,
//                               )
//                             ],
//                           );
//                         },
//                       ),
//                       SizedBox(
//                         height: Dimensions.dimenisonNo22,
//                       ),
//                       Divider(),
//                       SizedBox(
//                         height: Dimensions.dimenisonNo12,
//                       ),
//                       Text(
//                         widget.salonModel.name,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: Dimensions.dimenisonNo20,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                       SizedBox(
//                         height: Dimensions.dimenisonNo5,
//                       ),
//                       // Salon Location
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.location_on_rounded,
//                             size: Dimensions.dimenisonNo22,
//                           ),
//                           SizedBox(
//                             width: Dimensions.dimenisonNo5,
//                           ),
//                           Text(
//                             widget.salonModel.address,
//                             style: TextStyle(
//                               fontSize: Dimensions.dimenisonNo18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: Dimensions.dimenisonNo20,
//                 ),
//                 // Price Details Section
//                 Text(
//                   'Price Details',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: Dimensions.dimenisonNo22,
//                     fontWeight: FontWeight.w700,
//                     letterSpacing: 1,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(Dimensions.dimenisonNo12),
//                   child: Column(
//                     children: [
//                       // Price
//                       Row(
//                         children: [
//                           Text(
//                             'Price',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo16,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           SizedBox(
//                             width: Dimensions.dimenisonNo5,
//                           ),
//                           Text(
//                             '(services ${appProvider.getWatchList.length})',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo16,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Icon(
//                             Icons.currency_rupee,
//                             size: Dimensions.dimenisonNo18,
//                           ),
//                           Text(
//                             appProvider.getSubTotal.toString(),
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo16,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: Dimensions.dimenisonNo10,
//                       ),
//                       // Platform Fees
//                       Row(
//                         children: [
//                           Text(
//                             'Platform Fees',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo16,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Icon(
//                             Icons.currency_rupee,
//                             size: Dimensions.dimenisonNo18,
//                           ),
//                           Text(
//                             '20.0',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo16,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: Dimensions.dimenisonNo20,
//                       ),
//                       // Total Amount
//                       Row(
//                         children: [
//                           Text(
//                             'Total Amount',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo20,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                           Spacer(),
//                           Icon(
//                             Icons.currency_rupee,
//                             size: Dimensions.dimenisonNo18,
//                           ),
//                           Text(
//                             appProvider.getfinalTotal.toString(),
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: Dimensions.dimenisonNo20,
//                               fontWeight: FontWeight.w600,
//                               letterSpacing: 0.90,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: Dimensions.dimenisonNo10,
//                 ),
//                 SizedBox(
//                   height: Dimensions.dimenisonNo55,
//                   width: double.infinity,
//                   child: CustomButtom(
//                     text: "Confime & Pay",
//                     ontap: () {
//                       Routes.instance.push(
//                           widget: PaymentMethodScreen(
//                             salonModel: widget.salonModel,
//                             serviceDate: widget.serviceDate,
//                             serviceStartTime: widget.serviceStartTime,
//                             serviceEndTime: widget.serviceEndTime,
//                             userNote: widget.isNodeAdd ? widget.userNote : " ",
//                           ),
//                           context: context);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/constants/router.dart';
import 'package:samay_mvp/features/Payment/screen/payment_screen.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_button.dart';

class SummaryScreen extends StatefulWidget {
  final SalonModel salonModel;
  final String serviceDate;
  final String serviceStartTime;
  final String serviceEndTime;
  final String userNote;
  final bool isNodeAdd;

  SummaryScreen({
    Key? key,
    required this.salonModel,
    required this.serviceDate,
    required this.serviceStartTime,
    required this.serviceEndTime,
    required this.userNote,
    required this.isNodeAdd,
  }) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            const Color(0xFFF3F3F3), // Background color of the screen
        key: _scaffoldKey,
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(Dimensions.dimenisonNo16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.dimenisonNo20),

                // Appointment Detail Section
                Text(
                  'Appointment Details',
                  style: TextStyle(
                    fontSize: Dimensions.dimenisonNo22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                Divider(),
                SizedBox(height: Dimensions.dimenisonNo10),
                Container(
                  padding: EdgeInsets.all(Dimensions.dimenisonNo12),
                  decoration: BoxDecoration(
                    color: AppColor.grey,
                    borderRadius:
                        BorderRadius.circular(Dimensions.dimenisonNo10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Booking Date
                      Row(
                        children: [
                          Text(
                            'Appointment Date',
                            style: TextStyle(
                              fontSize: Dimensions.dimenisonNo18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.90,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.serviceDate,
                            style: TextStyle(
                              fontSize: Dimensions.dimenisonNo18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.dimenisonNo10),

                      // Booking Duration
                      Row(
                        children: [
                          Text(
                            'Appointment Duration',
                            style: TextStyle(
                              fontSize: Dimensions.dimenisonNo18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.90,
                            ),
                          ),
                          Spacer(),
                          Text(
                            appProvider.getServiceBookingDuration,
                            style: TextStyle(
                              fontSize: Dimensions.dimenisonNo18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.90,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.dimenisonNo10),

                      // Booking Start Time
                      Row(
                        children: [
                          Text(
                            'Appointment Start-Time',
                            style: TextStyle(
                              fontSize: Dimensions.dimenisonNo18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.90,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.serviceStartTime,
                            style: TextStyle(
                              fontSize: Dimensions.dimenisonNo18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.90,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.dimenisonNo10),

                      // Booking End Time
                      Row(
                        children: [
                          Text(
                            'Appointment End-Time',
                            style: TextStyle(
                              fontSize: Dimensions.dimenisonNo18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.90,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.serviceEndTime,
                            style: TextStyle(
                              fontSize: Dimensions.dimenisonNo18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.90,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.dimenisonNo20),

                // User Note Section
                if (widget.isNodeAdd) ...[
                  Text(
                    "Note:",
                    style: TextStyle(
                      fontSize: Dimensions.dimenisonNo20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.90,
                    ),
                  ),
                  SizedBox(height: Dimensions.dimenisonNo5),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.dimenisonNo12),
                    child: Text(
                      widget.userNote,
                      style: TextStyle(
                        fontSize: Dimensions.dimenisonNo18,
                        letterSpacing: 0.90,
                      ),
                    ),
                  ),
                ],
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo12),
                  child: Divider(),
                ),

                // Service Summary Section
                Text(
                  'Service Summary (${appProvider.getWatchList.length})',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.dimenisonNo22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.0,
                  ),
                ),
                SizedBox(height: Dimensions.dimenisonNo16),
                Container(
                  padding: EdgeInsets.all(Dimensions.dimenisonNo12),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.dimenisonNo10),
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: appProvider.getWatchList.length,
                        itemBuilder: (context, index) {
                          ServiceModel serviceModel =
                              appProvider.getWatchList[index];
                          index = index + 1;
                          return Row(
                            children: [
                              Text(
                                '$index. ${serviceModel.servicesName}',
                                style: TextStyle(
                                  fontSize: Dimensions.dimenisonNo18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.90,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.currency_rupee,
                                size: Dimensions.dimenisonNo20,
                              ),
                              Text(
                                serviceModel.price.toString(),
                                style: TextStyle(
                                  fontSize: Dimensions.dimenisonNo18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.90,
                                ),
                              ),
                              SizedBox(height: Dimensions.dimenisonNo30),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: Dimensions.dimenisonNo22),
                      Divider(),
                      SizedBox(height: Dimensions.dimenisonNo10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: Dimensions.dimenisonNo70,
                            width: Dimensions.dimenisonNo120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.dimenisonNo10),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              widget.salonModel.image!,
                              fit: BoxFit
                                  .cover, // Ensures the image covers the container properly
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          SizedBox(width: Dimensions.dimenisonNo20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.salonModel.name,
                                  style: GoogleFonts.roboto(
                                    fontSize: Dimensions.dimenisonNo20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: Dimensions.dimenisonNo8),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.dimenisonNo5),
                                  child: Text(
                                    widget.salonModel.salonType,
                                    style: TextStyle(
                                      // color: Colors.black,
                                      color: Color.fromARGB(255, 88, 87, 87),
                                      fontSize: Dimensions.dimenisonNo14,
                                      fontFamily:
                                          GoogleFonts.roboto().fontFamily,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                SizedBox(height: Dimensions.dimenisonNo8),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.dimenisonNo10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_rounded),
                          SizedBox(width: Dimensions.dimenisonNo5),
                          Expanded(
                            child: Text(
                              widget.salonModel.address,
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.roboto(
                                fontSize: Dimensions.dimenisonNo16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: Dimensions.dimenisonNo12),
                      // Text(
                      //   widget.salonModel.name,
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: Dimensions.dimenisonNo20,
                      //     fontWeight: FontWeight.bold,
                      //     letterSpacing: 1.0,
                      //   ),
                      // ),
                      // SizedBox(height: Dimensions.dimenisonNo5),

                      // // Salon Location
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.location_on_rounded,
                      //       size: Dimensions.dimenisonNo22,
                      //     ),
                      //     SizedBox(width: Dimensions.dimenisonNo5),
                      //     Text(
                      //       widget.salonModel.address,
                      //       style: TextStyle(
                      //         fontSize: Dimensions.dimenisonNo18,
                      //         fontWeight: FontWeight.w500,
                      //         letterSpacing: 0.90,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.dimenisonNo20),

                // Price Details Section
                Text(
                  'Price Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.dimenisonNo22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimensions.dimenisonNo12),
                  child: Column(
                    children: [
                      // Price Details Section
                      Row(
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.dimenisonNo16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.90,
                            ),
                          ),
                          SizedBox(width: Dimensions.dimenisonNo5),
                          Text(
                            '(services ${appProvider.getWatchList.length})',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.dimenisonNo16,
                              // fontWeight: FontWeight.w500,
                              letterSpacing: 0.90,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.currency_rupee,
                            size: Dimensions.dimenisonNo18,
                          ),
                          Text(
                            appProvider.getSubTotal.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.dimenisonNo16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.90,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.dimenisonNo10),

                      // Platform Fees
                      Row(
                        children: [
                          Text(
                            'Platform Fees',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.dimenisonNo16,
                              // fontWeight: FontWeight.w500,
                              letterSpacing: 0.90,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.currency_rupee,
                            size: Dimensions.dimenisonNo18,
                          ),
                          Text(
                            '20.0',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.dimenisonNo16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.90,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.dimenisonNo20),

                      // Total Amount
                      Row(
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.dimenisonNo20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.90,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.currency_rupee,
                            size: Dimensions.dimenisonNo18,
                          ),
                          Text(
                            appProvider.getfinalTotal.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.dimenisonNo20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.90,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.dimenisonNo10),

                // Confirm & Pay Button
                SizedBox(
                  height: Dimensions.dimenisonNo55,
                  width: double.infinity,
                  child: CustomButtom(
                    text: "Confirm & Pay",
                    ontap: () {
                      Routes.instance.push(
                        widget: PaymentMethodScreen(
                          salonModel: widget.salonModel,
                          serviceDate: widget.serviceDate,
                          serviceStartTime: widget.serviceStartTime,
                          serviceEndTime: widget.serviceEndTime,
                          userNote: widget.isNodeAdd ? widget.userNote : " ",
                        ),
                        context: context,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
