import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/firebase_helper/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:samay_mvp/models/user_model/user_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:samay_mvp/widget/primary_button.dart';
import 'package:samay_mvp/widget/textformField.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  File? _selectedImage;

  bool isLoading = false;
  late UserModel userModel;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebasePro();
    userModel = appProvider.getUserInfornation!;
    password.text = userModel.password;
    email.text = userModel.email;
    name.text = userModel.name;
    phone.text = userModel.phone.toString();
    setState(() {
      isLoading = false;
    });
  }

  final ImagePicker _picker = ImagePicker();

  // Future<void> _pickImage() async {
  //   final XFile? pickedFile =
  //       await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _selectedImage = File(pickedFile.path);
  //     });
  //   }
  // }

  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

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
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: AppColor.authBackgroundColor,
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.dimenisonNo12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'PROFILE',
                        style: TextStyle(
                          color: AppColor.authTitleColor,
                          fontSize: Dimensions.dimenisonNo24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: Dimensions.dimenisonNo20),

                      image == null
                          ? CupertinoButton(
                              onPressed: () {
                                takePicture();
                              },
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage: image != null
                                    ? FileImage(image!) as ImageProvider
                                    : NetworkImage(userModel.image),
                                child: image == null && userModel.image.isEmpty
                                    ? const Icon(Icons.person,
                                        color: Colors.red, size: 50)
                                    : null,
                              ),
                            )
                          : CupertinoButton(
                              onPressed: () {
                                takePicture();
                              },
                              child: CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 55,
                              ),
                            ),
                      SizedBox(height: Dimensions.dimenisonNo20),
                      CustomTextField(
                          prefixIcon: const Icon(Icons.person_outline),
                          obscureForPassword: false,
                          controller: name,
                          hintText: "Name",
                          keyboardType: TextInputType.name),
                      SizedBox(height: Dimensions.dimenisonNo16),
                      // CustomTextField(
                      //     prefixIcon: const Icon(Icons.email_outlined),
                      //     obscureForPassword: false,
                      //     controller: email,
                      //     hintText: "Email",
                      //     readOnly: true,
                      //     keyboardType: TextInputType.emailAddress),
                      // SizedBox(height: Dimensions.dimenisonNo16),
                      CustomTextField(
                          prefixIcon: const Icon(Icons.phone_outlined),
                          obscureForPassword: false,
                          controller: phone,
                          hintText: "Phone No",
                          keyboardType: TextInputType.number),
                      SizedBox(height: Dimensions.dimenisonNo16),
                      // CustomTextField(
                      //     prefixIcon: const Icon(Icons.password_outlined),
                      //     obscureForPassword: true,
                      //     controller: password,
                      //     hintText: "Password",
                      //     readOnly: true,
                      //     keyboardType: TextInputType.name),
                      // SizedBox(height: Dimensions.dimenisonNo16),
                      PrimaryButton(
                        title: "Update",
                        onPressed: () async {
                          bool isVaildated =
                              updateProfileVaildation(name.text, phone.text);

                          if (isVaildated) {
                            UserModel userModel =
                                appProvider.getUserInfornation!.copyWith(
                              name: name.text.trim(),
                              phone: phone.text.trim(),
                            );
                            appProvider.updateUserInfoFirebase(
                                context, userModel, image);
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
