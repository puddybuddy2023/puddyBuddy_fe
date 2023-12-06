import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mungshinsa/providers/board_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/clothes_provider.dart';
import '../widgets.dart';
import 'fitting.dart';

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
      appBar: const GoBackAppBar(),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          heroTag: 'fitting_button',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Fitting(),
              ),
            );
          },
          elevation: 5,
          backgroundColor: Color(0xFFA8ABFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: EdgeInsets.all(3),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/dog_clothes.png',
                  width: 60,
                  height: 55,
                  //fit: BoxFit.cover,
                ),
                Text(
                  '가상피팅',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: SizedBox(height: 75),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                FutureBuilder<Map<dynamic, dynamic>>(
                  future: clothesProvider.getClothesPhoto(clothes['clothesId']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: const SpinKitPumpingHeart(
                            color: Color(0xFFA8ABFF),
                            size: 100.0,
                          ));
                    } else {
                      if (snapshot.hasError) {
                        // 에러가 있다면 에러 메시지를 보여줄 위젯
                        return Center(child: Text('ERROR'));
                      } else {
                        final result = snapshot.data!;
                        return ImageSlide(
                          result: result,
                        );
                      }
                    }
                  },
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clothes['storeName'],
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        clothes['name'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey.shade400,
                  height: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Reviews',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Inter',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    '이 상품을 착용한 강아지들',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      //fontStyle: FontStyle.italic,
                    ),
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
              height: 65,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      minimumSize: Size(double.infinity,
                          40), // ElevatedButton의 최소 크기 설정 (가로는 화면에 꽉 차도록, 높이는 50)
                    ),
                    onPressed: () async {
                      final url = Uri.parse(clothes['shoppingSiteUrl']);
                      //print(url);
                      if (await canLaunchUrl(url)) {
                        launchUrl(url);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '구매하러 가기',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.arrow_forward_rounded)
                      ],
                    ),
                  ),
                  Text(
                    clothes['shoppingSiteUrl'],
                    style: TextStyle(fontSize: 10, color: Colors.black38),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class ImageSlide extends StatefulWidget {
  final Map<dynamic, dynamic> result;

  const ImageSlide({super.key, required this.result});

  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: PageView.builder(
              controller: controller,
              itemCount: widget.result.length - 2,
              onPageChanged: (page) {
                setState(() {
                  currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    image: DecorationImage(
                      image: NetworkImage(
                          widget.result['photourl${index + 1}']), // 가져온 이미지로 설정
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (num i = 0; i < widget.result.length - 2; i++)
              Container(
                margin: const EdgeInsets.all(3),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == currentPage
                        ? const Color(0xFF000000)
                        : Colors.black.withOpacity(.2)),
              ),
          ],
        ),
      ],
    );
  }
}
