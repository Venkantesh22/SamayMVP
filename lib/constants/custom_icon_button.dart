// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:samay_mvp/utility/dimension.dart';

class CustomIconButton extends StatelessWidget {
  IconData? icon;
  VoidCallback? ontap;

  CustomIconButton({
    Key? key,
    this.icon,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
        icon,
        size: Dimensions.dimenisonNo36,
        color: Colors.black,
      ), // Replace with Instagram icon
      onPressed: ontap,
    );
  }
}
