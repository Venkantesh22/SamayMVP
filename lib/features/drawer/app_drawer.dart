import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samay_mvp/constants/router.dart';
import 'package:samay_mvp/features/appointment/screen/appointment_screen.dart';
import 'package:samay_mvp/features/home/screen/homescreen.dart';
import 'package:samay_mvp/features/profile/screen/profile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Routes.instance
                  .push(widget: const HomeScreen(), context: context);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.calendarCheck),
            title: Text('Appointment'),
            onTap: () {
              Routes.instance
                  .push(widget: const AppointmentScreen(), context: context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Routes.instance
                  .push(widget: const ProfileScreen(), context: context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('LogOut'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
