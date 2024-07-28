import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class CustomButtom extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const CustomButtom({
    Key? key,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.dimenisonNo55,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: Dimensions.dimenisonNo30),
          backgroundColor: AppColor.buttonColor,
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
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.dimenisonNo20,
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.25,
          ),
        ),
      ),
    );
  }
}
