import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laws/constants/constants.dart';
import 'package:laws/constants/shared_prefs.dart';
import 'package:laws/screens/bottom_nav_screens/bottom_nav_screen.dart';
import 'package:laws/screens/start_screen/start_screen.dart';

import '../models/client_profile_model.dart';
import '../models/lawyer_profile_model.dart';
import '../screens/map_screens/map_screens.dart';

class AuthProvider with ChangeNotifier {
  ClientModel? currentUser;

  login(
      {required String password,
      required String email,
      required BuildContext context,
      required bool remember}) async {
    // Uri lawyerUrl = Uri.parse('${apiURL}lawyer_login');
    Uri clintUrl = Uri.parse('${apiURL}user_login');
    var response = await http.post(clintUrl,
        body: {'email': email.toLowerCase(), 'password': password});
    log(response.body.toString());
    if (response.statusCode == 200) {
      var allData = jsonDecode(response.body);
      log(allData['content']['id'].toString());
      if (context.mounted) {
        getClientProfile(
            id: allData['content']['id'].toString(),
            context: context,
            remember: true);
      }
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  register({
    required String fName,
    required String lName,
    required String email,
    required String password,
    required String phoneNo,
    required String address,
    required BuildContext context,
  }) async {
    // Uri lawyerUrl = Uri.parse('${apiURL}lawyer_login');
    Uri clintUrl = Uri.parse('${apiURL}user_register');
    var response = await http.post(clintUrl, body: {
      'firstname': fName,
      'lastname': lName,
      'email': email.toLowerCase(),
      'password': password,
      'phone_no': phoneNo,
      'address': address,
    });
    if (response.statusCode == 200) {
      var allData = jsonDecode(response.body);
      log(allData['content']['id'].toString());
      if (context.mounted) {
        getClientProfile(
            id: allData['content']['id'].toString(),
            context: context,
            remember: true);
      }
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getLawyerProfile({required String id}) async {
    Uri url = Uri.parse('${apiURL}lawyer_profile?id=$id');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      var allData = jsonDecode(response.body);
      log(allData.toString());
      LawyerModel.fromJson(allData['content']);
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getClientProfile(
      {required String id,
      required BuildContext context,
      required bool remember,
      bool goBack = false,
      }) async {
    Uri url = Uri.parse('${apiURL}user_profile?id=$id');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      var allData = jsonDecode(response.body);
      log(allData.toString());
      ClientModel.fromJson(allData['content']);

      if (remember) {
        SharedPrefs.saveUserLoggedInSharedPreference(true);
      }
      SharedPrefs.saveUserEmailSharedPreference(
          allData['content']['email'].toString());
      SharedPrefs.saveUserIdSharedPreference(
          allData['content']['id'].toString());
      currentUser = ClientModel.fromJson(allData['content']);
          if(goBack == false){
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavScreen()),
          );
        }
      }else {
            if(context.mounted) {
              Navigator.pop(context);
            }
          }
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

   editProfile({
    required String id,
    required String fName,
    required String lName,
    required String phoneNo,
    required String address,
    required File? myImage,
    required BuildContext context,
}) async {

    Uri url = Uri.parse('${apiURL}user_profile');
    var request = http.MultipartRequest('POST', url);

    request.fields['id'] = id;
    request.fields['firstname'] = fName;
    request.fields['lastname'] = lName;
    request.fields['phone_no'] = phoneNo;
    request.fields['address'] = address;

    if (myImage != null) {
      var image = await http.MultipartFile.fromPath('image', myImage.path);
      request.files.add(image);
    }

    var response = await request.send();


    if (response.statusCode == 200) {
      if (context.mounted) {
        getClientProfile(id: id, context: context, remember: true, goBack: true);
      }
      if (kDebugMode) {
        print('Form data uploaded successfully');
      }
    } else {
      if (kDebugMode) {
        print('Failed to upload form data. Status code: ${response.statusCode}');
      }
    }
    notifyListeners();
  }
}
