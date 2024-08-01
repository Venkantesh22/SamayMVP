import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class ServiceTap extends StatelessWidget {
  final String imageUrl;
  final String serviceName;
  final String serviceType;
  final String serviceAddres;
  final VoidCallback ontap;

  ServiceTap({
    Key? key,
    required this.imageUrl,
    required this.serviceName,
    required this.serviceType,
    required this.serviceAddres,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: ontap,
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.only(
            left: Dimensions.dimenisonNo10,
            right: Dimensions.dimenisonNo10,
            top: Dimensions.dimenisonNo12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: Dimensions.dimenisonNo250,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.dimenisonNo16),
                  topRight: Radius.circular(Dimensions.dimenisonNo16),
                ),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimensions.dimenisonNo12),
              // height: 200,
              width: double.infinity,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.dimenisonNo16),
                    bottomRight: Radius.circular(Dimensions.dimenisonNo16),
                  ),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x66D9D9D9),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.dimenisonNo24,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.25,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.dimenisonNo5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.dimenisonNo5),
                    child: Text(
                      serviceType,
                      style: TextStyle(
                        // color: Colors.black,
                        color: Color.fromARGB(255, 88, 87, 87),
                        fontSize: Dimensions.dimenisonNo14,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        // vertical: Dimensions.dimenisonNo5,
                        horizontal: Dimensions.dimenisonNo5),
                    child: const Divider(),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColor.mainColor,
                        size: Dimensions.dimenisonNo20,
                      ),
                      SizedBox(
                        width: Dimensions.dimenisonNo5,
                      ),
                      Expanded(
                        child: Text(
                          serviceAddres,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.dimenisonNo16,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                            letterSpacing: 0.70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
