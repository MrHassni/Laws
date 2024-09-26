
import 'package:flutter/material.dart';
import 'package:laws/screens/auth_screens/login_screen.dart';
import 'package:laws/screens/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>(); // Add a form key

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    // A simple regex for email validation
    String pattern =
        r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    // Regex to validate phone numbers with country code
    String pattern = r'^\+\d{1,3}\d{9,13}$';
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Enter a valid phone number with country code';
    }
    return null;
  }


  String? _validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey, // Wrap the form with Form widget
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
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Text('Sign up Now',
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
                  validator: _validateName, // Add validator
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Last Name',
                  textEditingController: lNameController,
                  validator: _validateName, // Add validator
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Email',
                  textEditingController: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail, // Add validator
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Password',
                  textEditingController: passwordController,
                  obscureText: true,
                  validator: _validatePassword, // Add validator
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Confirm Password',
                  textEditingController: reEnterPasswordController,
                  obscureText: true,
                  validator: _validateConfirmPassword, // Add validator
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Phone No.',
                  textEditingController: phoneNoController,
                  keyboardType: TextInputType.phone,
                  validator: _validatePhoneNumber, // Add validator
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Address',
                  textEditingController: addressController,
                  validator: _validateAddress, // Add validator
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState?.validate() ?? false) {


                        setState(() {
                          loading = true;
                        });
                        Future.delayed(const Duration(seconds: 13), () {
                          if (loading == true) {
                            setState(() {
                              loading = false;
                            });
                          }
                        });
                        Provider.of<AuthProvider>(context, listen: false)
                            .register(
                            password: passwordController.text,
                            email: emailController.text,
                            context: context,
                            fName: fNameController.text,
                            lName: lNameController.text,
                            phoneNo: phoneNoController.text,
                            address: addressController.text)
                            .then((_) {
                          setState(() {
                            loading = false;
                          });
                        });
                      } else {
                        errorSnackBar(
                            context: context,
                            message: 'Please correct the errors in the form.');
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
                          child: Center(
                            child: loading == true
                                ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                                : const Text('Sign up',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
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
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sign in',
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
      ),
    );
  }
}
