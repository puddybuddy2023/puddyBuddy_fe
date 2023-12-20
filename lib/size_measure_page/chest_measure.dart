import 'package:flutter/material.dart';
import 'package:mungshinsa/size_measure_page/size_info.dart';

import 'back_measure.dart';
import 'chest_measure.dart';

class ChestMeasure extends StatefulWidget {
  const ChestMeasure({super.key});

  @override
  State<ChestMeasure> createState() => _ChestMeasureState();
}

class _ChestMeasureState extends State<ChestMeasure> {
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
        leading: SizedBox.shrink(),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                sizeInfo.clearInfo();
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("/measureStart"));
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
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '⚠️ 강아지가 숨을 쉬는 것에 따라 치수 차이가 있으므로 여러 번 측정해 평균 치수를 사용합니다.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            width: 310,
                            height: 80,
                            //padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 3,
                                      spreadRadius: 3,
                                      offset: const Offset(0, 1))
                                ])),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 390,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
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
                                      'CHEST SIZE',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 43,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Inter'),
                                    ),
                                    SizedBox(height: 150),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20, top: 50),
                                      height: 170,
                                      width: 310,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        '강아지가 옆으로 서 있을 때 몸통에서 가장 굵은 부분을 여유 없이 잽니다.가슴둘레가 잘 맞아야 강아지가 편안함을 느끼므로 정확한 사이즈가 필요합니다.',
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 125,
                                bottom: 110,
                                child: Image.asset(
                                  'assets/size_measure/chest.png',
                                  width: 230,
                                  height: 230,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller:
                          _textEditingController, // TextEditingController 연결
                      decoration: InputDecoration(
                        hintText: '가슴둘레를 입력해주세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sizeInfo.chest =
                          double.parse(_textEditingController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BackMeasure()),
                      );
                    }
                  },
                  child: Text('다음'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // 배경색 설정

                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15), // 버튼 내부 패딩
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 버튼 모서리를 둥글게 설정
                    ),
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
