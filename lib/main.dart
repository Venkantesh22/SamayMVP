import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:samay_mvp/constants/theme.dart';
import 'package:samay_mvp/features/auth/screen/login.dart';
import 'package:samay_mvp/features/home/screen/ex.dart';
import 'package:samay_mvp/features/home/screen/homescreen.dart';
import 'package:samay_mvp/features/winder_profile/screen/winder_profile_screen.dart';
import 'package:samay_mvp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:samay_mvp/utility/dimension.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Samay',
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home:

            // Builder(builder: (context) {
            //   Dimensions.init(context);
            //   return MyEx();
            // })

            StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Dimensions.init(context);
              return const HomeScreen();
            }
            Dimensions.init(context);
            return const LoginScreen();
          },
        ),
        routes: {
          '/home': (context) => HomeScreen(),
          // '/second': (context) => SecondScreen(),
          // '/third': (context) => ThirdScreen(),
        },
      ),
    );
  }
}
