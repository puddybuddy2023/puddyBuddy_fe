import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mungshinsa/providers/board_provider.dart';
import 'package:mungshinsa/providers/prefer_provider.dart';
import 'package:provider/provider.dart';
import 'create_prefer.dart';

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
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.2,
          ),
        ),
        title: const Text(
          'PuddyBuddy',
          style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic),
        ),
        actions: [
          // Add your icon button here
          IconButton(
            icon: Icon(
              Icons.settings,
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
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                    color: Colors.grey, shape: BoxShape.circle),
              ),
              const Text(
                '유저 아이디',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          Consumer<PreferProvider>(builder: (context, commentProvider, child) {
            final preferList = preferProvider.getPreferList(1);
            return Container(
              // 카드 슬라이더
              height: 200,
              child: PageView.builder(
                  controller: controller,
                  itemCount: preferList.length,
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    if (index == preferList.length) {
                      // 마지막 페이지일 때
                      return Container(
                        padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFA6A6A6FF),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 3,
                                  spreadRadius: 3,
                                  offset: const Offset(0, 1))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  mini: true,
                                  backgroundColor: Colors.black,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/createPrefer');
                                  },
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ); // 일반 카드를 반환하 // 추가 버튼을 반환하는 함수 호출
                    } else {
                      return buildPreferCard(
                          preferList[currentPage]); // 선호조건 카드를 반환하는 함수 호출
                    }
                  }),
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (num i = 0; i < 3; i++)
                Container(
                  margin: const EdgeInsets.all(3),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == currentPage
                          ? Color(0xFFA6A6A6FF)
                          : Colors.black.withOpacity(.2)),
                )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(height: 1, color: Colors.grey),
          Consumer<BoardProvider>(builder: (context, boardProvider, child) {
            final boardList = boardProvider.getBoardListByUserId(1);
            return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: boardList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 1 / 1.2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/board_detail',
                        arguments: boardList[index],
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(1),
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              Image.network(boardList[index]['photoUrl']).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                });
          }),
        ],
      ),
    );
  }
}

Widget buildPreferCard(Map<dynamic, dynamic> result) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
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
    child: Column(
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 5),
              decoration: const BoxDecoration(
                  color: Colors.grey, shape: BoxShape.circle),
            ),
            Text(
              result['name'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              'SIZE',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '${result['chest']} / ${result['back']} (가슴둘레 / 등길이)',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Text(
              'PETSONAL COLOR',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 7),
              color: Colors.yellow,
              height: 25,
              width: 25,
            ),
            Container(
              margin: EdgeInsets.only(right: 7),
              color: Colors.yellow,
              height: 25,
              width: 25,
            ),
            Container(
              color: Colors.yellow,
              height: 25,
              width: 25,
            )
          ],
        ),
      ],
    ),
  );
}
