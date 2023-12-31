import 'package:flutter/material.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_widgets.dart';
import 'package:mungshinsa/petsonal_color_test_page/test_info.dart';

class PetColResult extends StatefulWidget {
  const PetColResult({super.key});

  @override
  State<PetColResult> createState() => _PetColResultState();
}

class _PetColResultState extends State<PetColResult> {
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
              colors: [Color(0xFF858AFF), Color(0xFF9492FF), Color(0xFFBFA8FF)],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 130,
              ),
              Image.asset('assets/images/petsnal_color/petcol_title.png'),
              Padding(
                padding: EdgeInsets.only(left: 40.0, right: 40, top: 40),
                child: Material(
                  elevation: 4, // elevation 정도
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 380,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        if (testInfo.images['result'] == 1)
                          Column(
                            children: [
                              Text(
                                'Petsnal Color',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 33,
                                    fontFamily: 'Inter',
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                '우리 강아지에게 어울리는 색은?',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 230, // 가로 전체 사이즈로 설정
                                    height: 280,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/petsnal_color/spring.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (testInfo.images['result'] == 2)
                          Column(
                            children: [
                              Text(
                                'Petsnal Color',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 33,
                                    fontFamily: 'Inter',
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                '우리 강아지에게 어울리는 색은?',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 230, // 가로 전체 사이즈로 설정
                                    height: 280,
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/petsnal_color/summer.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (testInfo.images['result'] == 3)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Petsnal Color',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 33,
                                        fontFamily: 'Inter',
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Text(
                                    '우리 강아지에게 어울리는 색은?',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    width: 230, // 가로 전체 사이즈로 설정
                                    height: 280,
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/petsnal_color/fall.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (testInfo.images['result'] == 4)
                          Column(
                            children: [
                              Text(
                                'Petsnal Color',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 33,
                                    fontFamily: 'Inter',
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                '우리 강아지에게 어울리는 색은?',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 230, // 가로 전체 사이즈로 설정
                                    height: 280,
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/petsnal_color/winter.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     // MaterialPageRoute(
              //     //   builder: (context) => Question1(),
              //     // );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.black,
              //     onPrimary: Colors.white,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30), // 모서리를 조절해요
              //     ),
              //     minimumSize:
              //         Size(MediaQuery.of(context).size.width * 0.5, 50),
              //   ),
              //   child: const Text(
              //     '캡쳐하기',
              //     style: TextStyle(fontSize: 16),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
