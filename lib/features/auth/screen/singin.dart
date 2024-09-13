// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/constants/asset_images.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/constants/router.dart';
import 'package:samay_mvp/features/auth/screen/login.dart';
import 'package:samay_mvp/features/home/screen/homescreen.dart';
import 'package:samay_mvp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/primary_button.dart';
import 'package:samay_mvp/widget/textformField.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void dispose() {
    password.dispose();
    email.dispose();
    name.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(Dimensions.dimenisonNo12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Create an Account',
                      style: TextStyle(
                        color: AppColor.authTitleColor,
                        fontSize: Dimensions.dimenisonNo24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: Dimensions.dimenisonNo20),
                    Image.asset(
                      AssetsImages.instance.logoImage,
                      width: Dimensions.dimenisonNo100,
                      height: Dimensions.dimenisonNo100,
                    ),
                    SizedBox(height: Dimensions.dimenisonNo20),
                    CustomTextField(
                        prefixIcon: const Icon(Icons.person_outline),
                        obscureForPassword: false,
                        controller: name,
                        hintText: "Name",
                        keyboardType: TextInputType.name),
                    SizedBox(height: Dimensions.dimenisonNo16),
                    CustomTextField(
                        prefixIcon: const Icon(Icons.email_outlined),
                        obscureForPassword: false,
                        controller: email,
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress),
                    SizedBox(height: Dimensions.dimenisonNo16),
                    CustomTextField(
                        prefixIcon: const Icon(Icons.phone_outlined),
                        obscureForPassword: false,
                        controller: phone,
                        hintText: "Phone No",
                        keyboardType: TextInputType.number),
                    SizedBox(height: Dimensions.dimenisonNo16),
                    CustomTextField(
                        prefixIcon: const Icon(Icons.password_outlined),
                        obscureForPassword: true,
                        controller: password,
                        hintText: "Password",
                        keyboardType: TextInputType.name),
                    SizedBox(height: Dimensions.dimenisonNo16),
                    PrimaryButton(
                        title: "Create Account",
                        onPressed: () async {
                          bool isVaildated = signUpVaildation(
                              email.text, password.text, name.text, phone.text);
                          if (isVaildated) {
                            bool isLogined = await FirebaseAuthHelper.instance
                                .signUp(
                                    name.text.trim(),
                                    email.text.trim(),
                                    password.text.trim(),
                                    phone.text.trim(),
                                    context);

                            if (isLogined) {
                              Routes.instance.pushAndRemoveUntil(
                                  widget: HomeScreen(), context: context);
                            }
                          }
                        }),
                    SizedBox(height: Dimensions.dimenisonNo20),
                    CupertinoButton(
                      onPressed: () {
                        print("hight : ${Dimensions.screenHeight}");
                        print("Width : ${Dimensions.screenWidth}");
                        Routes.instance.push(
                            widget: const LoginScreen(), context: context);
                      },
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Alread have an account? Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.dimenisonNo16,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          height: 0,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.dimenisonNo100),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 1,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(bottom: Dimensions.dimenisonNo12),
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: AppColor.authBackgroundColor,
                  child: Text(
                    'Main hu Samay, mere Sath chalo.!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.dimenisonNo12,
                      fontFamily: 'Inknut Antiqua',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.15,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
