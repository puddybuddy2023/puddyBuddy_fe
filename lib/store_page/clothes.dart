import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/clothes_provider.dart';
import 'package:getwidget/getwidget.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  bool isSwitched = false;
  int colorId = -1;
  //int personalcolorId = 0;
  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextEditingController = TextEditingController();
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
              fontFamily: 'Inter',
              fontSize: 23,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: Column(
        children: [
          /* 검색 영역 */
          Container(
            // 검색창
            padding: const EdgeInsets.all(8.0),
            height: 60,
            child: TextField(
              controller: searchTextEditingController,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFA8ABFF),
                ),
                hintText: '검색어를 입력해주세요',
                contentPadding: EdgeInsets.only(left: 10.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // 까만색 테두리
                ),
              ),
            ),
          ),
          Container(
            // filtering
            margin: EdgeInsets.only(left: 10, bottom: 10),
            child: Row(
              children: [
                GFToggle(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value!;
                      colorId = value ? 1 : -1;
                    });
                  },
                  enabledThumbColor: Colors.white,
                  enabledTrackColor: Color(0xFFA8ABFF),
                  enabledText: '펫컬',
                  enabledTextStyle: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                  type: GFToggleType.ios,
                ),
              ],
            ),
          ),
          /* 옷 목록 영역 */
          Expanded(
            child: Consumer<ClothesProvider>(
                builder: (context, boardProvider, child) {
              final clothesList = boardProvider.getClothesList(colorId);
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.32,
                ),
                itemCount: clothesList.length,
                itemBuilder: (c, i) {
                  return GridTile(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/clothesDetail',
                            arguments: clothesList[i]);
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              width: 180, // 원하는 너비 설정
                              height: 180, // 원하는 높이 설정
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(5),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      clothesList[i]['storeName'].toString(),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      clothesList[i]['name'],
                                      style: TextStyle(fontSize: 16),
                                      //softWrap: false,
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        //child: Image.network(clothesList[i]['photoUrl']),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class DisplayClothes extends StatelessWidget {
  const DisplayClothes({super.key});

  @override
  Widget build(BuildContext context) {
    int colorId = -1;
    //int personalcolorId = 0;
    return Expanded(
      child:
          Consumer<ClothesProvider>(builder: (context, boardProvider, child) {
        final clothesList = boardProvider.getClothesList(colorId);
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.32,
          ),
          itemCount: clothesList.length,
          itemBuilder: (c, i) {
            return GridTile(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/clothesDetail',
                      arguments: clothesList[i]);
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        width: 180, // 원하는 너비 설정
                        height: 180, // 원하는 높이 설정
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                clothesList[i]['storeName'].toString(),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                clothesList[i]['name'],
                                style: TextStyle(fontSize: 16),
                                //softWrap: false,
                                overflow: TextOverflow.fade,
                                maxLines: 2,
                              ),
                            ],
                          )),
                    ],
                  ),
                  //child: Image.network(clothesList[i]['photoUrl']),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
