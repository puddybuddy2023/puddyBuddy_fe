import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final TextEditingController _commentController = TextEditingController();

  void dispose() {
    // 페이지가 dispose 될 때 컨트롤러를 정리
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brd = ModalRoute.of(context)!.settings.arguments as dynamic;
    breedTagProvider.fetchBreedTagById(1);
    //print(brd.content);

    return Scaffold(
      backgroundColor: Color(0xFFE8EDF3),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black)),
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
              Container(
                padding: EdgeInsets.all(3),
                child: Text(
                  '${brd['create_date']}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  '${brd['content']}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ]),
          ),
          Card(
            color: Colors.black,
            child: Container(
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
                            style: TextStyle(color: Colors.white, fontSize: 15),
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
          /* 댓글 영역 */
          Card(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  child: TextFormField(
                    controller: _commentController, // 컨트롤러 할당
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                              commentProvider.createComments(brd['boardId'], brd['userId'], _commentController.text);
                              FocusManager.instance.primaryFocus?.unfocus();
                              _commentController.clear();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Color(0xFFA8ABFF),
                          ),
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                        hintText: '댓글을 남겨주세요'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '댓글을 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ),
                Consumer<CommentProvider>(
                    builder: (context, commentProvider, child) {
                  final commentList =
                      commentProvider.getCommentList(brd['boardId']);
                  return ListView.builder(
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
                                    '사용자${commentList[i]['userId']}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    commentList[i]['content'],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    },
                    itemCount: commentList.length,
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
