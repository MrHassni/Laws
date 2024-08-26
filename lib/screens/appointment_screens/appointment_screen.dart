import 'package:flutter/material.dart';
import 'package:laws/constants/constants.dart';
import 'package:laws/screens/appointment_screens/lawyers_list_screen.dart';
import 'package:laws/screens/appointment_screens/lawyers_ctegories_list_screen.dart';
import 'package:laws/screens/appointment_screens/lawyers_types_screen.dart';
import 'package:laws/screens/appointment_screens/my_appointments.dart';
import 'package:laws/screens/bottom_nav_screens/bottom_nav_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/chat_provider.dart';
import '../../providers/lawyer_provider.dart';
import '../splash_screens/splash_screen.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Column(
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/512/1427/1427965.png',
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                  const SizedBox(
                    height: 10,
                                      ),
                  Text(
                    'MANGE APPOINTMENTS',
                    style:
                        TextStyle(fontSize: 20, color: Colors.brown.shade500),
                  )
                ],
              ),
            ),
            Column(
              children: [
                InkWell(
                  onTap: (){
                    Provider.of<ChatProvider>(context, listen: false).changePageFromNavBar(0);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 30,
                        color: kAppBrown,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Find Solicitors',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LawyersTypesScreen()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 30,
                        color: kAppBrown,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Book Appointments',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAppointments()));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.watch_later,
                        size: 30,
                        color: kAppBrown,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Check Your Schedule',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LawyersTypesScreen()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                        color: kAppBrown,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text('Let\'s Book',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    Provider.of<LawyerProvider>(context, listen: false).getAllAppointments();
                    Provider.of<LawyerProvider>(context, listen: false).getPastAppointments();
                    Provider.of<LawyerProvider>(context, listen: false)
                        .getUpComingAppointments();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAppointments()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        border: Border.all(color: kAppBrown, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('My Schedule',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kAppBrown,
                            fontSize: 16)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
