import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> getAdditionalKakaoAccount() async {
    User user;
    try {
      user = await UserApi.instance.me();
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
      return;
    }

    List<String> scopes = [];

    if (user.kakaoAccount?.emailNeedsAgreement == true) {
      scopes.add('account_email');
    }
    if (user.kakaoAccount?.birthdayNeedsAgreement == true) {
      scopes.add("birthday");
    }
    if (user.kakaoAccount?.birthyearNeedsAgreement == true) {
      scopes.add("birthyear");
    }
    if (user.kakaoAccount?.ciNeedsAgreement == true) {
      scopes.add("account_ci");
    }
    if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) {
      scopes.add("phone_number");
    }
    if (user.kakaoAccount?.profileNeedsAgreement == true) {
      scopes.add("profile");
    }
    if (user.kakaoAccount?.ageRangeNeedsAgreement == true) {
      scopes.add("age_range");
    }

    if (scopes.length > 0) {
      print('사용자에게 추가 동의 받아야 하는 항목이 있습니다');

      // OpenID Connect 사용 시
      // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
      // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
      // scopes.add("openid")

      //scope 목록을 전달하여 카카오 로그인 요청
      OAuthToken token;
      try {
        token = await UserApi.instance.loginWithNewScopes(scopes);
        print('현재 사용자가 동의한 동의 항목: ${token.scopes}');
      } catch (error) {
        print('추가 동의 요청 실패 $error');
        return;
      }

      // 사용자 정보 재요청
      try {
        User user = await UserApi.instance.me();
        print('사용자 정보 요청 성공'
            '\n회원번호: ${user.id}'
            '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
            '\n이메일: ${user.kakaoAccount?.email}');
      } catch (error) {
        print('사용자 정보 요청 실패 $error');
      }
    }
  }

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      int userId = user.id;
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n이메일: ${user.kakaoAccount?.email}');
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
                      setLogin();
                      getAdditionalKakaoAccount();
                      Navigator.of(context).pushReplacementNamed('/nickname');
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');
                      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                      try {
                        await UserApi.instance.loginWithKakaoAccount();
                        print('카카오계정으로 로그인 성공');
                        setLogin();
                        getAdditionalKakaoAccount();
                        Navigator.of(context).pushReplacementNamed('/nickname');
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  } else {
                    // 카카오톡이 설치되어 있지 않은 경우
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공!');
                      setLogin();
                      _get_user_info();
                      Navigator.of(context).pushReplacementNamed('/nickname');
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
