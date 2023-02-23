
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget sIcon;
  const CustomTextField({Key? key, required this.hint, this.textEditingController, this.keyboardType = TextInputType.text, this.obscureText = false, this.sIcon = const SizedBox()}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        controller: textEditingController,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              filled: true,
              hintText: hint,
              suffix: sIcon,
              fillColor: Colors.grey.shade500,
              enabledBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(width: 0, color: Colors.transparent), //<-- SEE HERE
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(width: 0, color: Colors.transparent), //<-- SEE HERE
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
      ),
    );
  }
}
