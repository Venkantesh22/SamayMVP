import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/features/vender_profile/screen/vender_service_screen.dart';
import 'package:samay_mvp/features/vender_profile/widgets/address.dart';
import 'package:samay_mvp/features/vender_profile/widgets/contactus_social_media.dart';
import 'package:samay_mvp/features/vender_profile/widgets/row_of_day_time.dart';
import 'package:samay_mvp/features/vender_profile/widgets/two_button.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/custom_chip.dart';

class WinderProfileScreen extends StatefulWidget {
  final SalonModel salonModel;
  const WinderProfileScreen({
    Key? key,
    required this.salonModel,
  }) : super(key: key);

  @override
  State<WinderProfileScreen> createState() => _WinderProfileScreenState();
}

class _WinderProfileScreenState extends State<WinderProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  void getSalon() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    appProvider.getSalonInfoFirebasePro(
        widget.salonModel.adminId, widget.salonModel.id);
    setState(() {
      isLoading = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getSalon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
        // backgroundColor: const Color(0xFFF3F3F3),
        key: _scaffoldKey,
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        drawer: const CustomDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Salon Image
                Center(
                  child: Container(
                    height: Dimensions.dimenisonNo250,
                    width: double.infinity,
                    // ignore: prefer_const_constructors
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.salonModel.image!,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          BorderRadius.circular(Dimensions.dimenisonNo10),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.dimenisonNo16),

                // Salon Name
                Container(
                    width: double.infinity,
                    height: Dimensions.dimenisonNo60,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.dimenisonNo10),
                      ),
                      shadows: [
                        BoxShadow(
                          color: const Color(0x3F000000),
                          blurRadius: Dimensions.dimenisonNo10,
                          offset: const Offset(0, -1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        widget.salonModel.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.dimenisonNo24,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.25,
                        ),
                      ),
                    )),
                SizedBox(height: Dimensions.dimenisonNo16),

                // Buttons: Details and Services
                TwoButton(
                  detailBgColor: AppColor.buttonColor,
                  detailTextColor: Colors.white,
                  serviceBgColor: Colors.white,
                  serviceTextColor: AppColor.buttonColor,
                  detailOnTap: () {},
                  serviceOnTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            WinderServiceScreen(
                          salonModel: widget.salonModel,
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return child; // No animation transition
                        },
                      ),
                    );
                  },
                ),

                SizedBox(
                  height: Dimensions.dimenisonNo16,
                ),
                // Salon Type
                CustomChip(text: widget.salonModel.salonType),
                // Chip(text: widget.salonModel.salonType),
                // Container(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: Dimensions.dimenisonNo15,
                //       vertical: Dimensions.dimenisonNo5),
                //   decoration: ShapeDecoration(
                //     color: const Color(0xFFEEEFF3),
                //     shape: RoundedRectangleBorder(
                //       side: BorderSide(
                //           width: 2, color: Colors.black.withOpacity(0.3)),
                //       borderRadius:
                //           BorderRadius.circular(Dimensions.dimenisonNo10),
                //     ),
                //   ),
                //   child: Text(
                //     widget.salonModel.salonType,
                //     style: TextStyle(
                //       color: const Color(0xFF454545),
                //       fontSize: Dimensions.dimenisonNo12,
                //       fontFamily: GoogleFonts.roboto().fontFamily,
                //       fontWeight: FontWeight.bold,
                //       letterSpacing: 1,
                //     ),
                //   ),
                // ),

                // Description
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo15),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.dimenisonNo22,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                // Description text.
                Text(
                  widget.salonModel.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.dimenisonNo15,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    letterSpacing: .90,
                  ),
                ),
                SizedBox(height: Dimensions.dimenisonNo16),

                // Weekday schedule.
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo16),
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.dimenisonNo10),
                    ),
                    shadows: [
                      BoxShadow(
                        color: const Color(0x3F000000),
                        blurRadius: Dimensions.dimenisonNo10,
                        offset: const Offset(0, -1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(Dimensions.dimenisonNo16),
                        child: Text(
                          'TIMING',
                          style: TextStyle(
                            color: Colors.black,
                            // color: const Color(0xFF454545),
                            fontSize: Dimensions.dimenisonNo20,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      RowOfDayAndTime(
                          day: "Sunday",
                          openAndCloseTime: widget.salonModel.monday!),
                      RowOfDayAndTime(
                          day: "Tuesday",
                          openAndCloseTime: widget.salonModel.tuesday!),
                      RowOfDayAndTime(
                          day: "Wednesday",
                          openAndCloseTime: widget.salonModel.wednesday!),
                      RowOfDayAndTime(
                          day: "Thursday",
                          openAndCloseTime: widget.salonModel.thursday!),
                      RowOfDayAndTime(
                          day: "Friday",
                          openAndCloseTime: widget.salonModel.friday!),
                      RowOfDayAndTime(
                          day: "Saturday",
                          openAndCloseTime: widget.salonModel.saturday!),
                      RowOfDayAndTime(
                          day: "Sunday",
                          openAndCloseTime: widget.salonModel.sunday!),
                    ],
                  ),
                ),

                // Contact Us and Social Media Information
                ContactUsAndSocialMedia(
                  salonModel: widget.salonModel,
                ),

                SizedBox(height: Dimensions.dimenisonNo20),

                // Address and  View Map Information

                Address(
                  address: widget.salonModel.address,
                  salonModel: widget.salonModel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
