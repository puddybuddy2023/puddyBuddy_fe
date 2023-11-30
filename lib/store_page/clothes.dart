import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/clothes_provider.dart';
import 'package:getwidget/getwidget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../providers/prefer_provider.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final List<dynamic> colors = [
    ['선택 안함', Colors.white, -1],
    ['블랙', Colors.black, 1],
    ['그레이', Colors.grey, 2],
    ['화이트', Colors.white, 3],
    ['블루', Colors.blue, 4],
    ['그린', Colors.green, 5],
    ['베이지', const Color(0xFFF0E68C), 6],
    ['네이비', const Color(0xFF000080), 7],
    ['핑크', Colors.pink, 8],
    ['브라운', Colors.brown, 9],
    ['옐로우', Colors.yellow, 10],
    ['퍼플', Colors.purple, 11],
    ['레드', Colors.red, 12],
    ['스카이블루', const Color(0xFF87CEEB), 13],
    ['라벤더', const Color(0xFFDFC5FE), 14],
    ['오렌지', Colors.orange, 15],
    ['민트', Colors.greenAccent, 16],
    ['카키', const Color(0xFFF0E68C), 17],
    ['와인', const Color(0xFF722F37), 18],
    ['기타', Colors.white, 19],
  ];

  String? selectedPrefer;
  int selectedColor = -1;
  bool isSwitched = false;
  int petsnalColorId = -1;
  //int personalcolorId = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // shape: Border(
        //   bottom: BorderSide(
        //     color: Colors.grey,
        //     width: 0.2,
        //   ),
        // ),
        title: const Text(
          'PuddyBuddy',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Inter',
              fontSize: 23,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 5,
            color: Colors.grey.shade100,
          ),
          Container(
            // filtering
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                FutureBuilder(
                    future: preferProvider.fetchPreferById(1),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final result = snapshot.data!;
                        return DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: const Text(
                              '펫컬',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            items: List.generate(result.length, (index) {
                              return DropdownMenuItem(
                                  value: result[index]['name'],
                                  child: Text(
                                    result[index]['name'],
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ));
                            }),
                            value: selectedPrefer,
                            onChanged: (value) {
                              setState(() {
                                selectedPrefer = value.toString();
                                print(selectedPrefer);
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              padding: const EdgeInsets.only(left: 8),
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFFA8ABFF),
                              ),
                            ),
                            iconStyleData: const IconStyleData(
                              iconSize: 28,
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFFA8ABFF),
                              ),
                              //offset: const Offset(0, 1),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 70,
                        );
                      }
                    }),
                const SizedBox(
                  width: 10,
                ),
                // GFToggle(
                //   value: isSwitched,
                //   onChanged: (value) {
                //     setState(() {
                //       isSwitched = value!;
                //       colorId = value ? 1 : -1;
                //       context
                //           .read<ClothesProvider>()
                //           .getClothesByClothesId2(colorId);
                //     });
                //   },
                //   enabledThumbColor: Colors.white,
                //   enabledTrackColor: Color(0xFFA8ABFF),
                //   enabledText: '펫컬',
                //   disabledText: '펫컬',
                //   // enabledTextStyle: TextStyle(
                //   //     fontWeight: FontWeight.w700, color: Colors.white),
                //   type: GFToggleType.ios,
                // ),
                // SizedBox(
                //   width: 10,
                // ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ColorSelectDialog(
                          colors: colors,
                          onColorSelected: (selectedColor) {
                            setState(() {
                              this.selectedColor = selectedColor;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: const Text(
                    '색상',
                    style: TextStyle(color: Colors.black), // 버튼 텍스트 색상
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // 버튼 모서리 둥글기 설정
                        side: const BorderSide(
                            color: Colors.black), // 테두리 색상 및 두께 설정
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      selectedColor == -1
                          ? colors[0][1]
                          : colors[selectedColor][1],
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(60.0, 20.0), // 버튼의 최소 너비와 높이 설정
                    ),
                  ),
                )
              ],
            ),
          ),
          /* 옷 목록 영역 */
          FutureBuilder(
              future: clothesProvider.clothesSearch(selectedColor),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // 데이터가 정상적으로 도착하면 여기서 UI를 만들어서 반환합니다.
                  final result = snapshot.data!;
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.32,
                      ),
                      itemCount: result.length,
                      itemBuilder: (c, index) {
                        return ClothesGridItem(itemData: result[index]);
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}

class ClothesGridItem extends StatelessWidget {
  final Map<String, dynamic> itemData;

  const ClothesGridItem({required this.itemData});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/clothesDetail', arguments: itemData);
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.black26.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              FutureBuilder<Map<dynamic, dynamic>>(
                future: clothesProvider.getClothesPhoto(itemData['clothesId']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    const CircularProgressIndicator();
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      // 에러가 있다면 에러 메시지를 보여줄 위젯
                      return const Center(
                          child: Text('이미지를 불러오는 중에 에러가 발생했어요.'));
                    } else {
                      // 데이터를 성공적으로 불러왔을 때 Container를 보여줄 위젯
                      final result = snapshot.data!;
                      return Container(
                        margin: const EdgeInsets.all(5),
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                          image: DecorationImage(
                            image: NetworkImage(
                                result['photourl1']), // 가져온 이미지로 설정
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              // Container(
              //   margin: EdgeInsets.all(5),
              //   width: 180,
              //   height: 180,
              //   decoration: BoxDecoration(
              //     color: Colors.grey,
              //     borderRadius: BorderRadius.circular(7),
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '가게 이름',
                      //itemData['storeName'].toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Text(
                      itemData['name'],
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorSelectDialog extends StatelessWidget {
  final List<dynamic> colors;
  final ValueChanged<int> onColorSelected;

  const ColorSelectDialog({
    required this.colors,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('색상 선택'),
      children: [
        SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            itemCount: colors.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1 / 1.1,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onColorSelected(colors[index][2]);
                  Navigator.pop(context);
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors[index][1],
                        ),
                      ),
                      Text(
                        colors[index][0],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
