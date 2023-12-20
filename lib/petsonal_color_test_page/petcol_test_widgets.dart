import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../providers/petsnal_color_api.dart';
import 'test_info.dart';

class PetcolTestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PetcolTestAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: SizedBox.shrink(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      // title: Text(
      //   'PETSNAL TEST',
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
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            ),
            onPressed: () {
              testInfo.clearScore();
              testInfo.clearResultList();
              testInfo.clearPreferId();
              Navigator.of(context)
                  .popUntil(ModalRoute.withName("/petsnalColorStart"));
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class QuestionPage extends StatefulWidget {
  final int imageNum;
  final List<String> choices;
  final Widget nextPage;
  const QuestionPage(
      {super.key,
      required this.imageNum,
      required this.choices,
      required this.nextPage});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const PetcolTestAppBar(),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                  height: 180,
                ),
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 140.0),
                            child: Container(
                              color: Colors.white,
                              height:
                                  MediaQuery.of(context).size.height * 0.454,
                            )),
                        Positioned(
                          top: 70,
                          left: -25,
                          child: ClipOval(
                            child: Container(
                              width: MediaQuery.of(context).size.width + 50,
                              height: 150.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: -100,
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 5, right: 9, top: 5, bottom: 5),
                            width: 270,
                            height: 270,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                image: NetworkImage(
                                    testInfo.images['photoUrlList']
                                        [widget.imageNum]), // 가져온 이미지로 설정
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 250,
                          left: 50,
                          child: Container(
                            // 버튼들 들어있는 container
                            color: Colors.white,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selected = 2;
                                    });
                                  },
                                  child: Text(
                                    widget.choices[0],
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
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selected = 1;
                                    });
                                  },
                                  child: Text(
                                    widget.choices[1],
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
                                      selected = 0;
                                    });
                                  },
                                  child: Text(
                                    widget.choices[2],
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
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (selected == -1) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('문항을 선택해주세요'),
                                        duration:
                                            Duration(seconds: 2), //올라와있는 시간
                                      ));
                                    } else {
                                      testInfo.addToResultList(selected);

                                      if (widget.imageNum % 2 == 0) {
                                        // imageNum이 홀수인 경우
                                        testInfo.increaseWCL(selected);
                                      } else {
                                        testInfo.increaseCDH(selected);
                                      }

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => widget.nextPage,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    '다음',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black, // 버튼 배경색
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0), // 버튼 모양
                                    ),
                                    fixedSize: Size(20, 40),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            )));
  }
}

class AdditionalQuestion extends StatefulWidget {
  final int imageNum;
  //final List<String> choices;
  final Widget nextPage;
  const AdditionalQuestion(
      {super.key,
      required this.imageNum,
      //required this.choices,
      required this.nextPage});

  @override
  State<AdditionalQuestion> createState() => _AdditionalQuestionState();
}

class _AdditionalQuestionState extends State<AdditionalQuestion> {
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
                  height: 100,
                ),
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 220.0),
                            child: Container(
                              color: Colors.white,
                              height:
                                  MediaQuery.of(context).size.height * 0.454,
                            )),
                        Positioned(
                          top: 150,
                          left: -25,
                          child: ClipOval(
                            child: Container(
                              width: MediaQuery.of(context).size.width + 50,
                              height: 150.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 15,
                          top: 10,
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 9, top: 5, bottom: 5),
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          testInfo.images['photoUrlList']
                                              [widget.imageNum]), // 가져온 이미지로 설정
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 9, top: 5, bottom: 5),
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    image: DecorationImage(
                                      image: NetworkImage(testInfo
                                              .images['photoUrlList']
                                          [widget.imageNum + 1]), // 가져온 이미지로 설정
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Positioned(
                          top: 300,
                          left: 60,
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
                                        ? Colors.black
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
                                    '오른쪽',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: selected == 1
                                        ? Colors.black
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
                                SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (selected == -1) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('문항을 선택해주세요'),
                                        duration:
                                            Duration(seconds: 2), //올라와있는 시간
                                      ));
                                    } else {
                                      print(selected);
                                      testInfo.addToResultList(selected);
                                      petsnalColorProvider.PetsnalColorStage(
                                              testInfo.currentStage,
                                              1,
                                              testInfo.resultList)
                                          .then((Map<dynamic, dynamic> result) {
                                        testInfo.images = result;
                                        print(testInfo.images);
                                        // 이후에 원하는 다른 로직을 수행
                                      }).catchError((error) {
                                        // 에러 처리 로직
                                        print('Error: $error');
                                      });
                                      testInfo.clearScore();
                                      testInfo.clearResultList();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => widget.nextPage,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    '다음',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black, // 버튼 배경색
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0), // 버튼 모양
                                    ),
                                    fixedSize: Size(20, 40),
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
