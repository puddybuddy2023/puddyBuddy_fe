import 'package:flutter/material.dart';

class Stage1 extends StatelessWidget {
  const Stage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF858AFF), Color(0xFF9492FF), Color(0xFFBFA8FF)],
        ),
      ),
    ));
  }
}
