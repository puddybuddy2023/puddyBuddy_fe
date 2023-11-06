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
    return Column(
      children: [
        Container(
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
                  padding: EdgeInsets.fromLTRB(20, 28, 20, 24),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            spreadRadius: 3,
                            offset: Offset(0, 0))
                      ]),
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for(num i=0;i<3;i++)
              Container(
                margin: EdgeInsets.all(3),
                width: 6,
                height: 6,
                decoration: BoxDecoration(shape: BoxShape.circle, color: i==currentPage?RenderErrorBox.backgroundColor:RenderErrorBox.backgroundColor.withOpacity(.2)),
              )
          ],
        ),
        // GridView.builder(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //     childAspectRatio: 1 / 1.2,
        //   ),
        //   itemBuilder: (c, i) {
        //     return InkWell( // container에서 gesture를 쓰기 위해
        //       onTap: (){Navigator.pushNamed(
        //           context, '/board_detail');},
        //       child: Container(
        //         padding: EdgeInsets.all(1),
        //         margin: EdgeInsets.all(1),
        //         color: Colors.purple,
        //       ),
        //     );
        //   },
        //   itemCount: 10,
        // )

      ],
    );
  }
}
