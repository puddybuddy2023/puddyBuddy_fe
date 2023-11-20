import 'package:flutter/material.dart';

class Nickname extends StatefulWidget {
  const Nickname({super.key});

  @override
  State<Nickname> createState() => _NicknameState();
}

class _NicknameState extends State<Nickname> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nicknameController = TextEditingController();

    void dispose() {
      // 페이지가 dispose 될 때 controller를 정리
      _nicknameController.dispose();
      super.dispose();
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF858AFF), Color(0xFF9492FF), Color(0xFFBFA8FF)],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 280,
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
              height: 40,
              child: TextFormField(
                controller: _nicknameController, // 컨트롤러 할당
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                    hintText: '사용할 닉네임을 입력해주세요'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '댓글을 입력해주세요';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // 버튼의 배경색을 검정으로 설정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 모서리를 둥글게 만듦
                ),
              ),
              onPressed: () {
                // 버튼을 눌렀을 때 수행되는 동작
                // 여기에 사용자 입력을 처리하거나 다른 작업을 추가할 수 있습니다.
              },
              child: Text(
                '입력',
                style: TextStyle(
                  color: Colors.white, // 텍스트 색상을 흰색으로 설정
                  fontSize: 18,
                ),
              ),
            ),
            Image(
              image: AssetImage(
                'assets/images/dog_pushing_button.png',
                // adjust the width and alignment as needed
              ),
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
