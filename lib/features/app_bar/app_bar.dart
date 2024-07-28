import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samay_mvp/constants/router.dart';
import 'package:samay_mvp/features/watch_list/screen/watch_list.dart';
import 'package:samay_mvp/utility/color.dart';
import 'package:samay_mvp/utility/dimension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.mainColor,
      title: Center(
        child: Text(
          'SAMAY',
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.dimenisonNo24,
            fontFamily: GoogleFonts.inter().fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.watch_later,
            color: Colors.white,
          ),
          onPressed: () {
            Routes.instance.push(widget: WatchList(), context: context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
