import 'package:flutter/material.dart';
import 'package:samay_mvp/utility/color.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const PrimaryButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.authBackgroundColor,
          disabledBackgroundColor: Colors.grey,
          side: const BorderSide(width: 2, color: Color(0xFF4CF753)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Roboto',
            letterSpacing: 1.25,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
