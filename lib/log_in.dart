import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // void signInWithKakao() async {
  //   try {
  //     bool isInstalled = await isKakaoTalkInstalled();
  //
  //     OAuthToken token = isInstalled
  //         ? await UserApi.instance.loginWithKakaoTalk()
  //         : await UserApi.instance.loginWithKakaoAccount();
  //
  //     final url = Uri.https('kapi.kakao.com', '/v2/user/me');
  //
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
  //       },
  //     );
  //
  //     final profileInfo = json.decode(response.body);
  //     print(profileInfo.toString());
  //   } catch (error) {
  //     print('카카오톡으로 로그인 실패 $error');
  //   }
  // }

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      int userId = user.id;
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

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
              height: 230,
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
              height: 20,
            ),
            Container(
              width: 220,
              child: ElevatedButton(
                onPressed: () async {
                  //print(await KakaoSdk.origin);
                  if (await isKakaoTalkInstalled()) {
                    try {
                      await UserApi.instance.loginWithKakaoTalk();
                      print('카카오톡으로 로그인 성공');
                      _get_user_info();
                      Navigator.of(context).pushReplacementNamed('/nickname');
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');
                      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                      try {
                        await UserApi.instance.loginWithKakaoAccount();
                        print('카카오계정으로 로그인 성공');
                        _get_user_info();
                        Navigator.of(context).pushReplacementNamed('/nickname');
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  } else {
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                      _get_user_info();
                      Navigator.of(context).pushReplacementNamed('/nickname');
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                  //signInWithKakao();
                  //Navigator.of(context).pushReplacementNamed('/index');
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
