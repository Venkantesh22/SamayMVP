import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class TwoButton extends StatelessWidget {
  final VoidCallback detailOnTap;
  final VoidCallback serviceOnTap;
  final Color detailBgColor;
  final Color detailTextColor;
  final Color serviceBgColor;
  final Color serviceTextColor;
  const TwoButton({
    Key? key,
    required this.detailOnTap,
    required this.serviceOnTap,
    required this.detailBgColor,
    required this.detailTextColor,
    required this.serviceBgColor,
    required this.serviceTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: Dimensions.dimenisonNo55,
            child: ElevatedButton(
              onPressed: detailOnTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: detailBgColor,
                foregroundColor: Colors.white,
                // Text color
                side: const BorderSide(
                  width: 3,
                  color: Color(0x3F000000),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Details',
                style: TextStyle(
                  color: detailTextColor,
                  fontSize: Dimensions.dimenisonNo20,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.25,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: Dimensions.dimenisonNo16),
        Expanded(
          child: SizedBox(
            height: Dimensions.dimenisonNo55,
            child: ElevatedButton(
              onPressed: serviceOnTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: serviceBgColor, // Background color
                foregroundColor: AppColor.buttonColor, // Text color
                side: const BorderSide(
                  width: 3,
                  color: Color(0x3F000000),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Services',
                style: TextStyle(
                  color: serviceTextColor,
                  fontSize: Dimensions.dimenisonNo20,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
