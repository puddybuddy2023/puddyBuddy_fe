import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

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
      child: const Column(
        children: [
          SizedBox(
            height: 220,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  'assets/images/loading_dog.png',
                  // adjust the width and alignment as needed
                ),
                height: 100,
              ),
            ],
          ),
          LinearProgressIndicator(),
        ],
      ),
    ));
  }
}
