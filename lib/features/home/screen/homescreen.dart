import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/constants/router.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/features/vender_profile/screen/vender_profile_screen.dart';
import 'package:samay_mvp/features/home/widget/service_tap.dart';
import 'package:samay_mvp/firebase_helper/firebase_firestorehelper/firebase_firestorehelper.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:samay_mvp/utility/dimension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<SalonModel> salonModelList = [];
  bool isLoading = false;
  bool isConnectedToInternet = false;
  StreamSubscription? _internetConnectionStreamSubscription;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    salonModelList = await FirebaseFirestoreHelper.instance.getSalonListFB();
    appProvider.getUserInfoFirebasePro();
    appProvider.getWatchList.clear();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    checkInternteConnection();
    super.initState();
  }

  void checkInternteConnection() {
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      print(event);
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          break;

        default:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
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
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: salonModelList.length,
                      itemBuilder: (context, index) {
                        SalonModel salonModel = salonModelList[index];
                        return ServiceTap(
                            ontap: () {
                              Routes.instance.push(
                                  widget: WinderProfileScreen(
                                      salonModel: salonModel),
                                  context: context);
                            },
                            imageUrl: salonModel.image!,
                            serviceName: salonModel.name,
                            serviceType: salonModel.salonType,
                            serviceAddres: salonModel.address);
                      },
                    ),
                    SizedBox(
                      height: Dimensions.dimenisonNo12,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
