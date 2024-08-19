import 'package:flutter/material.dart';
import 'package:samay_mvp/utility/dimension.dart';

class CustomText extends StatelessWidget {
  final String firstText;
  final String lastText;
  final bool showicon;
  final IconData? icon;

  const CustomText({
    Key? key,
    required this.firstText,
    required this.lastText,
    this.showicon = false,
    this.icon = Icons.currency_rupee_rounded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.dimenisonNo20,
          vertical: Dimensions.dimenisonNo5),
      child: Row(
        children: [
          Text(
            firstText,
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.dimenisonNo16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.80,
            ),
          ),
          Spacer(),
          if (showicon)
            Icon(icon, size: Dimensions.dimenisonNo18, color: Colors.black),
          SizedBox(
            width: Dimensions.dimenisonNo5,
          ),
          Text(
            lastText,
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.dimenisonNo16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.80,
            ),
          ),
        ],
      ),
    );
  }
}
