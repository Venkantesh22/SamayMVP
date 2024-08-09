import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/constants/router.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/appointment_detail/screen/appointment_detail_screen.dart';
import 'package:samay_mvp/features/appointment_detail/widget/state_text.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/models/user_order/user_order_model.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_chip.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
          drawer: const CustomDrawer(),
          body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              child: Container(
                  padding: EdgeInsets.all(Dimensions.dimenisonNo16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Appointment List",
                          style: GoogleFonts.roboto(
                            fontSize: Dimensions.dimenisonNo24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: Dimensions.dimenisonNo20),
                        Container(
                            margin: EdgeInsets.only(
                                bottom: Dimensions.dimenisonNo20),
                            child: StreamBuilder<List<OrderModel>>(
                              stream: Stream.fromFuture(FirebaseFirestoreHelper
                                  .instance
                                  .getUserOrderFB()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text("No Order Found"),
                                  );
                                }

                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    OrderModel orderModel =
                                        snapshot.data![index];
                                    return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Dimensions.dimenisonNo16),
                                        child: ExpansionTile(
                                          clipBehavior: Clip.antiAlias,
                                          childrenPadding: EdgeInsets.only(
                                              bottom: Dimensions.dimenisonNo12),
                                          collapsedShape:
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .dimenisonNo10),
                                                  side: const BorderSide(
                                                      color: Colors.black,
                                                      width: 2.3)),
                                          shape: const RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.black,
                                                  width: 2.3)),
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height:
                                                    Dimensions.dimenisonNo120,
                                                width:
                                                    Dimensions.dimenisonNo180,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions
                                                              .dimenisonNo10),
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                child: Image.network(
                                                  orderModel.salonModel.image!,
                                                  fit: BoxFit
                                                      .cover, // Change to cover for better image fit
                                                ),
                                              ),
                                              SizedBox(
                                                  width:
                                                      Dimensions.dimenisonNo12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      orderModel
                                                          .salonModel.name,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: Dimensions
                                                            .dimenisonNo20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .dimenisonNo8),
                                                    Text(
                                                      orderModel.serviceDate,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: Dimensions
                                                            .dimenisonNo16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .dimenisonNo8),
                                                    StateText(
                                                        orderModel: orderModel)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          children:
                                              orderModel.services.isNotEmpty
                                                  ? [
                                                      Divider(),
                                                      Text(
                                                        'Appointment Time: ${orderModel.serviceStartTime} - ${orderModel.serviceEndTime}',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: Dimensions
                                                              .dimenisonNo18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      // Iterate through the list of services in the order
                                                      ...orderModel.services
                                                          .map(
                                                        (singleService) {
                                                          return GestureDetector(
                                                              child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: Dimensions
                                                                      .dimenisonNo12,
                                                                  right: Dimensions
                                                                      .dimenisonNo12,
                                                                  top: Dimensions
                                                                      .dimenisonNo12,
                                                                ),
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical:
                                                                        Dimensions
                                                                            .dimenisonNo10,
                                                                    horizontal:
                                                                        Dimensions
                                                                            .dimenisonNo14),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Colors
                                                                          .black),
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          Dimensions
                                                                              .dimenisonNo10),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    // Service name and category
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            '▪️ ${singleService.servicesName}',
                                                                            style:
                                                                                GoogleFonts.roboto(
                                                                              color: Colors.black,
                                                                              fontSize: Dimensions.dimenisonNo20,
                                                                              fontWeight: FontWeight.bold,
                                                                              letterSpacing: 1,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        // Displaying service category with a custom chip
                                                                        CustomChip(
                                                                            text:
                                                                                singleService.categoryName),
                                                                      ],
                                                                    ),
                                                                    const Divider(),
                                                                    // Service details including duration and total amount
                                                                    Row(
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(height: Dimensions.dimenisonNo5),
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  "Duration: ",
                                                                                  style: GoogleFonts.roboto(
                                                                                    color: Colors.black,
                                                                                    fontSize: Dimensions.dimenisonNo18,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    letterSpacing: 1,
                                                                                  ),
                                                                                ),
                                                                                // Display hours if greater than 0
                                                                                if (singleService.hours >= 1)
                                                                                  Text(
                                                                                    ' ${singleService.hours.toInt()}Hr ',
                                                                                    style: GoogleFonts.roboto(
                                                                                      color: AppColor.serviceTapTextColor,
                                                                                      fontSize: Dimensions.dimenisonNo18,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      letterSpacing: 1,
                                                                                    ),
                                                                                  ),
                                                                                // Display minutes
                                                                                Text(
                                                                                  "${singleService.minutes.toInt()}Min",
                                                                                  style: GoogleFonts.roboto(
                                                                                    color: Colors.black,
                                                                                    fontSize: Dimensions.dimenisonNo18,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    letterSpacing: 1,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: Dimensions.dimenisonNo5),
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  'Total Amount: ',
                                                                                  style: GoogleFonts.roboto(
                                                                                    color: Colors.black,
                                                                                    fontSize: Dimensions.dimenisonNo16,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    letterSpacing: 1,
                                                                                  ),
                                                                                ),
                                                                                Icon(
                                                                                  Icons.currency_rupee_outlined,
                                                                                  size: Dimensions.dimenisonNo16,
                                                                                ),
                                                                                Text(
                                                                                  singleService.price.toString(),
                                                                                  style: GoogleFonts.roboto(
                                                                                    color: Colors.black,
                                                                                    fontSize: Dimensions.dimenisonNo16,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    letterSpacing: 1,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                Routes.instance
                                                                    .push(
                                                                  widget: AppointmentDetailScreen(
                                                                      orderModel:
                                                                          orderModel),
                                                                  context:
                                                                      context,
                                                                );
                                                              });
                                                        },
                                                      ).toList(),
                                                    ]
                                                  : [],
                                        ));
                                  },
                                );
                              },
                            ))
                      ])))),
    ));
  }
}
