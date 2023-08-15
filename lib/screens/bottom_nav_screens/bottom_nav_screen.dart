import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laws/constants/constants.dart';
import 'package:laws/screens/aI_chat_screens/ai_chat_screen.dart';
import 'package:laws/screens/more_screens/more_screens.dart';
import 'package:laws/screens/start_screen/start_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/chat_provider.dart';
import '../appointment_screens/appointment_screen.dart';

class BottomNavScreen extends StatefulWidget {
  final int? pageNumber;
   const BottomNavScreen({Key? key, this.pageNumber}) : super(key: key);

  @override
  BottomNavScreenState createState() {
    return BottomNavScreenState();
  }
}

class BottomNavScreenState extends State<BottomNavScreen> {
  List<Widget> data = [const StartScreen(), const AIChatScreen(), const AppointmentScreen(), const MoreScreen(),];
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            //set border radius more than 50% of height and width to make circle
          ),
        title: const Text('Are you sure?'),
        content: const Text('You want to exit IMMIG-ASSIST?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No', style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes',style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red
            )),
          ),
        ],
      ),
    )) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    log(Provider.of<ChatProvider>(context).currentIndex.toString());
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: CupertinoTabScaffold(
            controller: Provider.of<ChatProvider>(context).tabController,
            tabBar: CupertinoTabBar(
              currentIndex: Provider.of<ChatProvider>(context).currentIndex,
              backgroundColor: kAppBrown.withOpacity(0.6),
              activeColor:  Colors.brown.shade500,
              inactiveColor: Colors.white,
              onTap: (i){
                Provider.of<ChatProvider>(context, listen: false).changePageFromNavBar(i);
              },
              items:  const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble_2),
                  label: "AI Chat",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month),
                  label: "Book Attorney",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.more_horiz),
                  label: "More",
                )
              ],
            ),
            tabBuilder: (context, index) {
              return CupertinoTabView(
                builder: (context) {
                  return data[Provider.of<ChatProvider>(context).currentIndex];
                },
              );
            },
          )),
    );
  }
}
