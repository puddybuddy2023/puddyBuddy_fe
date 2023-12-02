import 'package:flutter/material.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_widgets.dart';

class Stage1 extends StatelessWidget {
  final Future<Map<dynamic, dynamic>> argument;
  const Stage1({required this.argument, Key? key}) : super(key: key);

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
                    FutureBuilder<Map<dynamic, dynamic>>(
                        future: argument,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Scaffold(
                              body: Center(
                                  child: Text('Error: ${snapshot.error}')),
                            );
                          } else {
                            final Map<dynamic, dynamic> data = snapshot.data!;
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 5, right: 9, top: 5, bottom: 5),
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      data['photoUrlList'][0]), // 가져온 이미지로 설정
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 버튼 클릭 시 수행할 작업을 여기에 추가하세요.
                  },
                  child: Text(
                    '건강한 이미지다.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // 버튼 배경색
                    onPrimary: Colors.black, // 텍스트 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // 버튼 모양
                    ),
                    fixedSize: Size(250, 40),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 버튼 클릭 시 수행할 작업을 여기에 추가하세요.
                  },
                  child: Text(
                    '약간 건강해 보인다.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // 버튼 배경색
                    onPrimary: Colors.black, // 텍스트 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // 버튼 모양
                    ),
                    fixedSize: Size(250, 40),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 버튼 클릭 시 수행할 작업을 여기에 추가하세요.
                  },
                  child: Text(
                    '건강한 이미지다.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // 버튼 배경색
                    onPrimary: Colors.black, // 텍스트 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // 버튼 모양
                    ),
                    fixedSize: Size(250, 40),
                  ),
                ),
              ],
            )));
  }
}

class testDetail extends StatelessWidget {
  const testDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
