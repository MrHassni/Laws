import 'package:flutter/material.dart';

class MoreScreenButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  const MoreScreenButton({super.key, required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
