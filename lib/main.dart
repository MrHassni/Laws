import 'package:flutter/material.dart';
import 'package:laws/providers/auth_provider.dart';
import 'package:laws/providers/lawyer_provider.dart';
import 'package:laws/screens/map_screens/map_screens.dart';
import 'package:laws/screens/start_screen/start_screen.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => LawyerProvider()),
        ],
        child: const MyApp(),
      ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMMIG-ASSIST',
      theme: ThemeData(
        primarySwatch:  MaterialColor(0xFFB7A26A, brownSwatch),
      ),
      home: const MapScreen(),
      // home: const StartScreen()
    );
  }
}

