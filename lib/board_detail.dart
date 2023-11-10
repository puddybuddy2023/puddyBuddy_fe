import 'package:flutter/material.dart';
import '../models/board_model.dart';
import '../models/prefer_model.dart';
import '../models/comments_model.dart';
import 'package:mungshinsa/providers/board_provider.dart';
import 'package:mungshinsa/providers/prefer_provider.dart';
import "../providers/comments_provider.dart";
import "../providers/breed_tags_provider.dart";

class BoardDetail extends StatefulWidget {
  const BoardDetail({super.key});

  @override
  State<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  @override
  Widget build(BuildContext context) {
    final brd = ModalRoute.of(context)!.settings.arguments as dynamic;
    List<Comment> commentList = commentserver.getCommentList();
    breedTagProvider.fetchBreedTagById(1);
    boardProvider.getBoardDetail(10);
    //print(brd.content);

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
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Colors.grey, shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '사용자${brd['userId']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Image.network(brd['photoUrl']),
              Text(
                '${brd['create_date']}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '${brd['content']}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              )
            ]),
          ),
          Card(
            color: Colors.black,
            child: Container(
              height: 50,
              child: FutureBuilder(
                future: preferProvider.fetchPreferById(brd['userId']),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<dynamic, dynamic> responseMap = snapshot.data!;
                    return Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            responseMap['name'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            responseMap['chest'].toString() +
                                ' / ' +
                                responseMap['back'].toString() +
                                ' (가슴둘레 / 등길이)',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
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
                    '착용한 옷 정보',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (c, i) {
                    return Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey, shape: BoxShape.circle),
                            ),
                            Column(
                              children: [
                                Text(
                                  '사용자${commentList[i].userId}',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  commentList[i].content,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ));
                  },
                  itemCount: commentList.length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
