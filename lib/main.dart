import 'package:flutter/material.dart';
import 'package:laws/screens/start_screen/start_screen.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LAWS',
      theme: ThemeData(
        primarySwatch:  MaterialColor(0xFFB7A26A, brownSwatch),
      ),
      home: const StartScreen()
    );
  }
}

