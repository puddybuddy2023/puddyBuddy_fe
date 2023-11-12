import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/board_provider.dart";

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
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
      body: Consumer<BoardProvider>(
        builder: (context, boardProvider, child) {
          final boardList = boardProvider.getBoardList();
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.2,
            ),
            itemBuilder: (c, i) {
              return InkWell( // container에서 gesture를 쓰기 위해
                onTap: (){Navigator.pushNamed(
                    context, '/board_detail', arguments: boardList[i]);},
                child: Container(
                  padding: EdgeInsets.all(1),
                  margin: EdgeInsets.all(1),
                  child: Image.network(boardList[i]['photoUrl']),
                ),
              );
            },
            itemCount: boardList.length,
          );
        }
      ),
    );
  }
}