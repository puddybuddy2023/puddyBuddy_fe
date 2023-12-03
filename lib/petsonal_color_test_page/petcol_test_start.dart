import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mungshinsa/petsonal_color_test_page/petcol_test_widgets.dart';
import 'package:mungshinsa/petsonal_color_test_page/test_info.dart';

import '../providers/petsnal_color_provider.dart';
import 'petcol_test_stage1.dart';

final ImagePicker picker = ImagePicker();
XFile? selectImage;
XFile? showImage;

class PetsnalColorStartPage extends StatefulWidget {
  const PetsnalColorStartPage({super.key});

  @override
  State<PetsnalColorStartPage> createState() => _PetsnalColorStartPageState();
}

class _PetsnalColorStartPageState extends State<PetsnalColorStartPage> {
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
              height: 80,
            ),
            const Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15, top: 25),
                child: GuidelinePanel()),
            const SizedBox(
              height: 50,
            ),
            if (showImage == null)
              DottedBorder(
                dashPattern: [9, 8],
                color: Colors.white,
                strokeWidth: 3,
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: IconButton(
                            onPressed: () async {
                              selectImage = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              setState(() {
                                if (selectImage != null) {
                                  showImage = selectImage;
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            if (showImage != null)
              Stack(
                //alignment: Alignment.topRight,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(showImage!
                                    .path // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                                )))),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      //삭제 버튼
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.close,
                            color: Colors.white, size: 15),
                        onPressed: () {
                          //버튼을 누르면 해당 이미지가 삭제됨
                          setState(() {
                            showImage = null;
                          });
                        },
                      ))
                ],
              ),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                if (showImage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('사진을 선택해주세요'),
                    duration: Duration(seconds: 2), //올라와있는 시간
                  ));
                } else {
                  petsnalColorProvider.PetsnalColorStart(showImage, 1)
                      .then((Map<dynamic, dynamic> result) {
                    testInfo.images = result;
                    testInfo.currentStage = result['nextStage'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Question1(),
                      ),
                    );
                  }).catchError((error) {
                    // 에러 처리 로직
                    print('Error: $error');
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // 모서리를 조절해요
                ),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 45),
              ),
              child: const Text(
                '테스트 시작하기',
                style: TextStyle(fontSize: 16),
              ),
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
    return Material(
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
    );
  }
}
