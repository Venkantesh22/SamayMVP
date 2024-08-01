import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/utility/dimension.dart';

class CustomChip extends StatefulWidget {
  final String text;
  const CustomChip({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomChip> createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: const Color.fromARGB(255, 184, 182, 182),
      label: Text(
        widget.text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontSize: Dimensions.dimenisonNo16,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
    // Container(
    //   padding: EdgeInsets.symmetric(
    //       horizontal: Dimensions.dimenisonNo15,
    //       vertical: Dimensions.dimenisonNo5),
    //   decoration: ShapeDecoration(
    //     color: const Color.fromARGB(255, 183, 182, 182),
    //     shape: RoundedRectangleBorder(
    //       side: BorderSide(width: 2, color: Colors.black.withOpacity(0.3)),
    //       borderRadius: BorderRadius.circular(Dimensions.dimenisonNo10),
    //     ),
    //   ),
    //   child: Text(
    //     text,
    //     style: TextStyle(
    //       color: Colors.black,
    //       fontSize: Dimensions.dimenisonNo14,
    //       fontFamily: GoogleFonts.roboto().fontFamily,
    //       fontWeight: FontWeight.w600,
    //       letterSpacing: 1,
    //     ),
    //   ),
    // );
  }
}
