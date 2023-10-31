import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.fromLTRB(20, 28, 20, 24),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.grey,
          width: 100,
        ),
        separatorBuilder: (context, index) => SizedBox(width: 20),
        itemCount: 5);
  }
}
