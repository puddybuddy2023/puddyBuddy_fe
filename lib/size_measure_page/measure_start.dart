import 'dart:io';
import 'package:flutter/material.dart';

import 'neck_measure.dart';

class SizeMeasureStart extends StatefulWidget {
  const SizeMeasureStart({super.key});

  @override
  State<SizeMeasureStart> createState() => _SizeMeasureStartState();
}

List<String> guideLine = [
  '강아지가 정면을 응시하면서 똑바로 서 있는 자세를 유지한 상태에서 치수를 재야 합니다.',
  '치수는 한 번 재기보다 시간 간격을 두고 여러 번 잰 후 평균치를 사용하는 것이 좋습니다.',
  '성장기인 강아지는 치수가 계속 변하기 때문에 수시로 사이즈를 측정해야 합니다. 사이즈 측정시 여유분이 충분한지도 확인해봐야 합니다.',
  '특히 털이 많은 견종들과 미용상태에 따라서도 사이즈가 변화하니 털의 부피감까지 고려하여 치수를 재는 것이 좋습니다.'
];

class _SizeMeasureStartState extends State<SizeMeasureStart> {
  final PageController controller = PageController(initialPage: 0);
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: SizedBox.shrink(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: Text(
          //   'SIZE',
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontFamily: 'Inter',
          //   ),
          // ),
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
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
                colors: [
                  Color(0xFF858AFF),
                  Color(0xFF9492FF),
                  Color(0xFFBFA8FF)
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 170,
                ),
                Container(
                  // 카드 슬라이더
                  height: 380,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      PageView.builder(
                          controller: controller,
                          itemCount: 4,
                          onPageChanged: (page) {
                            setState(() {
                              currentPage = page;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              //padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xFFA6A6A6FF),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 3,
                                        spreadRadius: 3,
                                        offset: const Offset(0, 1))
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'GUIDELINE',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 48,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'Inter'),
                                  ),
                                  SizedBox(height: 130),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 50),
                                    height: 170,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      guideLine[index],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                      Positioned(
                        left: 135,
                        bottom: 110,
                        child: Image.asset(
                          'assets/images/standing_dog.png',
                          width: 200,
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (num i = 0; i < 4; i++)
                      Container(
                        margin: const EdgeInsets.all(3),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i == currentPage
                                ? const Color(0xffffffffff)
                                : Colors.black.withOpacity(.2)),
                      ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NeckMeasure(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // 모서리를 조절해요
                    ),
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.8, 50),
                  ),
                  child: Text('측정 시작'),
                ),
              ],
            )));
  }
}
