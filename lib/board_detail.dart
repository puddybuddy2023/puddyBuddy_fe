import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/comments_provider.dart";
import '../models/board_model.dart';
import '../models/comments_model.dart';

class BoardDetail extends StatefulWidget {
  const BoardDetail({super.key});

  @override
  State<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  @override
  Widget build(BuildContext context) {
    List<Comment> commentList = commentserver.getCommentList();

    final brd = ModalRoute.of(context)!.settings.arguments as Board;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA8ABFF),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Card(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${brd.userId}'),
              Image.network(brd.photoUrl),
              Text('${brd.create_date}'),
              Text('${brd.content}'),
            ]),
          ),
          Card(
            color: Colors.black,
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Text(
                    '강아지정보',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Color(0xFFA8ABFF),
            child: Container(
              height: 70,
              child: Row(
                children: [
                  Text(
                    '옷정보',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (c, i) {
                  return Container(
                      color: Colors.white, child: Text(commentList[i].content));
                },
                itemCount: commentList.length,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
