import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 25,),
            Text(
              'Results',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade500),
            ),
            Divider(
              thickness: 1.5,
              color: Colors.brown.shade500,
            ),
          ],
        ),
      ),

    );
  }
}
