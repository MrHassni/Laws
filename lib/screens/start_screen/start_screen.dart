import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../auth_screens/main_auth_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);


  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBrown,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35,),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 35),
              child: Image.asset('images/white_logo.png',
                width: MediaQuery.of(context).size.width * 0.4,
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration:  const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 25,),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Handle Legal Issue With The Best ',
                          style: TextStyle(
                              color: kAppBrown,
                              fontWeight: FontWeight.bold,
                              fontSize: 30
                          ),
                          children: const <TextSpan>[
                            TextSpan(text: 'Attorneys', style: TextStyle(fontWeight: FontWeight.w800, decoration: TextDecoration.underline,)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 35,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MainAuthScreen(isLawyer: false,)));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                color: kAppBrown,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: const Text('Hire An Attorney',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 18)),
                          ),
                        ),
                        const SizedBox(width: 15,),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MainAuthScreen(isLawyer: true              ,)));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                border: Border.all(color: kAppBrown,width: 2),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('Be An Attorney',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: kAppBrown,fontSize: 18)),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 25,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: 'Our ',
                            style: TextStyle(
                                color: kAppBrown,
                                fontWeight: FontWeight.bold,
                                fontSize: 25
                            ),
                            children:  <TextSpan>[
                              TextSpan(text: 'Best ', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown.shade500, fontSize: 30)),
                              const TextSpan(text: 'Working Areas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network('http://test.immig-assist.co.uk/front-assets/images/icons/london.jpg',
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network('http://test.immig-assist.co.uk/front-assets/images/icons/york.jpg',
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network('http://test.immig-assist.co.uk/front-assets/images/icons/bristol.jpg',
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network('http://test.immig-assist.co.uk/front-assets/images/icons/manchester.jpg',
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35,),
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