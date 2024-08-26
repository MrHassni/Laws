import 'package:flutter/material.dart';
import 'package:laws/models/lawyer_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../providers/lawyer_provider.dart';
import 'appointment_add_details_screen.dart';

class LawyerDetailsScreen extends StatefulWidget {
  final LawyerModel theLawyer;

  const LawyerDetailsScreen({Key? key, required this.theLawyer})
      : super(key: key);

  @override
  State<LawyerDetailsScreen> createState() => _LawyerDetailsScreenState();
}

class _LawyerDetailsScreenState extends State<LawyerDetailsScreen> {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  '${widget.theLawyer.firstName} ${widget.theLawyer.lastName}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // widget.theLawyer.phoneNo == null
                  //     ? const SizedBox()
                  //     :
                  InkWell(
                          onTap: () async {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: '+44 794 608 9604',
                              // path: widget.theLawyer.phoneNo,
                            );
                            await launchUrl(launchUri);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kAppBrown,
                                borderRadius: BorderRadius.circular(50)),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  InkWell(
                    onTap: () {
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        // path: widget.theLawyer.email,
                        path: 'admin@immig-assist@co.uk',
                        query: encodeQueryParameters(<String, String>{
                          'subject': 'Hello!\n\nI need help with',
                        }),
                      );

                      launchUrl(emailLaunchUri);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: kAppBrown,
                          borderRadius: BorderRadius.circular(50)),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // widget.theLawyer.website == null
                  //     ? const SizedBox()
                  //     :
                  InkWell(
                          onTap: () async {
                            if (!await launchUrl(
                                Uri.parse('https://immig-assist.co.uk/'))) {
                              throw Exception(
                                  'Could not launch ${'https://immig-assist.co.uk/'}');
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: kAppBrown,
                                borderRadius: BorderRadius.circular(50)),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.web,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Text(
                  'SRA Authorised?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child:  Text(
                  widget.theLawyer.sraAuthorized ?? "No",  textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
                ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Text(
                  'About',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child:  Text(
                    widget.theLawyer.description == null ? 'N/A' : widget.theLawyer.description.toString(),  textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Text(
                  'Experience',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child:  Text(
                    widget.theLawyer.experience,  textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Text(
                  'Hourly Rate',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child:  Text(
                    widget.theLawyer.hourlyRate == null ? 'UnDefined' : '${widget.theLawyer.hourlyRate}\$',  textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Text(
                  'Qualification',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child:  Text(
                    widget.theLawyer.qualification ?? 'Not Provided',  textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16)),
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: (){
                  Provider.of<LawyerProvider>(context, listen: false).allSlots.clear();
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  AppointmentAddDetailsScreen(theLawyer: widget.theLawyer,)));
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                        color: kAppBrown,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Text('Book Now',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 18)),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
