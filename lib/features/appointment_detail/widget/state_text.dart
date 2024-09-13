import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class StateText extends StatelessWidget {
  final String status; // Mark orderModel as final
  StateText({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if orderModel is null and handle it gracefully
    if (status == null) {
      return Text(
        'Status not available',
        style: GoogleFonts.roboto(
          fontSize: Dimensions.dimenisonNo16,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Column(
      children: [
        // (Update) state
        if (status == "(Update)")
          Text(
            status,
            style: GoogleFonts.roboto(
                fontSize: Dimensions.dimenisonNo16,
                color: AppColor.buttonColor,
                fontWeight: FontWeight.w500,
                letterSpacing: .90),
          ),
        // Pending state
        if (status == "Pending")
          Row(
            children: [
              Text(
                status,
                style: GoogleFonts.roboto(
                  fontSize: Dimensions.dimenisonNo16,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: Dimensions.dimenisonNo10),
              Icon(
                CupertinoIcons.exclamationmark_circle,
                size: Dimensions.dimenisonNo18,
                color: Colors.red,
              ),
            ],
          ),
        // Confirmed state
        if (status == "Confirmed")
          Row(
            children: [
              Text(
                status,
                style: GoogleFonts.roboto(
                  fontSize: Dimensions.dimenisonNo16,
                  color: AppColor.buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: Dimensions.dimenisonNo10),
              Icon(
                CupertinoIcons.checkmark_alt_circle,
                size: Dimensions.dimenisonNo18,
                color: AppColor.buttonColor,
              ),
            ],
          ),
        // Completed state
        if (status == "Completed")
          Row(
            children: [
              Text(
                status,
                style: GoogleFonts.roboto(
                  fontSize: Dimensions.dimenisonNo16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: Dimensions.dimenisonNo10),
              Icon(
                CupertinoIcons.checkmark_alt_circle,
                size: Dimensions.dimenisonNo18,
                color: Colors.blue,
              ),
            ],
          ),
        // Cancel state
        if (status == "(Cancel)")
          Row(
            children: [
              Text(
                status,
                style: GoogleFonts.roboto(
                  fontSize: Dimensions.dimenisonNo16,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: Dimensions.dimenisonNo10),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.red),
                ),
                child: Icon(
                  Icons.close,
                  size: Dimensions.dimenisonNo16,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        if (status == "InProcces")
          Row(
            children: [
              Text(
                status,
                style: GoogleFonts.roboto(
                  fontSize: Dimensions.dimenisonNo16,
                  color: AppColor.buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: Dimensions.dimenisonNo10),
              Icon(
                FontAwesomeIcons.scissors,
                size: Dimensions.dimenisonNo14,
                color: AppColor.buttonColor,
              ),
            ],
          ),
      ],
    );
  }
}
