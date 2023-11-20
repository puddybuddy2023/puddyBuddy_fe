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
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        title: const Text(
          'PuddyBuddy',
          style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontFamily: 'Inter'),
        ),
      ),
      body: Consumer<BoardProvider>(builder: (context, boardProvider, child) {
        final boardList = boardProvider.getBoardList();
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent:
                MediaQuery.of(context).size.width / 2, // 각 그리드 항목의 최대 가로 크기
            mainAxisSpacing: 0.5, // 세로 간격
            crossAxisSpacing: 0.5, // 가로 간격
            childAspectRatio: 1 / 1,
          ),
          itemBuilder: (c, i) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/board_detail',
                  arguments: boardList[i],
                );
              },
              child: Container(
                padding: EdgeInsets.all(1),
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.network(boardList[i]['photoUrl']).image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          itemCount: boardList.length,
        );
      }),
    );
  }
}
