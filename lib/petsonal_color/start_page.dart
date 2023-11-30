import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/petsnal_color_provider.dart';
import 'test_page.dart';

final ImagePicker picker = ImagePicker();
XFile? selectImage;
XFile? showImage;

class PetsonalColorStartPage extends StatefulWidget {
  const PetsonalColorStartPage({super.key});

  @override
  State<PetsonalColorStartPage> createState() => _PetsonalColorStartPageState();
}

class _PetsonalColorStartPageState extends State<PetsonalColorStartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        CircleBorder(),
                      ),
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
            // Text(
            //   'PETSNAL COLOR TEST',
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 25,
            //       fontWeight: FontWeight.w900,
            //       fontStyle: FontStyle.italic,
            //       fontFamily: 'Inter'),
            // ),
            Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 25),
                child: GuidelinePanel()),
            SizedBox(
              height: 50,
            ),
            if (showImage == null)
              DottedBorder(
                dashPattern: [9, 8],
                color: Colors.white,
                strokeWidth: 3,
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.all(
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
                            icon: Icon(
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

            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                petsnalColorProvider.PetsnalColorStart(showImage, 1);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Stage1()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 모서리를 조절해요
                ),
              ),
              child: Text('테스트 시작'),
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
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 190,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Guideline',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      '<예시>',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8), // 텍스트와 상자 사이 여백 조절
                    Container(
                      width: 110, // 가로 전체 사이즈로 설정
                      height: 110, // 상자의 높이 설정
                      color: Colors.grey, // 회색으로 설정
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: 250,
                  child: Column(
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
