import 'package:flutter/material.dart';
import 'package:laws/screens/covid_updates_screen/covid_update_screen.dart';
import 'package:laws/screens/map_screens/map_screens.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../providers/lawyer_provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  List<Map<String, dynamic>> contentList = [
    // {
    //   'name': "Legal Checker",
    //   'des': 'We are here to help you identify your legal issues or disputes.',
    //   'icon': Icons.live_help_outlined
    // },
    // {
    //   'name': "Government Services",
    //   'des': 'Access key government services and databases all from one place.',
    //   'icon': Icons.reduce_capacity
    // },
    {
      'name': "Updates",
      'des':
          'Find Out The Latest News and announcements about us and our services.',
      'icon': Icons.newspaper
    },
    {
      'name': "Covid Regulations",
      'des':
          'Find the latest updates on coronavirus regulations and how they apply.',
      'icon': Icons.masks_outlined
    },
    // {
    //   'name': "Legal Docs",
    //   'des': 'Browse through our library of available documents and forms.',
    //   'icon': Icons.document_scanner_outlined
    // },
  ];

  final Uri _upDatesUrl = Uri.parse('https://test.immig-assist.co.uk/blog');
  final Uri _covidUrl = Uri.parse(
      'https://www.who.int/teams/regulation-prequalification/regulation-and-safety');

  @override
  void initState() {
    Provider.of<LawyerProvider>(context, listen: false).getLawyersCategories();
    Provider.of<LawyerProvider>(context, listen: false).getAllAppointments();
    Provider.of<LawyerProvider>(context, listen: false).getPastAppointments();
    Provider.of<LawyerProvider>(context, listen: false)
        .getUpComingAppointments();
    Provider.of<LawyerProvider>(context, listen: false).getLawyersCities();
    Provider.of<LawyerProvider>(context, listen: false).getLawyersTypes();
    Provider.of<LawyerProvider>(context, listen: false).getLawyersEthnicities();
    super.initState();
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBrown,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 35),
              child: Image.asset(
                'images/white_logo.png',
                width: MediaQuery.of(context).size.width * 0.4,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Handle Legal Issue With The Best ',
                          style: TextStyle(
                              color: kAppBrown,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Attorneys',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  decoration: TextDecoration.underline,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            // Provider.of<ScreensProvider>(context, listen: false).onItemTapped(3);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapScreen()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: kAppBrown,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Find An Attorney',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 18)),
                                Text('Search, Filter, Contact.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(width: 15,),
                        // InkWell(
                        //   borderRadius: BorderRadius.circular(10),
                        //   onTap:(){
                        //     // Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MainAuthScreen()));
                        //   },
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width * 0.425,
                        //     padding: const EdgeInsets.all(9),
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: kAppBrown,width: 2),
                        //         borderRadius: BorderRadius.circular(10)
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Text('Book An Attorney',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: kAppBrown,fontSize: 18)),
                        //          Text('Schedule, Book, Call.',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.normal, color: kAppBrown,fontSize: 13)),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    SizedBox(
                      height: 195,
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        scrollDirection: Axis.horizontal,
                        itemCount: contentList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 20,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
                                _launchUrl(_upDatesUrl);
                              } else if (index == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  const CovidRegulationsScreen()));
                              }
                            },
                            child: Card(
                                color: kAppBrown.withOpacity(0.2),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin: EdgeInsets.zero,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          text:
                                              '${contentList[index]['name']}\n',
                                          style: TextStyle(
                                              color: Colors.brown.shade500,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text: '\n',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 5)),
                                            TextSpan(
                                                text: contentList[index]['des'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: kAppBrown,
                                                    fontSize: 13)),
                                            const TextSpan(
                                                text: '\n',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 5)),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Icon(
                                          contentList[index]['icon'],
                                          color: Colors.brown.shade500,
                                          size: 40,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        },
                      ),
                    ),
                    //
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Container(
                    //     padding: const EdgeInsets.all(25),
                    //     child: RichText(
                    //       textAlign: TextAlign.left,
                    //       text: TextSpan(
                    //         text: 'Our ',
                    //         style: TextStyle(
                    //             color: kAppBrown,
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 25
                    //         ),
                    //         children:  <TextSpan>[
                    //           TextSpan(text: 'Best ', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown.shade500, fontSize: 30)),
                    //           const TextSpan(text: 'Working Areas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(15),
                    //       child: Image.network('http://test.immig-assist.co.uk/front-assets/images/icons/london.jpg',
                    //         width: MediaQuery.of(context).size.width * 0.4,
                    //         height: 200,
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(15),
                    //       child: Image.network('http://test.immig-assist.co.uk/front-assets/images/icons/york.jpg',
                    //         width: MediaQuery.of(context).size.width * 0.4,
                    //         height: 200,
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 25,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(15),
                    //       child: Image.network('http://test.immig-assist.co.uk/front-assets/images/icons/bristol.jpg',
                    //         width: MediaQuery.of(context).size.width * 0.4,
                    //         height: 200,
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //     ClipRRect(
                    //       borderRadius: BorderRadius.circular(15),
                    //       child: Image.network('http://test.immig-assist.co.uk/front-assets/images/icons/manchester.jpg',
                    //         width: MediaQuery.of(context).size.width * 0.4,
                    //         height: 200,
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
