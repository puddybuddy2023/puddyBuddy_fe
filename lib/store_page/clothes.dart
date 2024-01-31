import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/clothes_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../providers/prefer_provider.dart';
import '../user_info.dart';
import '../widgets.dart';

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
    ['카키', const Color(0xFF4B6145), 17],
    ['와인', const Color(0xFF722F37), 18],
    ['기타', Colors.white, 19],
  ];

  List<String> sizes = ['XS', 'S', 'M', 'L', 'XL'];

  String? selectedPrefer;
  String? selectedSize;
  int petsnalColorId = -1;
  int selectedColorId = -1;
  //bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TitleAppBar(),
      body: Column(
        children: [
          Container(
            height: 5,
            color: Colors.grey.shade200,
          ),
          Container(
            // filtering
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                FutureBuilder(
                    future: preferProvider.fetchPreferById(userInfo.userId!),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final result = snapshot.data!;
                        return PetColFilteringDropdownButton(
                          result: result,
                          selectedPrefer: selectedPrefer,
                          onChanged: (value) {
                            setState(() {
                              selectedPrefer = value;
                              int.parse(value!) - 1 == -1
                                  ? petsnalColorId = 1
                                  : petsnalColorId =
                                      result[int.parse(value) - 1]
                                          ['personalColorId'];
                            });
                          },
                          petsnalColorId: petsnalColorId,
                        );
                      } else {
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
                            items: List.generate(1, (index) {
                              return DropdownMenuItem(
                                value: '0',
                                child: Text(
                                  '반려견을 등록해주세요',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              );
                            }),
                            value: selectedPrefer,
                            onChanged: (value) {
                              setState(() {
                                selectedPrefer = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              padding: const EdgeInsets.only(left: 5),
                              height: 30,
                              width: 85,
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
                              padding: EdgeInsets.all(0),
                              maxHeight: 200,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xFFA8ABFF),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
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
                              this.selectedColorId = selectedColor;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: const Text(
                    '색상',
                    style: TextStyle(color: Colors.black54), // 버튼 텍스트 색상
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // 버튼 모서리 둥글기 설정
                        side: const BorderSide(
                            color: Colors.black54,
                            width: 0.7), // 테두리 색상 및 두께 설정
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      selectedColorId == -1
                          ? colors[0][1]
                          : colors[selectedColorId][1],
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(60.0, 20.0), // 버튼의 최소 너비와 높이 설정
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: const Text(
                      '사이즈',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                      ),
                    ),
                    items: List.generate(6, (index) {
                      if (index == 0) {
                        return DropdownMenuItem(
                          value: '0',
                          child: Text(
                            '사이즈',
                            style: const TextStyle(
                                color: Colors.black38, fontSize: 14),
                          ),
                        );
                      } else {
                        return DropdownMenuItem(
                          value: index.toString(),
                          child: Text(
                            sizes[index - 1],
                            style: const TextStyle(
                                color: Colors.black38, fontSize: 14),
                          ),
                        );
                      }
                    }),
                    value: selectedPrefer,
                    onChanged: (value) {
                      setState(() {
                        selectedSize = value.toString();
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.only(left: 5),
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black38,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      iconSize: 28,
                      iconEnabledColor: Colors.black38,
                      iconDisabledColor: Colors.black38,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      padding: EdgeInsets.all(0),
                      maxHeight: 200,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 5,
            color: Colors.grey.shade200,
          ),
          /* 옷 목록 영역 */
          FutureBuilder(
              future: clothesProvider.clothesSearch(
                  selectedColorId, -1, petsnalColorId, -1),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final result = snapshot.data!;
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.33,
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

/* 펫스널컬러 필터링 Dropdowm Button */
class PetColFilteringDropdownButton extends StatelessWidget {
  final List<dynamic> result;
  final String? selectedPrefer;
  final ValueChanged<String?> onChanged;
  final int petsnalColorId;

  const PetColFilteringDropdownButton({
    required this.result,
    required this.selectedPrefer,
    required this.onChanged,
    required this.petsnalColorId,
  });

  @override
  Widget build(BuildContext context) {
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
        items: List.generate((result.length + 1), (index) {
          if (index == 0) {
            return DropdownMenuItem(
              value: '0',
              child: Text(
                '펫컬',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            );
          } else {
            return DropdownMenuItem(
              value: index.toString(),
              child: Text(
                result[index - 1]['name'],
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            );
          }
        }),
        value: selectedPrefer,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(left: 5),
          height: 30,
          width: 85,
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
          padding: EdgeInsets.all(0),
          maxHeight: 200,
          width: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFA8ABFF),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}

/* 색상 선택 창 */
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
              childAspectRatio: 1 / 1,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onColorSelected(colors[index][2]);
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        // color circle
                        margin: const EdgeInsets.only(bottom: 5),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
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

/* 상품 타일 */
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
          margin: EdgeInsets.all(4),
          child: Material(
            elevation: 2,
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            child: Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                // border: Border.all(
                //   color: Colors.black26,
                //   width: 0.7, // 테두리 두께
                // ),
              ),
              child: Column(
                children: [
                  FutureBuilder<Map<dynamic, dynamic>>(
                    future:
                        clothesProvider.getClothesPhoto(itemData['clothesId']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                            width: 200,
                            height: 200,
                            child: SpinKitPumpingHeart(
                              color: Color(0xFFA8ABFF),
                              size: 50.0,
                            ));
                      } else {
                        if (snapshot.hasError) {
                          return const Center(child: Text('ERROR'));
                        } else {
                          final result = snapshot.data!;
                          return Container(
                            // image container
                            margin: const EdgeInsets.all(0),
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(7),
                                topRight: Radius.circular(7),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    result['photourl3']), // 가져온 이미지로 설정
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
                        Text(
                          itemData['storeName'],
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        SizedBox(
                          height: 3,
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
        ),
      ),
    );
  }
}
