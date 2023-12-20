import 'package:flutter/material.dart';

class FittingResult extends StatefulWidget {
  final Map<dynamic, dynamic> result;
  const FittingResult({super.key, required this.result});

  @override
  State<FittingResult> createState() => _FittingResultState();
}

class _FittingResultState extends State<FittingResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: SizedBox.shrink(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5.0),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  CircleBorder(),
                ),
                minimumSize: MaterialStateProperty.all<Size>(Size(30, 30)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
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
            Row(
              children: [
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
            Image.asset('assets/images/fitting_title.png'),
            const SizedBox(
              height: 50,
            ),
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(15), // 모서리를 둥글게 조정하려면 해당 값을 조정하세요
              child: Image.network(
                widget.result['imgUrl'], // 네트워크에서 가져올 이미지 주소
                fit: BoxFit.cover, // 이미지가 위젯에 맞게 보이도록 설정
                width: 350, // 이미지의 가로 크기 설정
                height: 350, // 이미지의 세로 크기 설정
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                // 이미지를 저장하는 로직을 추가하세요
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // 버튼 배경색을 검정색으로 지정
                onPrimary: Colors.white, // 텍스트 색상을 흰색으로 지정
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 조정
                ),
              ),
              child: const Text(
                '사진 저장하기',
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
