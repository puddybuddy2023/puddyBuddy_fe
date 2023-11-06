import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
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