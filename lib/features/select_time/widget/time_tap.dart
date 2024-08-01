import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class TimeTap extends StatefulWidget {
  final SalonModel salonModel;
  const TimeTap({
    Key? key,
    required this.salonModel,
  }) : super(key: key);

  @override
  State<TimeTap> createState() => _TimeTapState();
}

class _TimeTapState extends State<TimeTap> {
  bool selectTime = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.dimenisonNo55,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectTime = !selectTime;
          });
          print(selectTime);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: Dimensions.dimenisonNo30),
          backgroundColor: selectTime
              ? AppColor.buttonColor
              : Color.fromARGB(255, 184, 182, 182),
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
          widget.salonModel.openTime,
          style: TextStyle(
            color: selectTime ? Colors.white : Colors.black,
            fontSize: Dimensions.dimenisonNo20,
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
