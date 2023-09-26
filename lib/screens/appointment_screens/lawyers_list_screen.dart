import 'package:flutter/material.dart';
import 'package:laws/screens/appointment_screens/lawyer_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../providers/lawyer_provider.dart';

class LawyersListScreen extends StatefulWidget {
  const LawyersListScreen({Key? key}) : super(key: key);

  @override
  State<LawyersListScreen> createState() => _LawyersListScreenState();
}

class _LawyersListScreenState extends State<LawyersListScreen> {
  // @override
  // void initState() {
  //   Provider.of<LawyerProvider>(context, listen: false).getAllLawyer();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LawyerProvider>(
          builder: (ctx, provider, child) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
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
                            'Solicitors',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown.shade500),
                          )
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                            top: 25, left: 10, right: 10, bottom: 25),
                        itemCount: provider.lawyersByField.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LawyerDetailsScreen(
                                          theLawyer:
                                              provider.lawyersByField[index])));
                            },
                            child: Card(
                                elevation: 5,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: kAppBrown,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${provider.lawyersByField[index].firstName[0]}${provider.lawyersByField[index].lastName[0]}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                              130,
                                          child: RichText(
                                            textAlign: TextAlign.start,
                                            maxLines: 4,
                                            text: TextSpan(
                                              text:
                                                  '${provider.lawyersByField[index].firstName} ${provider.lawyersByField[index].lastName}\n',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: provider
                                                        .lawyersByField[index]
                                                        .description,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 10)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
