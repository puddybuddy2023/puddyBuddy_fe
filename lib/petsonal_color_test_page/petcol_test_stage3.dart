import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_result.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_widgets.dart';
import 'package:mungshinsa/petsonal_color_test_page/test_info.dart';

import '../loading.dart';
import '../providers/petsnal_color_api.dart';

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
                const SizedBox(
                  height: 80,
                ),
                Image.asset('assets/images/petsnal_color/petcol_title.png'),
                SizedBox(
                  height: 150,
                ),
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 150.0),
                            child: Container(
                              color: Colors.white,
                              height:
                                  MediaQuery.of(context).size.height * 0.477,
                            )),
                        Positioned(
                          top: 80,
                          left: 0,
                          child: ClipOval(
                            child: Container(
                              width: MediaQuery.of(context).size.width + 50,
                              height: 150.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 9, top: 5, bottom: 5),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        testInfo.images['photoUrlList']
                                            [0]), // 가져온 이미지로 설정
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 9, top: 5, bottom: 5),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        testInfo.images['photoUrlList']
                                            [1]), // 가져온 이미지로 설정
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 5, right: 9, top: 5, bottom: 5),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        testInfo.images['photoUrlList']
                                            [2]), // 가져온 이미지로 설정
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Positioned(
                          top: 250,
                          left: 50,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
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
                                    primary: selected == 0
                                        ? Color(0xFFA8ABFF)
                                        : Colors.white,
                                    onPrimary: selected == 0
                                        ? Colors.white
                                        : Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                          color: Colors.black26, width: 0.5),
                                    ),
                                    fixedSize: Size(300, 40),
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
                                    primary: selected == 1
                                        ? Color(0xFFA8ABFF)
                                        : Colors.white,
                                    onPrimary: selected == 1
                                        ? Colors.white
                                        : Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                          color: Colors.black26, width: 0.5),
                                    ),
                                    fixedSize: Size(300, 40),
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
                                    primary: selected == 2
                                        ? Color(0xFFA8ABFF)
                                        : Colors.white,
                                    onPrimary: selected == 2
                                        ? Colors.white
                                        : Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                          color: Colors.black26, width: 0.5),
                                    ),
                                    fixedSize: Size(300, 40),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (selected == -1) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('문항을 선택해주세요'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      print(selected);
                                      testInfo.addToResultList(selected);
                                      try {
                                        Map<dynamic, dynamic> result =
                                            await petsnalColorProvider
                                                .PetsnalColorStage(
                                          testInfo.currentStage,
                                          testInfo.preferId!,
                                          testInfo.resultList,
                                        );
                                        testInfo.clearImageMap();
                                        testInfo.images = result;
                                        // 이후에 원하는 다른 로직을 수행

                                        // Future가 완료된 후에 페이지 이동을 수행합니다.
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LoadingWithNextPage(
                                              nextPage: PetColResult(),
                                              duration: 2,
                                            ),
                                          ),
                                        );
                                      } catch (error) {
                                        // 에러 처리 로직
                                        print('Error: $error');
                                      }
                                    }
                                  },
                                  child: Text(
                                    '결과 보기',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black, // 버튼 배경색
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0), // 버튼 모양
                                    ),
                                    fixedSize: Size(120, 50),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )));
  }
}
