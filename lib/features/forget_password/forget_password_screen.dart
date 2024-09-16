import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/primary_button.dart';
import 'package:samay_mvp/widget/textformField.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.authBackgroundColor,
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.dimenisonNo12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Change Password',
                  style: TextStyle(
                    color: AppColor.authTitleColor,
                    fontSize: Dimensions.dimenisonNo24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: Dimensions.dimenisonNo20),
                Text(
                  "Enter a email",
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.dimenisonNo16),
                ),
                SizedBox(height: Dimensions.dimenisonNo20),
                CustomTextField(
                    prefixIcon: const Icon(Icons.email_outlined),
                    obscureForPassword: false,
                    controller: email,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: Dimensions.dimenisonNo24),
                PrimaryButton(
                  title: "Send Email",
                  onPressed: () async {
                    String userEmail = appProvider.getUserInfornation!.email;
                    bool isVaildated = emailVaildation(
                      email.text,
                    );

                    if (isVaildated) {
                      if (userEmail == email.text.trim()) {
                        FirebaseAuthHelper.instance
                            .resetPassword(email.text.trim());
                      } else {
                        showMessage(" Invalid email.");
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
