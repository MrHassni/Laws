import 'package:flutter/material.dart';
import 'package:laws/screens/appointment_screens/lawyers_ctegories_list_screen.dart';
import 'package:laws/screens/appointment_screens/lawyers_list_screen.dart';
import 'package:laws/screens/appointment_screens/lawyer_details_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../providers/lawyer_provider.dart';

class LawyersTypesScreen extends StatefulWidget {
  const LawyersTypesScreen({Key? key}) : super(key: key);

  @override
  State<LawyersTypesScreen> createState() => _LawyersTypesScreenState();
}

class _LawyersTypesScreenState extends State<LawyersTypesScreen> {

  bool loading = false;

  @override
  void initState() {
    Provider.of<LawyerProvider>(context, listen: false).getLawyersTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Consumer<LawyerProvider>(
          builder: (ctx, provider, child) => Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: SingleChildScrollView(
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
                      Text('Book Now', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.brown.shade500),)
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                        top: 25, left: 10, right: 10, bottom: 25),
                    itemCount: loading ? 1 : provider.lawyersTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return loading ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: const Center(child: CircularProgressIndicator.adaptive())) : InkWell(
                        onTap: (){
                          setState(() {
                            loading = true;
                          });
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  LawyersCategoriesListScreen(type: provider.lawyersTypes[index]['id'],)));
                            loading = false;

                        },
                        child: Card(
                          color: index == 0 ? Colors.green.shade200 : Colors.blue.shade200,
                            elevation: 5,
                            margin: const EdgeInsets.only(bottom: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 200,
                                padding: const EdgeInsets.symmetric(horizontal: 25,),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${provider.lawyersTypes[index]['name']}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    Text(
                                      '${provider.lawyersTypes[index]['tooltip']}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
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
