import 'package:flutter/material.dart';
import 'package:laws/constants/shared_prefs.dart';
import 'package:laws/providers/auth_provider.dart';
import 'package:laws/screens/auth_screens/main_auth_screen.dart';
import 'package:laws/screens/bottom_nav_screens/bottom_nav_screen.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _mockCheckForSession();
  }

  _mockCheckForSession() async {
    bool? loggedIn = await SharedPrefs.getUserLoggedInSharedPreference();
    String? id = await SharedPrefs.getUserIdSharedPreference();

    await Future.delayed(const Duration(milliseconds: 3000), () {
      if (loggedIn == true) {
        Provider.of<AuthProvider>(context, listen: false).getClientProfile(id: id!, context: context, remember: true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>  const BottomNavScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainAuthScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        'images/black_logo.png',
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.6,
      )),
    );
  }
}
