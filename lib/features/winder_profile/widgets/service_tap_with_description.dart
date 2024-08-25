import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_button.dart';
import 'package:samay_mvp/widget/dotted_line.dart';

class ServiceTapWithDescription extends StatefulWidget {
  final ServiceModel serviceModel;
  final bool isAdd;
  const ServiceTapWithDescription({
    Key? key,
    required this.serviceModel,
    required this.isAdd,
  }) : super(key: key);

  @override
  State<ServiceTapWithDescription> createState() =>
      _ServiceTapWithDescriptionState();
}

class _ServiceTapWithDescriptionState extends State<ServiceTapWithDescription> {
  List<ServiceModel> serviceList = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  void getDate() {
    setState(() {
      _isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    serviceList.addAll(appProvider.getWatchList);
    print("appProvider.getWatchList ${appProvider.getWatchList.length}");
    print("serviceList ${serviceList.length}");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.serviceModel.servicesName,
                style: TextStyle(
                  color: AppColor.serviceTapTextColor,
                  fontSize: Dimensions.dimenisonNo24,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: Dimensions.dimenisonNo5),
              Text(
                "Service code : ${widget.serviceModel.serviceCode}",
                style: TextStyle(
                  color: AppColor.grey,
                  fontSize: Dimensions.dimenisonNo15,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: Dimensions.dimenisonNo10),
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: Dimensions.dimenisonNo22,
                    color: Colors.black,
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
                      : const SizedBox(),
                  Text(
                    ' ${widget.serviceModel.minutes.toInt()}Min',
                    style: TextStyle(
                      color: AppColor.serviceTapTextColor,
                      fontSize: Dimensions.dimenisonNo18,
                      fontFamily: GoogleFonts.roboto().fontFamily,
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
                    ' ${widget.serviceModel.price}',
                    style: TextStyle(
                      color: AppColor.serviceTapTextColor,
                      fontSize: Dimensions.dimenisonNo18,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  CustomButtom(
                    text: widget.isAdd ? "Remove -" : "Add+",
                    ontap: () {
                      if (widget.isAdd) {
                        appProvider
                            .removeServiceToWatchList(widget.serviceModel);
                      } else {
                        appProvider.addServiceToWatchList(widget.serviceModel);
                      }
                      appProvider.calculateSubTotal();
                      appProvider.calculateTotalBookingDuration();
                    },
                  )

                  // CustomButtom(
                  //   text: widget.isAdd ? "remove -" : "Add+",
                  //   ontap: () {
                  //     setState(() {
                  //       appProvider.addServiceToWatchList(widget.serviceModel);
                  //     });
                  //     appProvider.calculateSubTotal();
                  //     appProvider.calculateTotalBookingDuration();
                  //     setState(() {
                  //       serviceList.add(widget.serviceModel);
                  //     });
                  //   },
                  // ),
                ],
              ),
              SizedBox(height: Dimensions.dimenisonNo16),
              Text(
                widget.serviceModel.description,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.dimenisonNo16,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: Dimensions.dimenisonNo16),
            ],
          ),
        ),
      ],
    );
  }
}
