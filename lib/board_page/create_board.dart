import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../providers/board_provider.dart';
import '../providers/clothes_provider.dart';
import '../providers/prefer_provider.dart';
import '../user_info.dart';
import 'clothes_select.dart';

final ImagePicker picker = ImagePicker();
// List<XFile?> multiImage = []; // 갤러리에서 여러 장의 사진을 선택해서 저장할 변수
//List<XFile?> showImage = []; // 가져온 사진들을 보여주기 위한 변수

class WriteNewBoard extends StatefulWidget {
  const WriteNewBoard({super.key});

  @override
  State<WriteNewBoard> createState() => _WriteNewBoardState();
}

class _WriteNewBoardState extends State<WriteNewBoard> {
  XFile? selectImage;
  XFile? showImage;
  Map<String, dynamic>? selectedClothes;
  TextEditingController _reviewController = TextEditingController();
  List<dynamic> prefers = preferProvider.getPreferListByUserId(1);
  int selectedPrefer = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    if (showImage == null)
                      Container(
                          height: 100,
                          width: 100,
                          // 사진 추가 버튼
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA8ABFF),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.5,
                                  blurRadius: 5)
                            ],
                          ),
                          child: IconButton(
                              onPressed: () async {
                                selectImage = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                setState(() {
                                  //갤러리에서 가지고 온 사진들은 리스트 변수에 저장되므로 addAll()을 사용해서 images와 multiImage 리스트를 합쳐준다.
                                  //showImage.addAll(multiImage);
                                  if (selectImage != null) {
                                    // 사진을 선택한 경우에만 출력할 사진 갱신. 아니면 사진을 선택하지 않고 선택창을 닫으면 이미 선택된 사진 사라짐
                                    showImage = selectImage;
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 30,
                                color: Colors.white,
                              ))),
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: 100,
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: showImage == null ? 0 : 1,
                        //보여줄 item 개수. images 리스트 변수에 담겨있는 사진 수 만큼.
                        itemBuilder: (BuildContext context, int index) {
                          // 사진 오른 쪽 위 삭제 버튼을 표시하기 위해 Stack을 사용함
                          return Stack(
                            //alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(File(showImage!
                                                .path // images 리스트 변수 안에 있는 사진들을 순서대로 표시함
                                            )))),
                              ),
                              Container(
                                  //삭제 버튼
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(Icons.close,
                                        color: Colors.white, size: 15),
                                    onPressed: () {
                                      //버튼을 누르면 해당 이미지가 삭제됨
                                      setState(() {
                                        //showImage.remove(showImage[index]);
                                        showImage = null;
                                      });
                                    },
                                  ))
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    minLines: 5,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    controller: _reviewController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          // 외곽선 테두리 스타일 설정
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(0), // 모서리 둥글기 설정
                        ),
                        //contentPadding: EdgeInsets.only(top: 10, left: 10),
                        hintText: '리뷰를 입력해주세요'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '리뷰를 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: FutureBuilder(
                      future: preferProvider.fetchPreferById(userInfo.userId!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final result = snapshot.data!;
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                // 외곽선 테두리 스타일 설정
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1),
                                borderRadius:
                                    BorderRadius.circular(0), // 모서리 둥글기 설정
                              ),
                              hintText: '누구의 사진인가요?',
                            ),
                            items: List.generate(result.length, (index) {
                              return DropdownMenuItem(
                                  value: index,
                                  child: Text(result[index]['name']));
                            }),
                            onChanged: (value) {
                              selectedPrefer = result[value!]['preferId'];
                              print(selectedPrefer);
                            },
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
                /* 착용 제품 선택 영역 */
                if (selectedClothes == null)
                  Container(
                      margin: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 80,
                      child: ElevatedButton(
                        onPressed: () async {
                          final data = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ClothesSelect(), // 이동할 페이지의 Widget
                            ),
                          );
                          if (data != null) {
                            setState(() {
                              selectedClothes =
                                  data; // 선택한 값으로 selectedClothes 업데이트
                            });
                          }
                        },
                        child: const Text('착용 제품 선택'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA8ABFF)),
                      )),
                if (selectedClothes != null)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    color: Color(0xFFA8ABFF),
                    child: Container(
                      height: 80,
                      child: Row(
                        children: [
                          FutureBuilder<Map<dynamic, dynamic>>(
                            future: clothesProvider
                                .getClothesPhoto(selectedClothes!['clothesId']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                const CircularProgressIndicator();
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                if (snapshot.hasError) {
                                  // 에러가 있다면 에러 메시지를 보여줄 위젯
                                  return const Center(
                                      child: Text('이미지를 불러오는 중에 에러가 발생했어요.'));
                                } else {
                                  // 데이터를 성공적으로 불러왔을 때 Container를 보여줄 위젯
                                  final photoResult = snapshot.data!;
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 9, top: 5, bottom: 5),
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(7),
                                      image: DecorationImage(
                                        image: NetworkImage(photoResult[
                                            'photourl1']), // 가져온 이미지로 설정
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedClothes!['storeName'],
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                selectedClothes!['name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                selectedClothes!['personalColor'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            margin: const EdgeInsets.all(5),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/shop_arrow.png'), // 가져온 이미지로 설정
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 210,
                ),
                /* 업로드 버튼 */
                Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (showImage == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('사진을 선택해주세요'),
                            duration: Duration(seconds: 2), //올라와있는 시간
                          ));
                        } else if (_reviewController.text == '') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('리뷰를 입력해주세요'),
                            duration: Duration(seconds: 2), //올라와있는 시간
                          ));
                        } else if (selectedPrefer == -1) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('강아지를 선택해주세요'),
                            duration: Duration(seconds: 2), //올라와있는 시간
                          ));
                        } else {
                          boardProvider.createBoard(
                              showImage,
                              userInfo.userId!,
                              selectedPrefer,
                              selectedClothes!['clothesId'],
                              _reviewController.text);
                          Navigator.pop(context); // 현재 페이지 닫기
                        }
                      },
                      child: const Text('업로드'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                    )),
              ],
            ),
          ),
        ));
  }
}
