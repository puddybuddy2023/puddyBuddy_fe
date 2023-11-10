import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFA8ABFF),
        child: Column(
          children: [
            SizedBox(
              height: 210,
            ),
            Text(
              'Puddy\nBuddy',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('카카오로 로그인', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 40),
                backgroundColor: Color(0xFFF3C15B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('로그아웃', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 40),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/splash_img.png',
                    // adjust the width and alignment as needed
                  ),
                  height: 150,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
