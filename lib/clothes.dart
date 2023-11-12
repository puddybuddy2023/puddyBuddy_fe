import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/clothes_provider.dart';

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
        backgroundColor: Colors.white,
        elevation: 0,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        title: Center(
          child: const Text(
            'PuddyBuddy',
            style: TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
      body: Consumer<ClothesProvider>(
          builder: (context, boardProvider, child) {
            final clothesList = boardProvider.getClothesList();
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.2,
              ),
              itemBuilder: (c, i) {
                return InkWell( // container에서 gesture를 쓰기 위해
                  onTap: (){Navigator.pushNamed(
                      context, '/board_detail', arguments: clothesList[i]);},
                  child: Container(
                    padding: EdgeInsets.all(1),
                    margin: EdgeInsets.all(1),
                    color: Colors.grey,
                    //child: Image.network(clothesList[i]['photoUrl']),
                  ),
                );
              },
              itemCount: clothesList.length,
            );
          }
      ),
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