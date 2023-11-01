import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/board_provider.dart";
import '../models/board_model.dart';



class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BoardProvider>(
        builder: (context, boardProvider, child) {
          final boardList = boardProvider.getBoardList();
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.2,
            ),
            itemBuilder: (c, i) {
              return Container(
                padding: EdgeInsets.all(1),
                margin: EdgeInsets.all(1),
                child:
                  Image.network(boardList[i].photoUrl),
              );
            },
            itemCount: boardList.length,
          );
        }
      ),
    );
  }
}