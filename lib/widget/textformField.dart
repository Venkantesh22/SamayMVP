// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureForPassword = false;
  final TextInputType keyboardType;
  final Icon prefixIcon;

  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureForPassword,
    required this.keyboardType,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureForPassword,
      style: const TextStyle(fontSize: 18, color: Colors.white),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        suffixIcon: widget.hintText == "Password"
            ? InkWell(
                onTap: () {
                  setState(() {
                    widget.obscureForPassword = !widget.obscureForPassword;
                  });
                },
                child: Icon(widget.obscureForPassword
                    ? Icons.visibility
                    : Icons.visibility_off),
              )
            : null,
        prefixIcon: widget.prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: const Color(0xFF959595),
          fontSize: 14,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w400,
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        return null;
      },
    );
  }
}
