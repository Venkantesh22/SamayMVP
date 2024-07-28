import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/constants/constants.dart';
import 'package:samay_mvp/models/watchlist_service_model/watchlist_service_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class SingleServiceTap extends StatelessWidget {
  final WatchListServiceModel watchListServiceModel;

  const SingleServiceTap({
    Key? key,
    required this.watchListServiceModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.dimenisonNo12),
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.dimenisonNo10,
          horizontal: Dimensions.dimenisonNo14),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(Dimensions.dimenisonNo10)),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  '▪️ ${watchListServiceModel.servicesName}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.dimenisonNo20,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                CupertinoIcons.exclamationmark_circle,
                color: AppColor.pendingColor,
              ),
              SizedBox(
                width: Dimensions.dimenisonNo5,
              ),
              Text(
                watchListServiceModel.state,
                style: TextStyle(
                  color: AppColor.pendingColor,
                  fontSize: Dimensions.dimenisonNo20,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.25,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Dimensions.dimenisonNo10),
            child: const Divider(),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    watchListServiceModel.salonName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.dimenisonNo18,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.dimenisonNo5,
                  ),
                  Text(
                    'Select Date and Time',
                    style: TextStyle(
                      color: AppColor.pendingColor,
                      fontSize: Dimensions.dimenisonNo16,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.dimenisonNo5,
                  ),
                  Row(
                    children: [
                      Text(
                        'Total Amount :-  ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.dimenisonNo16,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                      Icon(
                        Icons.currency_rupee_outlined,
                        size: Dimensions.dimenisonNo16,
                      ),
                      Text(
                        watchListServiceModel.price.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.dimenisonNo16,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  try {
                    showLoaderDialog(context);
                    appProvider
                        .deleteServiceForWatchListPro(watchListServiceModel);
                    Navigator.of(context, rootNavigator: true).pop();

                    showMessage('Service is remove for Watch List');
                  } catch (e) {
                    showMessage(
                        'Error occur not remove service for Watch List ${e.toString()}');
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: AppColor.pendingColor,
                  size: Dimensions.dimenisonNo36,
                ),
              ),
              SizedBox(
                width: Dimensions.dimenisonNo20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
