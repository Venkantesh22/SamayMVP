import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/features/app_bar/app_bar.dart';
import 'package:samay_mvp/features/drawer/app_drawer.dart';
import 'package:samay_mvp/features/watch_list/widget/service_tap.dart';
import 'package:samay_mvp/models/watchlist_service_model/watchlist_service_model.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      key: _scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.dimenisonNo16),
        child: Column(
          children: [
            Consumer<AppProvider>(
              builder: (context, appProvider, child) {
                return StreamBuilder<List<WatchListServiceModel>>(
                  stream: appProvider.getWatchListStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No services in your watch list.'));
                    }

                    List<WatchListServiceModel> watchList = snapshot.data!;
                    return ListView.builder(
                      
                      itemCount: watchList.length,
                      itemBuilder: (context, index) {
                        return SingleServiceTap(
                          watchListServiceModel: watchList[index],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
