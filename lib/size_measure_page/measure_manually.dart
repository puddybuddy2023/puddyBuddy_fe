import 'package:flutter/material.dart';

class MeasureManually extends StatefulWidget {
  const MeasureManually({super.key});

  @override
  State<MeasureManually> createState() => _MeasureManuallyState();
}

class _MeasureManuallyState extends State<MeasureManually> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: SizedBox.shrink(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '직접 측정',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Inter',
          ),
        ),
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
              },
              child: Icon(
                Icons.close,
                color: Colors.white, // 아이콘 색상을 하얀색으로 변경합니다.
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
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GuidelinePanel(),
            ),
          ],
        ),
      ),
    );
  }
}

class GuidelinePanel extends StatelessWidget {
  const GuidelinePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 4, // elevation 정도
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 470,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Text(
                  '사이즈 측정 시 유의사항',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '<예시>',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 3), // 텍스트와 상자 사이 여백 조절
                    Container(
                      width: 200, // 가로 전체 사이즈로 설정
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/size_manually_guideline.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: 380,
                  child: Column(
                    children: [
                      Text(
                        '1. 강아지가 정면을 응시하면서 똑바로 서 있는 자세를 유지한 상태에서 치수를 재야 합니다.\n2. 치수는 한 번 재기보다 시간 간격을 두고 여러 번 잰 후 평균치를 사용하는 것이 좋습니다.\n3. 성장기인 강아지는 치수가 계속 변하기 때문에 수시로 사이즈를 측정해야 합니다.4. 사이즈 측정시 여유분이 충분한지도 확인해봐야 합니다.\n 5.털이 많은 견종들과 미용상태에 따라서도 사이즈가 변화하니 털의 부피감까지 고려하여 치수를 재는 것이 좋습니다.',
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => SizeMeasureStartPage()),
            // );
          },
          child: Text('측정 시작'),
          style: ElevatedButton.styleFrom(
            primary: Colors.black, // 배경색 설정

            padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 15), // 버튼 내부 패딩
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // 버튼 모서리를 둥글게 설정
            ),
          ),
        ),
      ],
    );
  }
}
