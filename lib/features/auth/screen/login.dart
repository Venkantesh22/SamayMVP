// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samay_mvp/constants/asset_images.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/constants/router.dart';
import 'package:samay_mvp/features/auth/screen/singin.dart';
import 'package:samay_mvp/features/home/screen/homescreen.dart';
import 'package:samay_mvp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/primary_button.dart';
import 'package:samay_mvp/widget/textformField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.authBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.dimenisonNo12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
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
                        controller: emailController,
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        obscureForPassword: false,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      SizedBox(height: Dimensions.dimenisonNo16),
                      CustomTextField(
                          prefixIcon: const Icon(Icons.password_outlined),
                          controller: passwordController,
                          hintText: "Password",
                          keyboardType: TextInputType.name,
                          obscureForPassword: true),
                      SizedBox(height: Dimensions.dimenisonNo20),
                      PrimaryButton(
                        title: "Login",
                        onPressed: () async {
                          bool isVaildated = loginVaildation(
                              emailController.text, passwordController.text);
                          if (isVaildated) {
                            bool isLogined = await FirebaseAuthHelper.instance
                                .login(emailController.text,
                                    passwordController.text, context);
                            if (isLogined) {
                              Routes.instance.pushAndRemoveUntil(
                                  widget: HomeScreen(), context: context);
                            }
                          }
                        },
                      ),
                      SizedBox(height: Dimensions.dimenisonNo30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              Routes.instance.push(
                                  widget: const SingIn(), context: context);
                            },
                            padding: EdgeInsets.zero,
                            child: Text(
                              "Don't have an account?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.dimenisonNo16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                height: 0,
                                letterSpacing: 0.15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.dimenisonNo300),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: Dimensions.dimenisonNo12,
                left: 0,
                right: 0,
                child: Container(
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
