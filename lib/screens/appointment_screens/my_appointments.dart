import 'package:flutter/material.dart';
import 'package:laws/models/appointments_model.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../providers/lawyer_provider.dart';

class MyAppointments extends StatelessWidget {
  const MyAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Consumer<LawyerProvider>(
            builder: (ctx, provider, child) => Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 25,),
              Row(
                children:  [
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_new, size: 25,color: Colors.brown.shade500,)),
                  const SizedBox(width: 10,),
                  Text('My Appointments', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.brown.shade500),)
                ],
              ),
              const TabBar(
                tabs: [
                  Tab(icon: Text('Upcoming Appointments')),
                  Tab(icon: Text("Past Appointments")),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: TabBarView(children: [
                  listOfAppointmentsWidget(provider.upComingAppointments),
                  listOfAppointmentsWidget(provider.pastAppointments),
                ]),
              ),

            ],
          ),
        )),
      ),
    );
  }

  ListView listOfAppointmentsWidget(List<AppointmentModel> appointmentLists) {
    return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    top: 25, left: 10, right: 10, bottom: 25),
                itemCount: appointmentLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return  InkWell(
                    splashColor: Colors.transparent,
                    onTap: (){
                    },
                    child: Card(
                        elevation: 0,
                        color: kAppBrown.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width - 100,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                  width: (MediaQuery.sizeOf(context).width - 100)/2,
                                        child: Text(
                                          "${appointmentLists[index].firstname} ${appointmentLists[index].lastname}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                          width: (MediaQuery.sizeOf(context).width - 100)/2,
                                          child: Text('  (${appointmentLists[index].lawyersType})'))
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                appointmentLists[index].appDetail == null ? const SizedBox() : Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Text(appointmentLists[index].appDetail ?? ""),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                      decoration:  BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Row(
                                        children: [
                                           Padding(
                                             padding: const EdgeInsets.only(bottom: 1),
                                             child: Icon(Icons.calendar_month, size: 15,color: kAppBrown,),
                                           ),
                                          Text( ' ${appointmentLists[index].appDate}',style:  TextStyle(
                                              color: kAppBrown,
                                              fontWeight: FontWeight.bold,),),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                      decoration:  BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 1),
                                            child: Icon(Icons.alarm, size: 15,color: kAppBrown,),
                                          ),
                                          Text(" From ${appointmentLists[index].appStartTime} To ${appointmentLists[index].appEndTime}",style:  TextStyle(
                                            color: kAppBrown,
                                            fontWeight: FontWeight.bold,),),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ))),
                  );
                },
              );
  }
}
