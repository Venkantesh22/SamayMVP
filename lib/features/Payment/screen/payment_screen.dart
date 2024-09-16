// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/constants/global_variable.dart';
import 'package:samay_mvp/constants/router.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/features/home/screen/homescreen.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/samay_fb.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_button.dart';

class PaymentMethodScreen extends StatefulWidget {
  final SalonModel salonModel;
  final String serviceDate;
  final String serviceStartTime;
  final String serviceEndTime;
  final String userNote;
  const PaymentMethodScreen({
    Key? key,
    required this.salonModel,
    required this.serviceDate,
    required this.serviceStartTime,
    required this.serviceEndTime,
    required this.userNote,
  }) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.dimenisonNo16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.dimenisonNo20),
            Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: Dimensions.dimenisonNo22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Dimensions.dimenisonNo36,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.dimenisonNo12),
                  border: Border.all(color: AppColor.buttonColor, width: 3.0)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    activeColor: AppColor.buttonColor,
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: Dimensions.dimenisonNo12,
                  ),
                  Text(
                    "PAP (Pay At Place)",
                    style: TextStyle(
                      fontSize: Dimensions.dimenisonNo18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.dimenisonNo24,
            ),
            AbsorbPointer(
              absorbing: true,
              child: Container(
                height: Dimensions.dimenisonNo80,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.dimenisonNo12),
                    border: Border.all(color: Colors.grey, width: 3.0)),
                // Border.all(color: AppColor.buttonColor, width: 3.0)),
                width: double.infinity,
                child: Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: groupValue,
                      activeColor: AppColor.buttonColor,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: Dimensions.dimenisonNo12,
                    ),
                    Text(
                      "Pay Online",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.dimenisonNo18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.dimenisonNo24,
            ),
            Text(
              'Note :',
              style: TextStyle(
                color: Colors.red,
                fontSize: Dimensions.dimenisonNo18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.90,
              ),
            ),
            Text(
              'Pay online available soon. ',
              style: TextStyle(
                color: Colors.red,
                fontSize: Dimensions.dimenisonNo16,
                letterSpacing: 0.90,
              ),
            ),
            Spacer(),
            SizedBox(
              height: Dimensions.dimenisonNo55,
              width: double.infinity,
              child: CustomButtom(
                text: "Pay & Confime",
                ontap: () async {
                  showLoaderDialog(context);

                  int appointmentNO =
                      await SamayFB.instance.incrementSalonAppointmentNo();

                  // ignore: use_build_context_synchronously
                  bool value = await FirebaseFirestoreHelper.instance
                      .uploadAppointmentInforFB(
                    appointmentNO,
                    appProvider.getWatchList,
                    appProvider.getUserInfornation!.id,
                    widget.salonModel.id,
                    widget.salonModel.adminId,
                    // widget.salonModel,
                    // appProvider.getUserInfornation!,
                    appProvider.getfinalTotal.toString(),
                    appProvider.getSubTotal.toString(),
                    GlobalVariable.salonPlatformFees.toString(),
                    groupValue == 1 ? "PAP (Pay At Place)" : "Pay Online",
                    appProvider.getServiceBookingDuration,
                    widget.serviceDate,
                    widget.serviceStartTime,
                    widget.serviceEndTime,
                    widget.userNote,
                    context,
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.of(context, rootNavigator: true).pop();
                  if (value) {
                    showLoaderDialog(context);
                    Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: SizedBox(
                                height: Dimensions.dimenisonNo250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: Dimensions.dimenisonNo12,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.solidHourglassHalf,
                                      size: Dimensions.dimenisonNo40,
                                      color: AppColor.buttonColor,
                                    ),
                                    SizedBox(
                                      height: Dimensions.dimenisonNo20,
                                    ),
                                    Text(
                                      'Appointment Book Successfull',
                                      style: TextStyle(
                                        fontSize: Dimensions.dimenisonNo18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.dimenisonNo16,
                                    ),
                                    Text(
                                      '     Your booking has been processed!\nDetails of appointment are included below',
                                      style: TextStyle(
                                        fontSize: Dimensions.dimenisonNo16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.dimenisonNo20,
                                    ),
                                    Text(
                                      'Appointment ID : ${GlobalVariable.appointmentID}',
                                      style: TextStyle(
                                        fontSize: Dimensions.dimenisonNo14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Appointment No : ${GlobalVariable.appointmentNO}',
                                      style: TextStyle(
                                        fontSize: Dimensions.dimenisonNo14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Routes.instance.push(
                                        widget: const HomeScreen(),
                                        context: context);
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.dimenisonNo18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                    Navigator.of(context, rootNavigator: true).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
