import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class Address extends StatelessWidget {
  final String address;
  final SalonModel salonModel;
  const Address({
    Key? key,
    required this.address,
    required this.salonModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Method to open GoogleMap
    Future<void> _openGoogleMap(String url) async {
      try {
        await launchUrl(Uri.parse(url));
      } catch (e) {
        showMessage('GoogleMap is not available');
      }
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.black,
              size: Dimensions.dimenisonNo30,
            ),
            SizedBox(width: Dimensions.dimenisonNo10),
            Expanded(
              child: Text(
                "${salonModel.address} ${salonModel.city} ${salonModel.pinCode.toString()} ${salonModel.state}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.dimenisonNo14,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: Dimensions.dimenisonNo14),
        if (salonModel.googleMap!.isNotEmpty)
          Center(
            child: TextButton(
              onPressed: () {
                _openGoogleMap(salonModel.googleMap.toString());
              },
              child: Text(
                'View on Map',
                style: TextStyle(
                  color: AppColor.buttonColor,
                  fontSize: Dimensions.dimenisonNo16,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontWeight: FontWeight.bold,
                  height: 0,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
