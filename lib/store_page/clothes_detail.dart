import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mungshinsa/providers/board_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/clothes_provider.dart';

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
      backgroundColor: Colors.white,
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
                FutureBuilder<Map<dynamic, dynamic>>(
                  future: clothesProvider.getClothesPhoto(clothes['clothesId']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      CircularProgressIndicator();
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: const SpinKitPumpingHeart(
                            color: Color(0xFFA8ABFF),
                            size: 50.0,
                          ));
                    } else {
                      if (snapshot.hasError) {
                        // 에러가 있다면 에러 메시지를 보여줄 위젯
                        return Center(child: Text('이미지를 불러오는 중에 에러가 발생했어요.'));
                      } else {
                        // 데이터를 성공적으로 불러왔을 때 Container를 보여줄 위젯
                        final result = snapshot.data!;
                        return Container(
                          margin: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
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
                Text(
                  '    Reviews',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    //fontStyle: FontStyle.italic,
                  ),
                ),
                FutureBuilder(
                    future: boardProvider
                        .fetchBoardsByClothesId(clothes['clothesId']),
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
                  //print(url);
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
