import 'package:flutter/material.dart';
import 'package:samay_mvp/constants/router.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/features/winder_profile/screen/winder_profile_screen.dart';
import 'package:samay_mvp/features/home/widget/service_tap.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<SalonModel> salonModelList = [];
  bool isLoading = false;
  void getData() async {
    setState(() {
      isLoading = true;
    });
    salonModelList = await FirebaseFirestoreHelper.instance.getSalonListFB();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFF3F3F3),
          key: _scaffoldKey,
          appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
          drawer: const CustomDrawer(),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: salonModelList.length,
                  itemBuilder: (context, index) {
                    SalonModel salonModel = salonModelList[index];
                    return ServiceTap(
                        ontap: () {
                          Routes.instance.push(
                              widget:
                                  WinderProfileScreen(salonModel: salonModel),
                              context: context);
                        },
                        imageUrl: salonModel.image!,
                        serviceName: salonModel.name,
                        serviceType: salonModel.salonType,
                        serviceAddres: salonModel.address);
                  })),
    );
  }
}
