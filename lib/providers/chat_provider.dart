import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class ChatProvider with ChangeNotifier {
  String reply = '';
  int currentIndex = 0;
  final tabController = CupertinoTabController();

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> chatQuestions(String message) async {
    Uri url = Uri.parse('https://immig-assist.co.uk/api/openai_chatbot?question=$message');
    var response = await http.get(
      url,
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      var allData = jsonDecode(response.body);
      reply = allData['text'];
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  changePageFromNavBar(index){
      currentIndex = index;
      tabController.index = index;
  notifyListeners();
  }

}
