import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/models/order/user_order_model.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class StateText extends StatelessWidget {
  final OrderModel orderModel; // Mark orderModel as final
  StateText({
    Key? key,
    required this.orderModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if orderModel is null and handle it gracefully
    if (orderModel == null) {
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
        // reschedule state
        if (orderModel.status == "Reschedule")
          Row(
            children: [
              Text(
                orderModel.status,
                style: GoogleFonts.roboto(
                  fontSize: Dimensions.dimenisonNo16,
                  color: AppColor.buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: Dimensions.dimenisonNo10),
              Icon(
                CupertinoIcons.exclamationmark_circle,
                size: Dimensions.dimenisonNo18,
                color: AppColor.buttonColor,
              ),
            ],
          ),
        // Pending state
        if (orderModel.status == "Pending")
          Row(
            children: [
              Text(
                orderModel.status,
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
        if (orderModel.status == "Confirmed")
          Row(
            children: [
              Text(
                orderModel.status,
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
        if (orderModel.status == "Completed")
          Row(
            children: [
              Text(
                orderModel.status,
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
        if (orderModel.status == "Cancel")
          Row(
            children: [
              Text(
                orderModel.status,
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
      ],
    );
  }
}
