import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laws/constants/shared_prefs.dart';
import 'package:laws/models/appointment_slot_model.dart';
import 'package:laws/models/appointments_model.dart';
import 'package:laws/screens/appointment_screens/web_view_screen.dart';

import '../constants/constants.dart';
import '../models/lawyer_model.dart';

class LawyerProvider with ChangeNotifier {
  List<LawyerModel> allLawyers = [];
  List<LawyerModel> lawyersByField = [];
  List lawyersCategories = [];
  List lawyersTypes = [];
  List lawyersEthnicities = [];
  List<String> allCities = [];
  List<AppointmentSlotModel> allSlots = [];
  List<AppointmentModel> allAppointments = [];
  List<AppointmentModel> pastAppointments = [];
  List<AppointmentModel> upComingAppointments = [];

  getAllLawyer() async {
    Uri url = Uri.parse('${apiURL}lawyer_list');
    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      List<LawyerModel> allLaws = [];
      var allData = jsonDecode(response.body);

      for (int i = 0; i < allData['content'].length; i++) {
        allLaws.add(LawyerModel.fromJson(allData['content'][i]));
      }
      allLawyers = allLaws;
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getLawyersByField(
      {required dynamic fieldId,
      required dynamic typeId,
      required dynamic ethnicity,
      required String location}) async {
    Uri url = Uri.parse(
        '${apiURL}lawyers_filter?type_id=$typeId&ethnicity_id=$ethnicity&field_id=$fieldId&location=$location');
    var response = await http.get(
      url,
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      List<LawyerModel> allLaws = [];
      var allData = jsonDecode(response.body);

      for (int i = 0; i < allData['content'].length; i++) {
        allLaws.add(LawyerModel.fromJson(allData['content'][i]));
      }
      lawyersByField = allLaws;
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getLawyersCategories() async {
    Uri url = Uri.parse('${apiURL}list_fields');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      List allLaws = [];
      var allData = jsonDecode(response.body);

      for (int i = 0; i < allData['content'].length; i++) {
        allLaws.add(allData['content'][i]);
      }
      lawyersCategories = allLaws;
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getLawyersTypes() async {
    Uri url = Uri.parse('${apiURL}list_types');
    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      List allLaws = [];
      var allData = jsonDecode(response.body);

      for (int i = 0; i < allData['content'].length; i++) {
        allLaws.add(allData['content'][i]);
      }
      lawyersTypes = allLaws;
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getLawyersEthnicities() async {
    Uri url = Uri.parse('${apiURL}list_ethnicities');
    var response = await http.get(
      url,
    );


    if (response.statusCode == 200) {
      List allLaws = [];
      var allData = jsonDecode(response.body);

      for (int i = 0; i < allData['content'].length; i++) {
        allLaws.add(allData['content'][i]);
      }
      lawyersEthnicities = allLaws;
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getLawyersCities() async {
    Uri url = Uri.parse('${apiURL}list_cities');
    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      List<String> allLaws = [];
      var allData = jsonDecode(response.body);

      for (int i = 0; i < allData['content'].length; i++) {
        if (!allLaws.contains(allData['content'][i]['name'])) {
          allLaws.add(allData['content'][i]['name']);
        }
      }
      allCities = allLaws;
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  createAppointment({
    required String date,
    required String startTime,
    required String endTime,
    required String reason,
    required LawyerModel theLawyer,
    required BuildContext context,
  }) async {
    dynamic myId = await SharedPrefs.getUserIdSharedPreference();

    Uri clintUrl = Uri.parse('${apiURL}user_create_appointments');
    var response = await http.post(clintUrl, body: {
      'customer_id': myId.toString(),
      'lawyer_id': theLawyer.id.toString(),
      'app_firstname': theLawyer.firstName,
      'app_lastname': theLawyer.lastName,
      'app_email': theLawyer.email,
      'app_contact': theLawyer.phoneNo,
      'app_location': theLawyer.location,
      'app_budget': theLawyer.hourlyRate.toString(),
      'app_range': theLawyer.experience.toString(),
      'app_type_id': theLawyer.typeId.toString(),
      'app_ethnicity_id': theLawyer.ethnicityId.toString(),
      'app_visatype_id': theLawyer.visaTypeId.toString(),
      'app_date': date,
      'start_time': startTime,
      'end_time': endTime,
      'app_detail': reason
    });

    if (response.statusCode == 200) {
      var allData = jsonDecode(response.body);
      log(allData.toString());
      getUpComingAppointments();
      getPastAppointments();
      // print('${allData['content']['id'].toString()+'/'+allData['content']['customer_id'].toString()}/'+allData['content']['lawyer_id'].toString());
      // Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(
      //     appointmentId: allData['content']['id'].toString(),
      //     userId: allData['content']['customer_id'].toString(),
      //     lawyerId: allData['content']['lawyer_id'].toString())));
      Navigator.pop(context);
      nonErrorSnackBar(context: context, message: 'Appointment created successfully');

    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getAllAppointments() async {
    dynamic id = await SharedPrefs.getUserIdSharedPreference();
    Uri url = Uri.parse('${apiURL}user_appointments?user_id=$id');
    var response = await http.get(
      url,
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      List<AppointmentModel> appointments = [];
      final jsonData = json.decode(response.body);
      for (int i = 0; i < jsonData['content'].length; i++) {
        appointments.add(AppointmentModel.fromJson(jsonData['content'][i]));
      }
      allAppointments = appointments;
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getPastAppointments() async {
    dynamic id = await SharedPrefs.getUserIdSharedPreference();
    Uri url = Uri.parse('${apiURL}user_appointments?user_id=$id&type=past');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      List<AppointmentModel> appointments = [];
      final jsonData = json.decode(response.body);
      for (int i = 0; i < jsonData['content'].length; i++) {
        appointments.add(AppointmentModel.fromJson(jsonData['content'][i]));
      }
      pastAppointments = appointments;
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getUpComingAppointments() async {
    dynamic id = await SharedPrefs.getUserIdSharedPreference();
    Uri url = Uri.parse('${apiURL}user_appointments?user_id=$id&type=future');
    var response = await http.get(
      url,
    );
    log(response.body.toString());
    if (response.statusCode == 200) {
      List<AppointmentModel> appointments = [];
      final jsonData = json.decode(response.body);

      for (int i = 0; i < jsonData['content'].length; i++) {
        appointments.add(AppointmentModel.fromJson(jsonData['content'][i]));
      }
      upComingAppointments = appointments;
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }

  getLawyerTimeSlots({required String date, required int lawyerId, required BuildContext context}) async {
    Uri url =
        Uri.parse('${apiURL}check_slots?app_date=$date&lawyer_id=$lawyerId');
    var response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      List<AppointmentSlotModel> allLaws = [];
      var allData = jsonDecode(response.body);
      if(allData['content'].isEmpty){
        errorSnackBar(context: context, message: 'This lawyer is not available for the day you choose.');
      }
      for (int i = 0; i < allData['content'].length; i++) {
        allLaws.add(AppointmentSlotModel.fromJson(allData['content'][i]));
      }
      allSlots = allLaws;
    } else {
      throw Exception('Failed to load data');
    }
    notifyListeners();
  }
}
