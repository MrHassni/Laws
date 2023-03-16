import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laws/constants/constants.dart';

import '../models/client_profile_model.dart';
import '../models/lawyer_profile_model.dart';
import '../screens/map_screens/map_screens.dart';

class AuthProvider with ChangeNotifier{

  login({required String password, required String email, required bool isLawyer, required BuildContext context}) async {
    Uri lawyerUrl = Uri.parse('${apiURL}lawyer_login');
    Uri clintUrl = Uri.parse('${apiURL}user_login');
    var response = await http.post(isLawyer ? lawyerUrl : clintUrl, body: {'email': email.toLowerCase(), 'password': password});
    if (response.statusCode == 200) {
      var allData = jsonDecode(response.body);
      if(isLawyer) {
        log(allData['content']['id'].toString());
        getLawyerProfile(id: allData['content']['id'].toString());
      }else{
        log(allData['content']['id'].toString());

        getClientProfile(id: allData['content']['id'].toString(), context: context);
      }

    } else {
      throw Exception('Failed to load data');
    }
  notifyListeners();}


    getLawyerProfile({required String id}) async {
      Uri url = Uri.parse('${apiURL}lawyer_profile?id=$id');
      var response = await http.get(url,);
      if (response.statusCode == 200) {
        var allData = jsonDecode(response.body);
        log(allData.toString());
        LawyerProfileModel.fromJson(allData['content']);
      } else {
        throw Exception('Failed to load data');
      }
      notifyListeners();
  }


  getClientProfile({required String id, required BuildContext context}) async {
      Uri url = Uri.parse('${apiURL}user_profile?id=$id');
      var response = await http.get(url,);
      if (response.statusCode == 200) {
        var allData = jsonDecode(response.body);
        log(allData.toString());
        ClientModel.fromJson(allData['content']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MapScreen()),
        );

      } else {
        throw Exception('Failed to load data');
      }
        notifyListeners();
  }


}