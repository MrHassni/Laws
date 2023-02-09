import 'package:flutter/material.dart';
import 'package:laws/screens/auth_screens/login_screen.dart';
import 'package:laws/screens/auth_screens/register_screen.dart';

import '../../constants/constants.dart';

class MainAuthScreen extends StatelessWidget {
  const MainAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 35),
              child: Image.asset('images/law.png',
                color: kAppBrown,
                width: MediaQuery.of(context).size.width * 0.4,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.grey.shade400.withOpacity(0.2),
                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: const Center(
                    child: Text('Sign In', style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )),
                  ),),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                },
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: kAppBrown,
                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      child: const Center(
                        child: Text('Create Account', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
