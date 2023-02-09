
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  const CustomTextField({Key? key, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
            decoration: InputDecoration(
              filled: true,
              hintText: hint,
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
