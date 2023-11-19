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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF858AFF), Color(0xFF9492FF), Color(0xFFBFA8FF)],
          ),
        ),
        //color: Color(0xFFA8ABFF),
        child: Column(
          children: [
            SizedBox(
              height: 220,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/title.png',
                    // adjust the width and alignment as needed
                  ),
                  height: 100,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/index');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/images/kakao.png',
                        // adjust the width and alignment as needed
                      ),
                      height: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '카카오로 로그인',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 40),
                    backgroundColor: Color(0xFFF3C15B),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Text('로그아웃', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),),
            //   style: ElevatedButton.styleFrom(
            //       minimumSize: Size(200, 40),
            //       backgroundColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20))),
            // ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/splash_img.png',
                    // adjust the width and alignment as needed
                  ),
                  height: 200,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
