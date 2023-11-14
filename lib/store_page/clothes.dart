import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/clothes_provider.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Consumer<ClothesProvider>(builder: (context, boardProvider, child) {
        final clothesList = boardProvider.getClothesList();
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.4,
          ),
          itemBuilder: (c, i) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/clothesDetail', arguments: clothesList[i]
                    );
              },
              child: Container(
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 1),
                    ),
                  ], // 원하는 정도의 둥근 모서리 반지름 설정
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      width: 180, // 원하는 너비 설정
                      height: 180, // 원하는 높이 설정
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(clothesList[i]['storeId'].toString(), textAlign: TextAlign.start,),
                            Text(clothesList[i]['name']),
                          ],
                        )),
                  ],
                ),
                //child: Image.network(clothesList[i]['photoUrl']),
              ),
            );
          },
          itemCount: clothesList.length,
        );
      }),
    );

    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.2,
        ),
        itemBuilder: (c, i) {
          return Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            color: Colors.grey,
          );
        },
        itemCount: 15,
      ),
    );
  }
}
