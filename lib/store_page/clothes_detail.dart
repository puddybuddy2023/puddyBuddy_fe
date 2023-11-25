import 'package:flutter/material.dart';
import 'package:mungshinsa/providers/board_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ClothesDetail extends StatefulWidget {
  const ClothesDetail({super.key});

  @override
  State<ClothesDetail> createState() => _ClothesDetailState();
}

class _ClothesDetailState extends State<ClothesDetail> {
  @override
  Widget build(BuildContext context) {
    final clothes = ModalRoute.of(context)!.settings.arguments as dynamic;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width, // 원하는 너비 설정
                  height: MediaQuery.of(context).size.width, // 원하는 높이 설정
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: 버튼이 눌렸을 때 수행할 작업 추가
                        },
                        child: Text('피팅'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          fixedSize: Size(20, 20), // 너비 200, 높이 50으로 설정
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   clothes['storeName'],
                      //   style: TextStyle(
                      //     color: Colors.black54,
                      //     fontSize: 14,
                      //   ),
                      // ),
                      Text(
                        clothes['name'],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future:
                        boardProvider.fetchClothesById(clothes['clothesId']),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final result = snapshot.data!;
                        return GridView.builder(
                            padding: EdgeInsets.all(15),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: result.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1 / 1),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/reviewDetail',
                                    arguments: result[index],
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(1),
                                  margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.network(
                                              result[index]['photoUrl'])
                                          .image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Container();
                      }
                    }),

                // Consumer<BoardProvider>(
                //     builder: (context, boardProvider, child) {
                //   final boardList = boardProvider
                //       .getBoardListByClothesId(clothes['clothesId']);
                //   return GridView.builder(
                //       padding: EdgeInsets.all(15),
                //       shrinkWrap: true,
                //       physics: const NeverScrollableScrollPhysics(),
                //       itemCount: boardList.length,
                //       gridDelegate:
                //           const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 2, childAspectRatio: 1 / 1),
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
                //             padding: EdgeInsets.all(1),
                //             margin: EdgeInsets.all(1),
                //             decoration: BoxDecoration(
                //               image: DecorationImage(
                //                 image:
                //                     Image.network(boardList[index]['photoUrl'])
                //                         .image,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //         );
                //       });
                // }),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  final url = Uri.parse(clothes['shoppingSiteUrl']);
                  //final url = Uri(scheme: 'https', host: clothes['shoppingSiteUrl']);
                  print(url);
                  if (await canLaunchUrl(url)) {
                    launchUrl(Uri.parse(clothes['shoppingSiteUrl']));
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '구매하기',
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(Icons.arrow_forward_rounded)
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA8ABFF)),
              )),
        ],
      ),
    );
  }
}
