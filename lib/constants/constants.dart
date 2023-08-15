import 'package:flutter/material.dart';

Color kAppBrown = const Color(0xFFB7A26A);

final Map<int, Color> brownSwatch = {
  50: Colors.brown.shade50,
  100: Colors.brown.shade100,
  200: Colors.brown.shade200,
  300: Colors.brown.shade300,
  400: Colors.brown.shade400,
  500: Colors.brown.shade500,
  600: Colors.brown.shade600,
  700: Colors.brown.shade700,
  800: Colors.brown.shade800,
  900: Colors.brown.shade900,
};

String apiURL = 'https://test.immig-assist.co.uk/api/';

errorSnackBar({required BuildContext context, required String message}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          dismissDirection: DismissDirection.up,
        margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.red,
        content: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w500),),)
  );
}

nonErrorSnackBar({required BuildContext context, required String message}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.up,
        margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: kAppBrown,
        content: Text(message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500),),)
  );
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}