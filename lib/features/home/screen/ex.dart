import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/constants/global_variable.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class MyEx extends StatelessWidget {
  const MyEx({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.solidHourglassHalf,
              size: Dimensions.dimenisonNo40,
              color: AppColor.buttonColor,
            ),
            SizedBox(
              height: Dimensions.dimenisonNo20,
            ),
            Text(
              'Appointment Book Successfull',
              style: TextStyle(
                fontSize: Dimensions.dimenisonNo24,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: Dimensions.dimenisonNo16,
            ),
            Text(
              '     Your booking has been processed!\nDetails of appointment are included below',
              style: TextStyle(
                fontSize: Dimensions.dimenisonNo18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: Dimensions.dimenisonNo20,
            ),
            Text(
              'Appointment ID : ${GlobalVariable.appointmentID}',
              style: TextStyle(
                fontSize: Dimensions.dimenisonNo20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
