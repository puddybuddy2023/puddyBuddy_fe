import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_result.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_widgets.dart';
import 'package:mungshinsa/petsonal_color_test_page/test_info.dart';

import '../providers/petsnal_color_provider.dart';

class Stage3Q1 extends StatefulWidget {
  const Stage3Q1({
    super.key,
  });

  @override
  State<Stage3Q1> createState() => _Stage3Q1State();
}

class _Stage3Q1State extends State<Stage3Q1> {
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const PetcolTestAppBar(),
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
                  height: 180,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 5, right: 9, top: 5, bottom: 5),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            image: DecorationImage(
                              image: NetworkImage(testInfo
                                  .images['photoUrlList'][0]), // 가져온 이미지로 설정
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 5, right: 9, top: 5, bottom: 5),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            image: DecorationImage(
                              image: NetworkImage(testInfo
                                  .images['photoUrlList'][1]), // 가져온 이미지로 설정
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 5, right: 9, top: 5, bottom: 5),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            image: DecorationImage(
                              image: NetworkImage(testInfo
                                  .images['photoUrlList'][2]), // 가져온 이미지로 설정
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selected = 0;
                    });
                  },
                  child: Text(
                    '왼쪽',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: selected == 0 ? Colors.black : Colors.white,
                    onPrimary: selected == 0 ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    fixedSize: Size(250, 40),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selected = 1;
                    });
                  },
                  child: Text(
                    '중간',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: selected == 1 ? Colors.black : Colors.white,
                    onPrimary: selected == 1 ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    fixedSize: Size(250, 40),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selected = 2;
                    });
                  },
                  child: Text(
                    '오른쪽',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: selected == 2 ? Colors.black : Colors.white,
                    onPrimary: selected == 2 ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    fixedSize: Size(250, 40),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selected == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('문항을 선택해주세요'),
                        duration: Duration(seconds: 2), //올라와있는 시간
                      ));
                    } else {
                      print(selected);
                      testInfo.addToResultList(selected);
                      petsnalColorProvider.PetsnalColorStage(
                              testInfo.currentStage, 1, testInfo.resultList)
                          .then((Map<dynamic, dynamic> result) {
                        testInfo.images = result;
                        // 이후에 원하는 다른 로직을 수행
                      }).catchError((error) {
                        // 에러 처리 로직
                        print('Error: $error');
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PetColResult(),
                        ),
                      );
                    }
                  },
                  child: Text(
                    '결과 보기',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // 버튼 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // 버튼 모양
                    ),
                    fixedSize: Size(20, 40),
                  ),
                ),
              ],
            )));
  }
}
