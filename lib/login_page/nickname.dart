import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../loading.dart';
import '../main.dart';
import '../providers/user_api.dart';
import '../user_info.dart';

class Nickname extends StatefulWidget {
  const Nickname({super.key});

  @override
  State<Nickname> createState() => _NicknameState();
}

class _NicknameState extends State<Nickname> {
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

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    final storage = FlutterSecureStorage();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _nicknameController = TextEditingController();

    void dispose() {
      // 페이지가 dispose 될 때 controller를 정리
      _nicknameController.dispose();
      super.dispose();
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF858AFF), Color(0xFF9492FF), Color(0xFFBFA8FF)],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 300,
              child: Image(
                image: AssetImage(
                  'assets/images/welcome.png',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 60, right: 60, bottom: 30),
              height: 60,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _nicknameController, // 컨트롤러 할당
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // 밑줄 색상
                        width: 15.0, // 밑줄 두께
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                    hintText: '사용할 닉네임을 입력해주세요',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '닉네임을 입력해주세요';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                clipBehavior: Clip.none,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(105, 50),
                      primary: Colors.white, // 버튼의 배경색을 검정으로
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45), // 모서리를 둥글게
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      '입력',
                      style: TextStyle(
                          color: Colors.black87, // 텍스트 색상을 흰색으로 설정
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Positioned(
                    right: -23,
                    top: 23,
                    child: Image(
                      image: AssetImage(
                        'assets/images/dog_pushing_button.png',
                        // adjust the width and alignment as needed
                      ),
                      height: 180,
                    ),
                  ),
                  Positioned(
                    // 버튼이 이미지에 가려져서 안눌리는 문제 해결하기 위해
                    right: 0,
                    top: 0,
                    child: InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          int result = await userProvider.getNewUserId(
                              email, _nicknameController.text);
                          setUserInfo(result, _nicknameController.text);
                          // await storage.write(key: 'userId', value: result);
                          // userInfo.userId = result;
                          // userInfo.nickname = _nicknameController.text;
                          setLogin();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoadingWithNextPage(
                                nextPage: IndexScreen(),
                                duration: 2,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 105,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              30), // 반지름을 버튼 높이의 절반으로 설정하여 둥근 모서리 생성
                          color: Colors.transparent, // 투명한 배경색 지정
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
