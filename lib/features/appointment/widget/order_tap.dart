import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/constants/router.dart';
import 'package:samay_mvp/features/appointment_detail/screen/appointment_detail_screen.dart';
import 'package:samay_mvp/features/appointment_detail/widget/state_text.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/models/order/user_order_model.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_chip.dart';

// ignore: must_be_immutable
class OrderTap extends StatefulWidget {
  OrderModel orderModel;
  OrderTap({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  @override
  State<OrderTap> createState() => _OrderTapState();
}

class _OrderTapState extends State<OrderTap> {
  bool isLoading = false;
  late SalonModel salonModel;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    salonModel = (await FirebaseFirestoreHelper.instance.getSalonInformation(
        widget.orderModel.adminId, widget.orderModel.vendorId))!;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: Dimensions.dimenisonNo16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ExpansionTile(
                clipBehavior: Clip.antiAlias,
                childrenPadding:
                    EdgeInsets.only(bottom: Dimensions.dimenisonNo12),
                collapsedShape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.dimenisonNo10),
                    side: const BorderSide(color: Colors.black, width: 2.3)),
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 2.3)),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Dimensions.dimenisonNo120,
                      width: Dimensions.dimenisonNo180,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.dimenisonNo10),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        salonModel.image!,
                        fit: BoxFit
                            .cover, // Change to cover for better image fit
                      ),
                    ),
                    SizedBox(width: Dimensions.dimenisonNo12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                salonModel.name,
                                style: GoogleFonts.roboto(
                                  fontSize: Dimensions.dimenisonNo20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.dimenisonNo12,
                              ),
                              if (widget.orderModel.isUpdate)
                                const CircleAvatar(
                                  radius: 6,
                                  backgroundColor: AppColor.buttonColor,
                                )
                            ],
                          ),
                          SizedBox(height: Dimensions.dimenisonNo8),
                          Text(
                            widget.orderModel.serviceDate,
                            style: GoogleFonts.roboto(
                              fontSize: Dimensions.dimenisonNo16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: Dimensions.dimenisonNo8),
                          StateText(
                            status: widget.orderModel.status,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                children: widget.orderModel.services.isNotEmpty
                    ? [
                        Divider(),
                        Text(
                          'Appointment Time: ${widget.orderModel.serviceStartTime} - ${widget.orderModel.serviceEndTime}',
                          style: GoogleFonts.roboto(
                            fontSize: Dimensions.dimenisonNo18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        // Iterate through the list of services in the order
                        ...widget.orderModel.services.map(
                          (singleService) {
                            return GestureDetector(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: Dimensions.dimenisonNo12,
                                    right: Dimensions.dimenisonNo12,
                                    top: Dimensions.dimenisonNo12,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.dimenisonNo10,
                                      horizontal: Dimensions.dimenisonNo14),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.black),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.dimenisonNo10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Service name and category
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '▪️ ${singleService.servicesName}',
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontSize: Dimensions
                                                        .dimenisonNo20,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: Dimensions
                                                        .dimenisonNo5),
                                                Text(
                                                  "Service code : ${singleService.serviceCode}",
                                                  style: TextStyle(
                                                    color: AppColor.grey,
                                                    fontSize: Dimensions
                                                        .dimenisonNo15,
                                                    fontFamily:
                                                        GoogleFonts.lato()
                                                            .fontFamily,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Displaying service category with a custom chip
                                          CustomChip(
                                              text: singleService.categoryName),
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
                                              SizedBox(
                                                  height:
                                                      Dimensions.dimenisonNo5),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Duration: ",
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.black,
                                                      fontSize: Dimensions
                                                          .dimenisonNo18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                  // Display hours if greater than 0
                                                  if (singleService.hours >= 1)
                                                    Text(
                                                      ' ${singleService.hours.toInt()}Hr ',
                                                      style: GoogleFonts.roboto(
                                                        color: AppColor
                                                            .serviceTapTextColor,
                                                        fontSize: Dimensions
                                                            .dimenisonNo18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                  // Display minutes
                                                  Text(
                                                    "${singleService.minutes.toInt()}Min",
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.black,
                                                      fontSize: Dimensions
                                                          .dimenisonNo18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height:
                                                      Dimensions.dimenisonNo5),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Total Amount: ',
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.black,
                                                      fontSize: Dimensions
                                                          .dimenisonNo16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .currency_rupee_outlined,
                                                    size: Dimensions
                                                        .dimenisonNo16,
                                                  ),
                                                  Text(
                                                    singleService.price
                                                        .toString(),
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.black,
                                                      fontSize: Dimensions
                                                          .dimenisonNo16,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                  Routes.instance.push(
                                    widget: AppointmentDetailScreen(
                                      orderModel: widget.orderModel,
                                      salonModel: salonModel,
                                    ),
                                    context: context,
                                  );
                                });
                          },
                        ).toList(),
                      ]
                    : [],
              ));
  }
}
