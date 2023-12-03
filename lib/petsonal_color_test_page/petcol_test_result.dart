import 'package:flutter/material.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_widgets.dart';

class PetColResult extends StatelessWidget {
  const PetColResult({super.key});

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
              Material(
                elevation: 4, // elevation 정도
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 190,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Guideline',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text(
                                '<예시>',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 3), // 텍스트와 상자 사이 여백 조절
                              Container(
                                width: 110, // 가로 전체 사이즈로 설정
                                height: 110,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/petsnal_color/petsnalcolor_example.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: 250,
                            child: const Column(
                              children: [
                                Text(
                                  '1. 정면 사진을 업로드해주세요.\n2. 강아지가 사진의 중심에 위치하게 해주세요.',
                                  style: TextStyle(fontSize: 16),
                                  overflow: TextOverflow.clip,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
