import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mungshinsa/petsonal_color_test_page/test_info.dart';
import 'package:mungshinsa/providers/board_provider.dart';
import 'package:mungshinsa/providers/prefer_provider.dart';
import 'package:mungshinsa/providers/size_measure_api.dart';
import 'package:mungshinsa/size_measure_page/size_info.dart';
import 'package:provider/provider.dart';
import '../petsonal_color_test_page/petcol_test_start.dart';
import '../size_measure_page/measure_start.dart';
import '../user_info.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final PageController controller = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.2,
          ),
        ),
        title: const Text(
          'PuddyBuddy',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Inter',
              fontSize: 23,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic),
        ),
        actions: [
          // Add your icon button here
          IconButton(
            icon: const Icon(
              Icons.settings_rounded,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/settings',
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFA8ABFF),
                  backgroundImage: AssetImage('assets/images/user_profile.png'),
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  userInfo.nickname!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: preferProvider.fetchPreferById(userInfo.userId!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final preferList = snapshot.data as List<dynamic>;
                return Column(
                  children: [
                    Container(
                      height: 200,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: preferList.length + 1,
                        onPageChanged: (page) {
                          //setState(() {
                          currentPage = page;
                          //});
                        },
                        itemBuilder: (context, index) {
                          if (index == preferList.length) {
                            return Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 15, 15, 15),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFFA6A6A6FF),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 3,
                                    spreadRadius: 3,
                                    offset: const Offset(0, 1),
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FloatingActionButton(
                                        heroTag: 'createPrefer',
                                        mini: true,
                                        backgroundColor: Colors.black,
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/createPrefer',
                                          );
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return PreferCard(result: preferList[index]);
                          }
                        },
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     for (var i = 0; i < preferList.length + 1; i++)
                    //       Container(
                    //         margin: const EdgeInsets.all(3),
                    //         width: 10,
                    //         height: 10,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           color: i == currentPage
                    //               ? const Color(0xFFA6A6A6FF)
                    //               : Colors.black.withOpacity(.2),
                    //         ),
                    //       )
                    //   ],
                    // ),
                  ],
                );
              }
            },
          ),

          // Consumer<PreferProvider>(builder: (context, preferProvider, child) {
          //   final preferList =
          //       preferProvider.getPreferListByUserId(userInfo.userId!);
          //   //print(preferList[0]['petsizeId']);
          //   //print(preferList);
          //   return Column(
          //     children: [
          //       Container(
          //         // 카드 슬라이더
          //         height: 200,
          //         child: PageView.builder(
          //             controller: controller,
          //             itemCount: preferList.length + 1,
          //             onPageChanged: (page) {
          //               //setState(() {
          //               currentPage = page;
          //               //});
          //             },
          //             itemBuilder: (context, index) {
          //               if (index == preferList.length) {
          //                 // 마지막 페이지일 때
          //                 return Container(
          //                   padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
          //                   margin: const EdgeInsets.symmetric(
          //                       horizontal: 15, vertical: 5),
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(15),
          //                       color: const Color(0xFFA6A6A6FF),
          //                       boxShadow: [
          //                         BoxShadow(
          //                             color: Colors.black.withOpacity(0.1),
          //                             blurRadius: 3,
          //                             spreadRadius: 3,
          //                             offset: const Offset(0, 1))
          //                       ]),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Row(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         children: [
          //                           FloatingActionButton(
          //                             heroTag: 'createPrefer',
          //                             mini: true,
          //                             backgroundColor: Colors.black,
          //                             onPressed: () {
          //                               Navigator.pushNamed(
          //                                   context, '/createPrefer');
          //                             },
          //                             child: const Icon(
          //                               Icons.add,
          //                               size: 20,
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ); // 일반 카드를 반환하 // 추가 버튼을 반환하는 함수 호출
          //               } else {
          //                 return PreferCard(result: preferList[index]);
          //                 // 선호조건 카드를 반환하는 함수 호출
          //               }
          //             }),
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           for (num i = 0; i < preferList.length + 1; i++)
          //             Container(
          //               margin: const EdgeInsets.all(3),
          //               width: 10,
          //               height: 10,
          //               decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   color: i == currentPage
          //                       ? const Color(0xFFA6A6A6FF)
          //                       : Colors.black.withOpacity(.2)),
          //             )
          //         ],
          //       ),
          //     ],
          //   );
          // }),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 기존에 있던 코드는 여기에 들어갑니다.
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Icon(
                  Icons.window,
                  color: Colors.black, // 아이콘 색상을 검정색으로 지정합니다.
                  size: 30, // 아이콘 크기를 조절합니다.
                ),
              ),
            ],
          ),
          Container(height: 1, color: Colors.grey),
          FutureBuilder(
              future: boardProvider.fetchBoardsByUserId(userInfo.userId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final result = snapshot.data!;
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: result.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 1 / 1),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/board_detail',
                              arguments: result[index],
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Image.network(result[index]['photoUrl'])
                                    .image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      });
                }
              }),
          // Consumer<BoardProvider>(builder: (context, boardProvider, child) {
          //   final boardList = boardProvider.getBoardListByUserId(1);
          //   return GridView.builder(
          //       shrinkWrap: true,
          //       physics: const NeverScrollableScrollPhysics(),
          //       itemCount: boardList.length,
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 3, childAspectRatio: 1 / 1),
          //       itemBuilder: (context, index) {
          //         return InkWell(
          //           onTap: () {
          //             Navigator.pushNamed(
          //               context,
          //               '/board_detail',
          //               arguments: boardList[index],
          //             );
          //           },
          //           child: Container(
          //             padding: const EdgeInsets.all(1),
          //             margin: const EdgeInsets.all(1),
          //             decoration: BoxDecoration(
          //               image: DecorationImage(
          //                 image:
          //                     Image.network(boardList[index]['photoUrl']).image,
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //           ),
          //         );
          //       });
          // }),
        ],
      ),
    );
  }
}

