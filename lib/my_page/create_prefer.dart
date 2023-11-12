import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:mungshinsa/providers/prefer_provider.dart';

class CreatePrefer extends StatefulWidget {
  const CreatePrefer({super.key});

  @override
  State<CreatePrefer> createState() => _CreatePreferState();
}

class _CreatePreferState extends State<CreatePrefer> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _breedController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('반려견 등록', style: TextStyle(color: Colors.black),),
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
                      height: 20,
                    ),
                    SizedBox(height: 60,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '이름',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextFormField(
                            //controller: _reviewController, // 컨트롤러 할당
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
                          SizedBox(height: 30,),
                          Text(
                            '종',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextFormField(
                            //controller: _reviewController, // 컨트롤러 할당
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              //contentPadding: EdgeInsets.only(left: 10),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '종을 입력해주세요';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  child: Text('등록'),
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFFA8ABFF)),
                )),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 60,
            backgroundColor: Color(0xFFA8ABFF),
            backgroundImage: _imageFile == null ? AssetImage('assets/images/dog_profile.png') : FileImage(File(_imageFile!.path)) as ImageProvider<Object>,
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey,
                  size: 40,
                ),
              )
          )
        ],
      ),
    );
  }

  // Widget nameTextField() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         border: OutlineInputBorder(
  //           borderSide: BorderSide(
  //             color: Colors.grey,
  //           ),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //             color: Colors.grey,
  //             width: 2,
  //           ),
  //         ),
  //         prefixIcon: Icon(
  //           Icons.person,
  //           color: Colors.grey,
  //         ),
  //         labelText: 'Name',
  //         hintText: 'Input your name'
  //     ),
  //   );
  // }

  Widget bottomSheet() {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20
        ),
        child: Column(
          children: <Widget>[
            Text(
              'Choose Profile photo',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.camera, size: 50,),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  //label: Text('Camera', style: TextStyle(fontSize: 20),),
                ),
                IconButton(
                  icon: Icon(Icons.photo_library, size: 50,),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  //label: Text('Gallery', style: TextStyle(fontSize: 20),),
                )
              ],
            )
          ],
        )
    );
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}


