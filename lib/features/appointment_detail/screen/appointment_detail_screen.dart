import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/constants/global_variable.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/appointment_detail/widget/custom_text.dart';
import 'package:samay_mvp/features/appointment_detail/widget/state_text.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/models/order/user_order_model.dart';
import 'package:samay_mvp/models/timestamped_model/date_time_model.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_chip.dart';
import 'package:samay_mvp/widget/dotted_line.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final OrderModel orderModel;
  const AppointmentDetailScreen({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.dimenisonNo16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Appointment ID\n${widget.orderModel.orderId}',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: Dimensions.dimenisonNo16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.dimenisonNo5,
                        ),
                        Text(
                          'Appointment NO : 000${widget.orderModel.appointmentNo}',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: Dimensions.dimenisonNo16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  widget.orderModel.status != "Completed"
                      ? Opacity(
                          opacity: widget.orderModel.status == "(Cancel)"
                              ? 0.5
                              : 1.0,
                          child: IgnorePointer(
                            ignoring: widget.orderModel.status == "(Cancel)",
                            child: IconButton(
                              onPressed: () {
                                showDeleteAlertDialog(
                                    context,
                                    "Cancel Appointment",
                                    "Do you want Cancel Appointment", () {
                                  try {
                                    showLoaderDialog(context);
                                    //create emptye list of timeDateList and add currently time for update
                                    List<TimeDateModel> timeDateList = [];
                                    timeDateList
                                        .addAll(widget.orderModel.timeDateList);
                                    TimeDateModel timeDateModel = TimeDateModel(
                                        id: widget.orderModel.orderId,
                                        date: GlobalVariable.getCurrentDate(),
                                        time: GlobalVariable.getCurrentTime(),
                                        updateBy:
                                            "${widget.orderModel.userModel.name} (Cancel the Appointment)");
                                    timeDateList.add(timeDateModel);
                                    OrderModel orderUpdate = widget.orderModel
                                        .copyWith(
                                            status: "(Cancel)",
                                            timeDateList: timeDateList);

                                    FirebaseFirestoreHelper.instance
                                        .updateAppointmentFB(
                                            widget.orderModel.userModel.id,
                                            widget.orderModel.orderId,
                                            orderUpdate);

                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    Navigator.of(context).pop();
                                    showMessage(
                                        "Appointment has been cancelled ");
                                  } catch (e) {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    showMessage(
                                        "Error : Appointment is not cancelled ");
                                    print("Error : $e ");
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: AppColor.pendingColor,
                                size: Dimensions.dimenisonNo40,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo8),
                child: Divider(),
              ),
              Row(
                children: [
                  Text(
                    'Appointment Details',
                    style: TextStyle(
                      fontSize: Dimensions.dimenisonNo18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  StateText(status: widget.orderModel.status),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.dimenisonNo5),
                  CustomText(
                    firstText: "Appointment Date:",
                    lastText: widget.orderModel.serviceDate,
                    // showicon: true,
                    // icon: Icons.watch_later_outlined,
                  ),
                  SizedBox(height: Dimensions.dimenisonNo5),
                  CustomText(
                    firstText: "Appointment Start Time:",
                    lastText: widget.orderModel.serviceStartTime,
                    // showicon: true,
                    // icon: Icons.watch_later_outlined,
                  ),
                  SizedBox(height: Dimensions.dimenisonNo5),
                  CustomText(
                    firstText: "Appointment End Time:",
                    lastText: widget.orderModel.serviceEndTime,
                    // showicon: true,
                    // icon: Icons.watch_later_outlined,
                  ),
                  SizedBox(height: Dimensions.dimenisonNo5),
                  CustomText(
                    firstText: "Appointment Duration:",
                    lastText: widget.orderModel.serviceDuration,
                    // showicon: true,
                    // icon: Icons.watch_later_outlined,
                  ),
                  SizedBox(height: Dimensions.dimenisonNo5),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo8),
                child: Divider(),
              ),
              Text(
                'Note',
                style: TextStyle(
                  fontSize: Dimensions.dimenisonNo18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: Dimensions.dimenisonNo16),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Dimensions.dimenisonNo10),
                child: Text(
                  widget.orderModel.userNote.length > 2
                      ? widget.orderModel.userNote
                      : "No user note",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.dimenisonNo16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.80,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo8),
                child: Divider(),
              ),
              Text(
                'Service List',
                style: TextStyle(
                  fontSize: Dimensions.dimenisonNo18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ...widget.orderModel.services.map(
                (singleService) {
                  return Container(
                    margin: EdgeInsets.only(top: Dimensions.dimenisonNo12),
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.dimenisonNo10,
                        horizontal: Dimensions.dimenisonNo14),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius:
                          BorderRadius.circular(Dimensions.dimenisonNo10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '▪️ ${singleService.servicesName}',
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: Dimensions.dimenisonNo20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.dimenisonNo5),
                                  Text(
                                    "Service code : ${singleService.serviceCode}",
                                    style: TextStyle(
                                      color: AppColor.grey,
                                      fontSize: Dimensions.dimenisonNo15,
                                      fontFamily: GoogleFonts.lato().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CustomChip(text: singleService.categoryName),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                  );
                },
              ).toList(),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo8),
                child: Divider(),
              ),
              Text(
                'Payment Details',
                style: TextStyle(
                  fontSize: Dimensions.dimenisonNo18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.dimenisonNo5),
                  CustomText(
                    firstText: "Payment Method:",
                    lastText: widget.orderModel.payment,
                  ),
                  SizedBox(height: Dimensions.dimenisonNo5),
                  CustomText(
                    firstText: "Subtotal:",
                    lastText: widget.orderModel.subtatal,
                    showicon: true,
                  ),
                  SizedBox(height: Dimensions.dimenisonNo5),
                  CustomText(
                    firstText: "Platform fees",
                    lastText: widget.orderModel.platformFees,
                    showicon: true,
                  ),
                  SizedBox(height: Dimensions.dimenisonNo5),
                  CustomText(
                    firstText: "Total:",
                    lastText: widget.orderModel.totalPrice,
                    showicon: true,
                  ),
                  SizedBox(height: Dimensions.dimenisonNo20),
                  SizedBox(height: Dimensions.dimenisonNo10),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo8),
                    child: CustomDotttedLine(),
                  ),
                  Text(
                    'Salon Details',
                    style: TextStyle(
                      fontSize: Dimensions.dimenisonNo18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Dimensions.dimenisonNo10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Dimensions.dimenisonNo70,
                        width: Dimensions.dimenisonNo120,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.dimenisonNo10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          widget.orderModel.salonModel.image!,
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
                              widget.orderModel.salonModel.name,
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
                                widget.orderModel.salonModel.salonType,
                                style: TextStyle(
                                  // color: Colors.black,
                                  color: Color.fromARGB(255, 88, 87, 87),
                                  fontSize: Dimensions.dimenisonNo14,
                                  fontFamily: GoogleFonts.roboto().fontFamily,
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
                          widget.orderModel.salonModel.address,
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo8),
                    child: const CustomDotttedLine(),
                  ),
                  Text(
                    'Booking Details',
                    style: TextStyle(
                      fontSize: Dimensions.dimenisonNo18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Dimensions.dimenisonNo10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.orderModel.timeDateList.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Display the first element separately
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Book on  ${widget.orderModel.timeDateList[0].date}  at  ${widget.orderModel.timeDateList[0].time} by ${widget.orderModel.userModel.name}",
                              // style:
                              //     TextStyle(fontSize: Dimensions.dimenisonNo12),
                            ),
                            // Display all remaining elements
                            SizedBox(
                              height: 4,
                            ),
                            if (widget.orderModel.timeDateList.length > 1)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...widget.orderModel.timeDateList
                                      .sublist(1)
                                      .map(
                                    (singleTimeDate) {
                                      return Text(
                                        "update on ${singleTimeDate.date} at ${singleTimeDate.time} by ${singleTimeDate.updateBy}",
                                      );
                                    },
                                  ),
                                ],
                              ),
                          ],
                        );
                      } else {
                        // Returning an empty container to avoid redundant data (first element)
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
