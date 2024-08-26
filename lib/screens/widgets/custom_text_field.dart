import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget sIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.hint,
    this.textEditingController,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.sIcon = const SizedBox(),
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          hintText: hint,
          suffix: sIcon,
          fillColor: Colors.grey.shade500,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.circular(10.0),
            ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
