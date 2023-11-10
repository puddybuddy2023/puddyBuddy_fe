import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    return ListView(
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.grey, shape: BoxShape.circle),
            ),
            Text('유저 아이디', style: TextStyle(fontSize: 16),)
          ],
        ),
        Container( // 카드 슬라이더
          padding: EdgeInsets.symmetric(horizontal: 4),
          width: double.infinity,
          height: 200,
          child: PageView.builder(
              controller: controller,
              itemCount: 3,
              onPageChanged: (page) {
                setState(() {
                  currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFFA8ABFF),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            spreadRadius: 3,
                            offset: Offset(0, 0))
                      ]),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                          ),
                          Text('강아지 이름(종)', style: TextStyle(fontSize: 18,  fontWeight: FontWeight.w500),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('SIZE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),),
                        ],
                      ),
                      Row(
                        children: [
                          Text('20/20(등길이/가슴둘레)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('PETSONAL COLOR', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (num i = 0; i < 3; i++)
              Container(
                margin: EdgeInsets.all(3),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == currentPage
                        ? Colors.black
                        : Colors.black.withOpacity(.2)),
              )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(height: 1, color: Colors.grey),
        GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 1 / 1.2),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/board_detail');
                },
                child: Container(
                  margin: EdgeInsets.all(1),
                  height: 3,
                  color: Colors.grey,
                ),
              );
            }),
      ],
    );
  }
}
