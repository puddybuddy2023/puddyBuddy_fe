import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:mungshinsa/providers/prefer_provider.dart';
import 'package:mungshinsa/providers/breed_tags_provider.dart';

class CreatePrefer extends StatefulWidget {
  const CreatePrefer({super.key});

  @override
  State<CreatePrefer> createState() => _CreatePreferState();
}

class _CreatePreferState extends State<CreatePrefer> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _nameController = TextEditingController();
  late int selectedBreedTag;
  //TextEditingController _breedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            '반려견 등록',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black)),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    imageProfile(),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '이름',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextFormField(
                            controller: _nameController, // 컨트롤러 할당
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              //contentPadding: EdgeInsets.only(left: 10),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '이름을 입력해주세요';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            '종',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                              future: breedTagProvider.getBreedTags(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<dynamic> breedTags = snapshot.data!;
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 0.5)),
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '종을 선택해주세요',
                                      ),
                                      //value: studentResult.additionalPoint,
                                      items: List.generate(breedTags.length,
                                          (index) {
                                        return DropdownMenuItem(
                                            value: index,
                                            child: Text(breedTags[index]
                                                ['breedTagName']));
                                      }),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedBreedTag = value! + 1;
                                          print(selectedBreedTag);
                                        });
                                      },
                                      validator: (value) {
                                        if (value == 0) {
                                          return '종을 선택해주세요';
                                        }
                                        return null;
                                      },
                                    ),
                                  );
                                } else {
                                  return LinearProgressIndicator();
                                }
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            //Spacer(),
            Container(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    await preferProvider.createPrefer(
                        1, _nameController.text, selectedBreedTag);
                    Navigator.pop(context);
                    // setState(() {
                    //   // 데이터가 변경되었음을 알려서 페이지를 다시 그림
                    // });
                    //Navigator.of(context).pushReplacementNamed('/myPage');
                  },
                  child: Text('등록'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFA8ABFF)),
                )),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15),
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFFA8ABFF),
              image: DecorationImage(
                image: _imageFile == null
                    ? AssetImage('assets/images/dog_profile.png')
                    : FileImage(File(_imageFile!.path))
                        as ImageProvider<Object>,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              bottom: -10,
              right: -10,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()));
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFA8ABFF),
                      border: Border.all(
                        color: Colors.white, // 테두리 색상
                        width: 3, // 테두리 두께
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                  )))
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            Text(
              '프로필 사진 선택',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.camera,
                    size: 50,
                  ),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  //label: Text('Camera', style: TextStyle(fontSize: 20),),
                ),
                IconButton(
                  icon: Icon(
                    Icons.photo_library,
                    size: 50,
                  ),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  //label: Text('Gallery', style: TextStyle(fontSize: 20),),
                )
              ],
            )
          ],
        ));
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
