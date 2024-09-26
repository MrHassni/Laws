import 'package:flutter/material.dart';
import 'package:laws/providers/auth_provider.dart';
import 'package:laws/screens/auth_screens/register_screen.dart';
import 'package:laws/screens/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool hidePassword = true;
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
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
            key: _formKey,
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
                  validator: _validateEmail,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hint: 'Password',
                  textEditingController: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: hidePassword,
                  validator: _validatePassword,
                  sIcon: InkWell(
                      onTap: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      child: const Text('SHOW',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13))),
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
                        // const Text(
                        //   'Forget Password ?    ',
                        //   style: TextStyle(fontWeight: FontWeight.w500),
                        // )
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: loading
                      ? Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: kAppBrown,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )),
                  )
                      : InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
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
                            .login(
                            password: passwordController.text,
                            email: emailController.text,
                            context: context,
                            remember: rememberMe)
                            .then((_) {
                          setState(() {
                            loading = false;
                          });
                        });
                      } else {
                        errorSnackBar(
                            context: context,
                            message: 'Please fix the errors in the form.');
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
                            child: Text('Sign in',
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
                              builder: (context) => const RegisterScreen()));
                    },
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Don\'t have an account?  ',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
