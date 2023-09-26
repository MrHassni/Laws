import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:laws/providers/lawyer_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../models/lawyer_model.dart';

class AppointmentAddDetailsScreen extends StatefulWidget {
  final LawyerModel theLawyer;

  const AppointmentAddDetailsScreen({super.key, required this.theLawyer});

  @override
  AppointmentAddDetailsScreenState createState() =>
      AppointmentAddDetailsScreenState();
}

class AppointmentAddDetailsScreenState
    extends State<AppointmentAddDetailsScreen> {
  TextEditingController textEditingController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _pickDate() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(DateTime.now().year + 1),
      onConfirm: (date) {
        log('message');
        Provider.of<LawyerProvider>(context, listen: false).getLawyerTimeSlots(
            date: _formatDateForFunction(date), lawyerId: widget.theLawyer.id, context: context);
        setState(() {
          _selectedDate = date;
        });
      },
    );
  }
  String startTime = '';
  String endTime = '';


  String _formatDate(DateTime date) {
    return DateFormat("EEEE, dd MMMM yyyy").format(date);
  }
  String _formatDateForFunction(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LawyerProvider>(
          builder: (ctx, provider, child) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 25,
                        color: Colors.brown.shade500,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Appointment Details',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade500),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: TextField(
                  maxLines: 4,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Describe the reason of appointment...',
                    fillColor: Colors.grey.shade500,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                      //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0, color: Colors.transparent),
                      //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: _pickDate,
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      border: Border.all(color: kAppBrown, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Date',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kAppBrown,
                              fontSize: 18)),
                      Text(_formatDate(_selectedDate).toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: kAppBrown,
                              fontSize: 13)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    childAspectRatio: 2/1.25
                  ),
                  shrinkWrap: true,
                  itemCount: provider.allSlots.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: (){
                        if(provider.allSlots[index].available){
                          errorSnackBar(context: context, message: "This slot is not available");
                        }else{
                          setState(() {
                            startTime = provider.allSlots[index].startTime;
                            endTime = provider.allSlots[index].endTime;
                          });
                        }
                      },
                      child: Container(
                        padding:  EdgeInsets.symmetric(
                            horizontal: startTime == provider.allSlots[index].startTime ? 4 : 5, vertical: startTime == provider.allSlots[index].startTime ? 4 : 5),
                        decoration: BoxDecoration(
                            color: !provider.allSlots[index].available ? kAppBrown : Colors.red,
                            border: Border.all(width: 1, color: startTime == provider.allSlots[index].startTime ? Colors.black : Colors.transparent),
                            borderRadius: BorderRadius.circular(10)),
                        child:  Center(
                          child: Text('${provider.allSlots[index].startTime}\nTo\n${provider.allSlots[index].endTime}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14)),
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if(startTime != '' && endTime != '') {

                    Provider.of<LawyerProvider>(context, listen: false)
                      .createAppointment(
                          date: '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                          startTime: startTime,
                          endTime: endTime,
                          reason: textEditingController.text,
                          theLawyer: widget.theLawyer,
                          context: context);
                  }else{
                    errorSnackBar(context: context, message: 'Please, select any time slot');
                  }
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          color: kAppBrown,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text('Book Appointment Now',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
