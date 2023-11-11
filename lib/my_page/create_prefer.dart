import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mungshinsa/providers/prefer_provider.dart';

class CreatePrefer extends StatefulWidget {
  const CreatePrefer({super.key});

  @override
  State<CreatePrefer> createState() => _CreatePreferState();
}

class _CreatePreferState extends State<CreatePrefer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          margin: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                        ),
                      ],
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
}
