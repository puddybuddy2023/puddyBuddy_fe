import 'package:flutter/material.dart';
import 'package:mungshinsa/main.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    return isLogin;
  }

  // void moveScreen() async {
  //   await checkLogin().then((isLogin){
  //     if(isLogin){
  //       Navigator.of(context).pushReplacementNamed('/index');
  //     } else {
  //       Navigator.of(context).pushReplacementNamed('/login');
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2000), (){
      Navigator.of(context).pushReplacementNamed('/index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFA8ABFF),
        child: Column(
          children: [
            SizedBox(height: 250,),
            Text('Puddy\nBuddy', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 100,),
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
