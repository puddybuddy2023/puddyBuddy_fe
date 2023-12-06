import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mungshinsa/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mungshinsa/providers/user_api.dart';

import '../loading.dart';
import '../main.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Future setLogin() async {
    // 로그인 상태를 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
  }

  Future setUserInfo(int? userId, String? nickname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', userId!);
    prefs.setString('nickname', nickname!);
  }

  Future<String?> _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      String? userEmail = user.kakaoAccount?.email;
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n이메일: ${user.kakaoAccount?.email}');
      return userEmail;
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();
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
                    // 카카오톡이 설치되어 있는 경우
                    try {
                      await UserApi.instance.loginWithKakaoTalk();
                      print('카카오톡으로 로그인 성공');
                      _get_user_info();
                      setLogin();
                      Navigator.of(context).pushReplacementNamed('/nickname');
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');
                      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                      try {
                        await UserApi.instance.loginWithKakaoAccount();
                        print('카카오계정으로 로그인 성공');
                        String? email = await _get_user_info(); // 사용자 이메일 가져오기
                        if (email != null) {
                          bool result = await userProvider.userExists(email);
                          if (result) {
                            // 이미 존재하는 사용자의 경우, 로그인 상태 저장 후 index 페이지로 이동
                            setLogin();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Loading(nextPage: IndexScreen())),
                            );
                          } else {
                            // 존재하지 않는 사용자의 경우, 닉네임 입력 페이지로 이동
                            Navigator.of(context)
                                .pushReplacementNamed('/nickname');
                          }
                        }
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  } else {
                    // 카카오톡이 설치되어 있지 않은 경우
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공!');
                      String? email = await _get_user_info(); // 사용자 이메일 가져오기
                      if (email != null) {
                        bool result = await userProvider.userExists(email);
                        print(result);
                        if (result) {
                          // 이미 존재하는 사용자의 경우, 로그인 상태 저장 후 index 페이지로 이동
                          Map<dynamic, dynamic> result =
                              await userProvider.getUserId(email);
                          setUserInfo(result['userId'], result['nickname']);
                          // await storage.write(
                          //     key: 'userId',
                          //     value: result['userId'].toString());
                          // userInfo.userId = result['userId'];
                          // userInfo.nickname = result['nickname'];
                          setLogin();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) =>
                                    Loading(nextPage: IndexScreen())),
                          );
                        } else {
                          // 존재하지 않는 사용자의 경우, 닉네임 입력 페이지로 이동
                          Navigator.of(context).pushReplacementNamed(
                              '/nickname',
                              arguments: email);
                        }
                      }
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                  //signInWithKakao();
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
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/splash_img.png',
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
