import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:laws/constants/constants.dart';


class AuthProvider with ChangeNotifier{

  login({required String password, required String email, required bool isLawyer}) async {
    Uri lawyerUrl = Uri.parse('${apiURL}lawyer_login');
    Uri clintUrl = Uri.parse('${apiURL}user_login');
    var response = await http.post(isLawyer ? lawyerUrl : clintUrl, body: {'email': email.toLowerCase(), 'password': password});
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

notifyListeners();
  }
}