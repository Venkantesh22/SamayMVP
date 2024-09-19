import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:samay_mvp/constants/theme.dart';
import 'package:samay_mvp/features/auth/screen/login.dart';
import 'package:samay_mvp/features/home/screen/homescreen.dart';
import 'package:samay_mvp/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:samay_mvp/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:samay_mvp/utility/dimension.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isConnectedToInternet;
  bool? isLoggedIn;
  StreamSubscription? _internetConnectionStreamSubscription;
  bool isDimensionsInitialized = false; // Flag for dimension initialization

  @override
  void initState() {
    super.initState();
    checkInternetAndAuthStatus();
  }

  Future<void> checkInternetAndAuthStatus() async {
    // Listen for internet connection changes
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((status) {
      setState(() {
        isConnectedToInternet = (status == InternetStatus.connected);
      });
    });

    // Check login status once internet connection is verified
    FirebaseAuthHelper.instance.getAuthChange.listen((user) {
      setState(() {
        isLoggedIn = user != null;
      });
    });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure Dimensions are initialized only after the first frame is rendered
    if (!isDimensionsInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Dimensions.init(context);
        setState(() {
          isDimensionsInitialized = true; // Set the flag once initialized
        });
      });
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Samay',
          theme: themeData,
          debugShowCheckedModeBanner: false,
          home: _buildInitialScreen(), // Show the appropriate screen
          routes: {
            '/home': (context) => const HomeScreen(),
          },
        );
      },
    );
  }

  Widget _buildInitialScreen() {
    // If we are still checking, show a loading indicator
    if (isConnectedToInternet == null ||
        isLoggedIn == null ||
        !isDimensionsInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // If no internet, show no internet screen
    if (!isConnectedToInternet!) {
      return _buildNoInternetScreen();
    }

    // If internet is connected, check if the user is logged in
    return isLoggedIn! ? const HomeScreen() : const LoginScreen();
  }

  Widget _buildNoInternetScreen() {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isConnectedToInternet! ? Icons.wifi : Icons.wifi_off,
              size: 50,
              color: isConnectedToInternet! ? Colors.green : Colors.red,
            ),
            Text(isConnectedToInternet!
                ? "You are connected to the internet."
                : "You are not connected to the internet. ")
          ],
        ),
      ),
    );
  }
}
