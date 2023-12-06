import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mungshinsa/providers/board_provider.dart';
import 'package:mungshinsa/providers/prefer_provider.dart';
import 'package:provider/provider.dart';
import '../petsonal_color_test_page/petcol_test_start.dart';
import '../size_measure_page/measure_start.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _MyPageState();
}

class _MyPageState extends State<UserPage> {
  final PageController controller = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black)),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
            child: const Row(
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
                  'userid',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Consumer<PreferProvider>(builder: (context, preferProvider, child) {
            final preferList = preferProvider.getPreferListByUserId(userId);
            //print(preferList);
            return Column(
              children: [
                Container(
                  // 카드 슬라이더
                  height: 200,
                  child: PageView.builder(
                      controller: controller,
                      itemCount: preferList.length,
                      onPageChanged: (page) {
                        //setState(() {
                        currentPage = page;
                        //});
                      },
                      itemBuilder: (context, index) {
                        return PreferCardPanel(result: preferList[index]);
                        // 선호조건 카드를 반환하는 함수 호출
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (num i = 0; i < preferList.length; i++)
                      Container(
                        margin: const EdgeInsets.all(3),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i == currentPage
                                ? const Color(0xFFA6A6A6FF)
                                : Colors.black.withOpacity(.2)),
                      )
                  ],
                ),
              ],
            );
          }),
          const SizedBox(
            height: 15,
          ),
          Container(height: 1, color: Colors.grey),
          FutureBuilder(
              future: boardProvider.fetchBoardsByUserId(userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Container());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // 데이터가 정상적으로 도착하면 여기서 UI를 만들어서 반환합니다.
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
class PreferCardPanel extends StatelessWidget {
  final Map<dynamic, dynamic> result;

  const PreferCardPanel({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                    margin: const EdgeInsets.only(top: 10),
                    height: 100,
                    width: 100,
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
                        fontSize: 18, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    result['breedTagName'],
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
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
                      ],
                    ),
                    Text(
                      '${result['chest']} / ${result['back']} (가슴둘레 / 등길이)',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'petsonal color',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 7),
                          color: Colors.grey,
                          height: 35,
                          width: 35,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 7),
                          color: Colors.grey,
                          height: 35,
                          width: 35,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 7),
                          color: Colors.grey,
                          height: 35,
                          width: 35,
                        ),
                        Container(
                          color: Colors.grey,
                          height: 35,
                          width: 35,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
