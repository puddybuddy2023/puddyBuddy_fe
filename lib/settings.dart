import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  Future setLogout() async {
    // 로그인 상태를 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    prefs.setString('email', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black)),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('알림'),
                  content: Text('로그아웃하시겠습니까?'),
                  actions: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFA8ABFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  minimumSize: Size(100, 40), // 버튼의 최소 크기 지정
                                ),
                                onPressed: () {
                                  setLogout();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/login', (route) => false);
                                  //Navigator.pushNamed(context, '/login');
                                },
                                child: Text('예',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              SizedBox(width: 8), // 버튼 간격 조절
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  minimumSize: Size(100, 40), // 버튼의 최소 크기 지정
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('아니오',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            child: ListTile(
                minVerticalPadding: 0,
                title: Text(
                  '로그아웃',
                )),
          ),
          ListTile(
              title: Text(
            '회원 탈퇴',
          )),
        ],
      ),
    );
  }
}
