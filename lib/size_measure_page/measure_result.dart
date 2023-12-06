import 'package:flutter/material.dart';
import 'package:mungshinsa/size_measure_page/size_info.dart';

import '../providers/size_measure_api.dart';

class MeasureResult extends StatefulWidget {
  const MeasureResult({super.key});

  @override
  State<MeasureResult> createState() => _MeasureResultState();
}

class _MeasureResultState extends State<MeasureResult> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5.0),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const CircleBorder(),
                ),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(30, 30)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                sizeInfo.clearInfo();
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("/measureStart"));
                Navigator.pop(context);
              },
              child: const Icon(
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
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 580,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            //padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
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
                                const Text(
                                  'RESULT',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 60,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: 'Inter'),
                                ),
                                const SizedBox(height: 140),
                                FutureBuilder(
                                  future: sizeMeasure.getSizeInfo(
                                      1, sizeInfo.petSizeId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // 로딩 중인 경우
                                      return Container(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, top: 50),
                                        height: 350,
                                        width: 370,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: const Column(
                                          children: [
                                            Text(
                                              '강아지의 사이즈가 같은 종 대비 상위 몇 프로인지 보여줍니다.',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      // 에러 발생 시
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      // 비동기 작업 완료 후
                                      return Container(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, top: 50),
                                        height: 350,
                                        width: 370,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: const Column(
                                          children: [
                                            Text(
                                              'data',
                                              style: TextStyle(
                                                  color: Colors.black26),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 125,
                            bottom: 290,
                            child: Image.asset(
                              'assets/images/standing_dog.png',
                              width: 230,
                              height: 230,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 캡쳐 동작 또는 원하는 기능 추가
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    '캡쳐하기',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
