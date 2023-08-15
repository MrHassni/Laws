import 'package:flutter/material.dart';
import 'package:laws/providers/auth_provider.dart';
import 'package:laws/screens/auth_screens/register_screen.dart';
import 'package:laws/screens/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';

class LogInScreen extends StatefulWidget {


  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 35),
                child: Image.asset(
                  'images/black_logo.png',
                  // color: kAppBrown,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text('Welcome\nBack!',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kAppBrown,
                        fontSize: 35)),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                hint: 'Email',
                textEditingController: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hint: 'Password',
                textEditingController: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hidePassword,
                sIcon: InkWell(
                    onTap: (){
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    child: const Text('SHOW', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),)),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (val) {
                              setState(() {
                                rememberMe = val!;
                              });
                            },
                            activeColor: kAppBrown,
                          ),
                          const Text(
                            'Remember Me',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const Text(
                        'Forget Password ?    ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                      if (passwordController.text.trim().isNotEmpty &&
                          emailController.text.trim().isNotEmpty) {
                        Provider.of<AuthProvider>(context, listen: false).login(
                            password: passwordController.text,
                            email: emailController.text,
                            context: context,
                            remember: rememberMe);
                      } else {
                        errorSnackBar(
                            context: context,
                            message: 'Fill all the fields properly.');
                      }
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: kAppBrown,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: const Center(
                          child: Text('Sign In',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.85,
              //   child: Row(children: <Widget>[
              //     Expanded(
              //         child: Divider(
              //       thickness: 1.5,
              //       color: Colors.grey.shade500,
              //     )),
              //     const Text(
              //       "  Sign In With  ",
              //       style: TextStyle(fontWeight: FontWeight.w500),
              //     ),
              //     Expanded(
              //         child: Divider(
              //       thickness: 1.5,
              //       color: Colors.grey.shade500,
              //     )),
              //   ]),
              // ),
              // const SizedBox(
              //   height: 25,
              // ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.85,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         padding: const EdgeInsets.all(5),
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(
              //                 color: Colors.grey.shade500, width: 3)),
              //         child: Image.network(
              //           'https://cdn-icons-png.flaticon.com/512/59/59439.png',
              //           errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              //             return const CircularProgressIndicator();
              //           },
              //           height: 35,
              //           width: 35,
              //           color: Colors.grey.shade500,
              //         ),
              //       ),
              //       Container(
              //         padding: const EdgeInsets.all(5),
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(
              //                 color: Colors.grey.shade500, width: 3)),
              //         child: Image.network(
              //           'https://icons.veryicon.com/png/o/application/outline-1/google-75.png',
              //           errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              //             return const CircularProgressIndicator();
              //           },
              //           height: 35,
              //           width: 35,
              //           color: Colors.grey.shade500,
              //         ),
              //       ),
              //       Container(
              //         padding: const EdgeInsets.all(5),
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(
              //                 color: Colors.grey.shade500, width: 3)),
              //         child: Image.network(
              //           'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/1667px-Apple_logo_black.svg.png',
              //           errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              //             return const CircularProgressIndicator();
              //           },
              //           height: 35,
              //           width: 35,
              //           color: Colors.grey.shade500,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 50,
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen(
                                )));
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Don\'t have an account?  ',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                        // fontSize: 30
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Register',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kAppBrown,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
