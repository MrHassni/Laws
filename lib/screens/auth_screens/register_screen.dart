import 'package:flutter/material.dart';
import 'package:laws/screens/auth_screens/login_screen.dart';
import 'package:laws/screens/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text('SignUp Now',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kAppBrown,
                        fontSize: 30)),
              ),
              const SizedBox(
                height: 25,
              ),
               CustomTextField(
                hint: 'First Name',
                textEditingController: fNameController,
              ),
              const SizedBox(
                height: 15,
              ),
               CustomTextField(
                hint: 'Last Name',
                textEditingController: lNameController,
              ),
              const SizedBox(
                height: 15,
              ),
               CustomTextField(
                hint: 'Email',
                 textEditingController: emailController,
              ),
              const SizedBox(
                height: 15,
              ),
               CustomTextField(
                hint: 'Password',
                textEditingController: passwordController,
              ),
              const SizedBox(
                height: 15,
              ),
               CustomTextField(
                hint: 'Confirm Password',
                textEditingController: reEnterPasswordController,
              ),
              const SizedBox(
                height: 15,
              ),
               CustomTextField(
                hint: 'Phone No.#',
                 textEditingController: phoneNoController,
              ),
              const SizedBox(
                height: 15,
              ),
               CustomTextField(
                hint: 'Address',
                 textEditingController: addressController,
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: InkWell(
                  onTap: (){
                    if (passwordController.text.isNotEmpty &&
                        emailController.text.trim().isNotEmpty &&
                        lNameController.text.trim().isNotEmpty &&
                        fNameController.text.trim().isNotEmpty &&
                        phoneNoController.text.trim().isNotEmpty &&
                        addressController.text.trim().isNotEmpty) {

                      if(passwordController.text == reEnterPasswordController.text){
                        Provider.of<AuthProvider>(context, listen: false).register(
                            password: passwordController.text,
                            email: emailController.text,
                            context: context, fName: fNameController.text, lName: lNameController.text, phoneNo: phoneNoController.text, address: addressController.text);
                      }else {
                        errorSnackBar(
                            context: context,
                            message: 'Password dosen\'t match.');
                      }
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
                          child: Text('SignUp',
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
              //           height: 35,
              //           errorBuilder: (BuildContext context, Object exception,
              //               StackTrace? stackTrace) {
              //             return const CircularProgressIndicator();
              //           },
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
              //           height: 35,
              //           errorBuilder: (BuildContext context, Object exception,
              //               StackTrace? stackTrace) {
              //             return const CircularProgressIndicator();
              //           },
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
              //           height: 35,
              //           errorBuilder: (BuildContext context, Object exception,
              //               StackTrace? stackTrace) {
              //             return const CircularProgressIndicator();
              //           },
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
                            builder: (context) => const LogInScreen()));
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Already have an account?  ',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                        // fontSize: 30
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'LogIn',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kAppBrown,
                                decoration: TextDecoration.underline)),
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
