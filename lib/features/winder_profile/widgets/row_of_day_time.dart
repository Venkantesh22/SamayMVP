import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:samay_mvp/utility/dimension.dart';

class RowOfDayAndTime extends StatelessWidget {
  final String day;
  final String openAndCloseTime;
  const RowOfDayAndTime({
    Key? key,
    required this.day,
    required this.openAndCloseTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          Dimensions.dimenisonNo20,
          Dimensions.dimenisonNo5,
          Dimensions.dimenisonNo20,
          Dimensions.dimenisonNo20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                day,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.dimenisonNo16,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFFEEEFF3),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.dimenisonNo16),
                    child: Text(
                      openAndCloseTime,
                      style: TextStyle(
                        color: const Color(0xFF454545),
                        // color: Colors.black,
                        fontSize: Dimensions.dimenisonNo16,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.80,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo10),
            child: Divider(),
          )
        ],
      ),
    );
  }
}

// class RowOfDayAndTime extends StatelessWidget {
//   final String day;
//   final String openAndCloseTime;
//   const RowOfDayAndTime({Key? key, required this.day, required this.openAndCloseTime}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(
//           Dimensions.dimenisonNo20,
//           Dimensions.dimenisonNo5,
//           Dimensions.dimenisonNo20,
//           Dimensions.dimenisonNo20),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(
//                 day,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: Dimensions.dimenisonNo16,
//                   fontFamily: GoogleFonts.roboto().fontFamily,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.02,
//                 ),
//               ),
//               const Spacer(),
//               Container(
//                 decoration: ShapeDecoration(
//                   color: const Color(0xFFEEEFF3),
//                   shape: RoundedRectangleBorder(
//                     side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
//                     borderRadius: BorderRadius.circular(9),
//                   ),
//                 ),
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.all(Dimensions.dimenisonNo16),
//                     child: Text(
//                      openAndCloseTime,
//                       style: TextStyle(
//                         color: const Color(0xFF454545),
//                         fontSize: Dimensions.dimenisonNo16,
//                         fontFamily: GoogleFonts.roboto().fontFamily,
//                         fontWeight: FontWeight.w400,
//                         height: 0,
//                         letterSpacing: -0.36,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo10),
//             child: Divider(),
//           )
//         ],
//       ),
//     );
//   }
// }

