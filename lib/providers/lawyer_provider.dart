import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../models/lawyer_model.dart';
import '../models/lawyer_profile_model.dart';

class LawyerProvider with ChangeNotifier{

  getLawyerProfile({required String id}) async {
    Uri url = Uri.parse('${apiURL}lawyer_list');
    var response = await http.get(url,);
    if (response.statusCode == 200) {
      var allData = jsonDecode(response.body);
      log(allData.toString());
      LawyerModel.fromJson(allData['content']);
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }
}