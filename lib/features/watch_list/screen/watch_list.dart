import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/features/watch_list/widget/service_tap.dart';
import 'package:samay_mvp/models/service_model/service_model.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/dimension.dart';

class WatchList extends StatefulWidget {
  const WatchList({
    Key? key,
  }) : super(key: key);

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF3F3F3),
          title: Center(
            child: const Text(
              'Watch List',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: appProvider.getWatchList.isEmpty
            ? Center(
                child: Text(
                  'No service is add',
                  style: TextStyle(fontSize: Dimensions.dimenisonNo20),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.dimenisonNo20),
                  padding: EdgeInsets.all(Dimensions.dimenisonNo16),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(Dimensions.dimenisonNo10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.dimenisonNo10),
                            color: const Color.fromARGB(255, 201, 200, 200)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Detail',
                              style: TextStyle(
                                fontSize: Dimensions.dimenisonNo20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.dimenisonNo10),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Subtotal :- ",
                                  style: TextStyle(
                                    fontSize: Dimensions.dimenisonNo20,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.dimenisonNo20,
                                ),
                                Icon(
                                  Icons.currency_rupee_sharp,
                                  size: Dimensions.dimenisonNo22,
                                ),
                                Text(
                                  appProvider.getSubTotal.toString(),
                                  style: TextStyle(
                                    fontSize: Dimensions.dimenisonNo20,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Total Time :- ",
                                  style: TextStyle(
                                    fontSize: Dimensions.dimenisonNo20,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.dimenisonNo20,
                                ),
                                Icon(
                                  Icons.watch_later_rounded,
                                  size: Dimensions.dimenisonNo22,
                                ),
                                SizedBox(
                                  width: Dimensions.dimenisonNo10,
                                ),
                                Text(
                                  appProvider.getServiceBookingDuration
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: Dimensions.dimenisonNo20,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.dimenisonNo20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: appProvider.getWatchList.length,
                        itemBuilder: (context, index) {
                          ServiceModel serviceModel =
                              appProvider.getWatchList[index];

                          return SingleServiceTap(serviceModel: serviceModel);
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