/* 반려견 카드 영역 */
class PreferCard extends StatelessWidget {
  final Map<dynamic, dynamic> result;

  const PreferCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFA8ABFF),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 3,
                    offset: const Offset(0, 0))
              ]),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 115,
                    width: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/dog_profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    result['name'],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    result['breedTagName'],
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'size',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          height: 25,
                          width: 65,
                          child: ElevatedButton(
                              onPressed: () {
                                sizeInfo.preferId = result['preferId'];
                                sizeInfo.breedTagId = result['breedTagId'];
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    settings:
                                        RouteSettings(name: "/measureStart"),
                                    builder: (context) => SizeMeasureStart(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(30), // 모서리를 둥글게 조정
                                ),
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(65, 25),
                              ),
                              child: const Text(
                                '측정하기',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '목둘레 ·가슴둘레 · 등길이 · 다리길이',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    FutureBuilder(
                      future: sizeMeasure
                          .getPetSize(result['petsizeId']), // 비동기 함수 호출
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(); // 로딩 인디케이터 등을 표시
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final petSizeResult = snapshot.data!;
                          return Text(
                            '${petSizeResult['neck']} · ${petSizeResult['chest']} · ${petSizeResult['back']} · ${petSizeResult['leg']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          'petsnal color',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          height: 25,
                          width: 53,
                          child: ElevatedButton(
                              // 펫스널컬러 테스트 버튼
                              onPressed: () {
                                testInfo.preferId = result['preferId'];
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    settings: RouteSettings(
                                        name: "/petsnalColorStart",
                                        arguments: 15),
                                    builder: (context) =>
                                        PetsnalColorStartPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(30), // 모서리를 둥글게 조정
                                ),
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(55, 35),
                              ),
                              child: const Text(
                                '테스트',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        if (result['personalColorId'] == 1) ...[
                          Image.asset(
                              'assets/images/prefer_card/prefer_card_spring.png'),
                        ],
                        if (result['personalColorId'] == 2) ...[
                          Image.asset(
                              'assets/images/prefer_card/prefer_card_summer.png'),
                        ],
                        if (result['personalColorId'] == 3) ...[
                          Image.asset(
                              'assets/images/prefer_card/prefer_card_fall.png'),
                        ],
                        if (result['personalColorId'] == 4) ...[
                          Image.asset(
                              'assets/images/prefer_card/prefer_card_winter.png'),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: PopupMenuButton(
            icon: Icon(Icons.more_vert), // 3dot 아이콘
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: Text('수정'),
                  value: 'item1',
                ),
                PopupMenuItem(
                  child: Text('삭제'),
                  value: 'item2',
                ),
                // Add more PopupMenuItems as needed
              ];
            },
            onSelected: (value) {
              if (value == 'item1') {
                // 선택한 항목이 '수정'일 때 실행할 함수 호출
              } else if (value == 'item2') {
                // 선택한 항목이 '삭제'일 때 실행할 함수 호출
                preferProvider.deletePrefer(1);
              }
            },
          ),
        ),
      ],
    );
  }
}
