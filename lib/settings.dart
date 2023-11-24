import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

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
          ListTile(
              minVerticalPadding: 0,
              title: Text(
                '로그아웃',
              )),
          ListTile(
              title: Text(
            '회원 탈퇴',
          )),
        ],
      ),
    );
  }
}
