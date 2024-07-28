import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/features/winder_profile/screen/winder_profile_screen.dart';
import 'package:samay_mvp/features/winder_profile/widgets/category_tap.dart';
import 'package:samay_mvp/features/winder_profile/widgets/two_button.dart';
import 'package:samay_mvp/models/category_model/category_model.dart';
import 'package:samay_mvp/models/salon_form_models/salon_infor_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class WinderServiceScreen extends StatefulWidget {
  final SalonModel salonModel;
  const WinderServiceScreen({
    Key? key,
    required this.salonModel,
  }) : super(key: key);

  @override
  State<WinderServiceScreen> createState() => _WinderServiceScreenState();
}

class _WinderServiceScreenState extends State<WinderServiceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  void getWinderData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.callBackFunctionWinder(
      widget.salonModel.id,
      widget.salonModel.adminId,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getWinderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
        drawer: const CustomDrawer(),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.dimenisonNo16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.dimenisonNo16),
                              height: Dimensions.dimenisonNo250,
                              width: double.infinity,
                              // ignore: prefer_const_constructors
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    widget.salonModel.image!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.dimenisonNo10),
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.dimenisonNo16),
                          // Salon Name
                          Container(
                            width: double.infinity,
                            height: Dimensions.dimenisonNo60,
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.dimenisonNo16),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.dimenisonNo10),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: const Color(0x3F000000),
                                  blurRadius: Dimensions.dimenisonNo10,
                                  offset: const Offset(0, -1),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                widget.salonModel.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.dimenisonNo24,
                                  fontFamily: GoogleFonts.roboto().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.25,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.dimenisonNo16),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.dimenisonNo16),
                            child: TwoButton(
                              detailBgColor: Colors.white,
                              detailTextColor: AppColor.buttonColor,
                              serviceBgColor: AppColor.buttonColor,
                              serviceTextColor: Colors.white,
                              detailOnTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        WinderProfileScreen(
                                      salonModel: widget.salonModel,
                                    ),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return child; // No animation transition
                                    },
                                  ),
                                );
                              },
                              serviceOnTap: () {},
                            ),
                          ),
                          SizedBox(height: Dimensions.dimenisonNo12),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        CategoryModel categoryModel =
                            appProvider.getcategoryList[index];
                        return CategoryTap(
                          categoryModel: categoryModel,
                          salonModel: widget.salonModel,
                        );
                      },
                      childCount: appProvider.getcategoryList.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
// class _WinderServiceScreenState extends State<WinderServiceScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool isLoading = false;

//   void getWinderData() async {
//     setState(() {
//       isLoading = true;
//     });
//     AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
//     await appProvider.callBackFunctionWinder(
//       widget.salonModel.id,
//       widget.salonModel.adminId,
//     );
//     setState(() {
//       isLoading = false;
//     });

//     // Debug prints to check data
//     print("Categories: ${appProvider.getcategoryList}");
//     print("Services: ${appProvider.getServiceList}");
//   }

//   @override
//   void initState() {
//     getWinderData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppProvider appProvider = Provider.of<AppProvider>(context);

//     // Filter categories with available services
//     List<CategoryModel> categoriesWithServices =
//         appProvider.getcategoryList.where((category) {
//       List<ServiceModel> services = appProvider.getServiceList
//           .where((service) => service.categoryId == category.id)
//           .toList();
//       print("Category: ${category.id}, Services Count: ${services.length}");
//       return services.isNotEmpty;
//     }).toList();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       key: _scaffoldKey,
//       appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
//       drawer: const CustomDrawer(),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : CustomScrollView(
//               slivers: [
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         vertical: Dimensions.dimenisonNo16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Container(
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: Dimensions.dimenisonNo16),
//                             height: Dimensions.dimenisonNo250,
//                             width: double.infinity,
//                             clipBehavior: Clip.antiAlias,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                   widget.salonModel.image!,
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                               borderRadius: BorderRadius.circular(
//                                   Dimensions.dimenisonNo10),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: Dimensions.dimenisonNo16),
//                         // Salon Name
//                         Container(
//                           width: double.infinity,
//                           height: Dimensions.dimenisonNo60,
//                           margin: EdgeInsets.symmetric(
//                               horizontal: Dimensions.dimenisonNo16),
//                           decoration: ShapeDecoration(
//                             color: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   Dimensions.dimenisonNo10),
//                             ),
//                             shadows: [
//                               BoxShadow(
//                                 color: const Color(0x3F000000),
//                                 blurRadius: Dimensions.dimenisonNo10,
//                                 offset: const Offset(0, -1),
//                                 spreadRadius: 0,
//                               )
//                             ],
//                           ),
//                           child: Center(
//                             child: Text(
//                               widget.salonModel.name,
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: Dimensions.dimenisonNo24,
//                                 fontFamily: GoogleFonts.roboto().fontFamily,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 1.25,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: Dimensions.dimenisonNo16),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: Dimensions.dimenisonNo16),
//                           child: TwoButton(
//                             detailBgColor: Colors.white,
//                             detailTextColor: AppColor.buttonColor,
//                             serviceBgColor: AppColor.buttonColor,
//                             serviceTextColor: Colors.white,
//                             detailOnTap: () {
//                               Navigator.push(
//                                 context,
//                                 PageRouteBuilder(
//                                   pageBuilder: (context, animation,
//                                           secondaryAnimation) =>
//                                       WinderProfileScreen(
//                                     salonModel: widget.salonModel,
//                                   ),
//                                   transitionsBuilder: (context, animation,
//                                       secondaryAnimation, child) {
//                                     return child; // No animation transition
//                                   },
//                                 ),
//                               );
//                             },
//                             serviceOnTap: () {},
//                           ),
//                         ),
//                         SizedBox(height: Dimensions.dimenisonNo12),
//                         Divider(),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SliverList(
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       if (categoriesWithServices.isEmpty) {
//                         return Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(Dimensions.dimenisonNo16),
//                             child: Text(
//                               "No Categories with Services Available",
//                               style: TextStyle(
//                                 fontSize: Dimensions.dimenisonNo24,
//                                 fontFamily: GoogleFonts.roboto().fontFamily,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                       CategoryModel categoryModel =
//                           categoriesWithServices[index];
//                       return CategoryTap(
//                         categoryModel: categoryModel,
//                         salonModel: widget.salonModel,
//                       );
//                     },
//                     childCount: categoriesWithServices.isEmpty
//                         ? 1
//                         : categoriesWithServices.length,
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
