import 'package:flutter/material.dart';
import 'package:laws/screens/appointment_screens/lawyers_list_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../providers/lawyer_provider.dart';

class LawyersCategoriesListScreen extends StatefulWidget {
  const LawyersCategoriesListScreen({super.key, required this.type, required this.typeName});
  final int type;
  final String typeName;

  @override
  State<LawyersCategoriesListScreen> createState() => _LawyersCategoriesListScreenState();
}

class _LawyersCategoriesListScreenState extends State<LawyersCategoriesListScreen> {

  bool loading = false;

  @override
  void initState() {
    Provider.of<LawyerProvider>(context, listen: false).getLawyersCategories();
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
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text('Select Required ${widget.typeName}\'s Field', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.brown.shade500),))
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                        top: 25, left: 10, right: 10, bottom: 25),
                    itemCount: loading ? 1 : provider.lawyersCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return loading ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: const Center(child: CircularProgressIndicator.adaptive())) : InkWell(
                        onTap: (){
                          setState(() {
                            loading = true;
                          });
                          provider.getLawyersByField(fieldId: provider.lawyersCategories[index]['id'], typeId: widget.type, ethnicity: '', location: '', ).then((_){
                            if(provider.lawyersByField.isNotEmpty){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  LawyersListScreen(typeName: widget.typeName,)));
                            }else{
                              errorSnackBar(
                                  context: context,
                                  message: 'No Lawyer Available');
                            }
                            loading = false;
                          });
                        },
                        child: Card(
                            elevation: 0,
                            color: kAppBrown.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width -125,
                                      child: Text(
                                          provider.lawyersCategories[index]['name'],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    // Icon(Icons.arrow_forward_ios, size: 35,color: Colors.brown.shade500,),

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
