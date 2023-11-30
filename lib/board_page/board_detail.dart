import 'package:flutter/material.dart';
import 'package:mungshinsa/providers/clothes_provider.dart';
import 'package:provider/provider.dart';
import '../../models/comments_model.dart';
import 'package:mungshinsa/providers/board_provider.dart';
import 'package:mungshinsa/providers/prefer_provider.dart';
import '../../providers/comments_provider.dart';
import '../../providers/breed_tags_provider.dart';

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
    final board = ModalRoute.of(context)!.settings.arguments as dynamic;
    //breedTagProvider.fetchBreedTagById(1);
    //print(board.content);

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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0), // 모서리를 더 둥글게 조정
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFFA8ABFF),
                      backgroundImage:
                          AssetImage('assets/images/user_profile.png'),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '사용자${board['userId']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    if (board['userId'] == 1)
                      IconButton(
                        onPressed: () {
                          boardProvider.deleteBoard(board['boardId']);
                        },
                        icon: Icon(Icons.delete, color: Colors.grey),
                      ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1.0 / 1,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                  image: Image.network(board['photoUrl']).image,
                  fit: BoxFit.cover,
                ))),
              ),
              Container(
                padding: EdgeInsets.all(3),
                child: Text(
                  '${board['create_date']}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  '${board['content']}',
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0), // 모서리를 더 둥글게 조정
            ),
            child: FutureBuilder(
              future: preferProvider.fetchPreferById(board['userId']),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<dynamic, dynamic> responseMap = snapshot.data![0];
                  return Container(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          backgroundColor: Color(0xFFA8ABFF),
                          backgroundImage:
                              AssetImage('assets/images/dog_profile.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
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
          FutureBuilder(
              future: clothesProvider.getClothesByClothesId(board['clothesId']),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final result = snapshot.data!;
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/clothesDetail',
                          arguments: result);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      color: Color(0xFFA8ABFF),
                      child: Container(
                        height: 80,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white,
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/dog_profile.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result['storeName'],
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  result['name'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  result['personalColor'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 70,
                  );
                }
              }),
          CommentsPanel(
              commentProvider: commentProvider,
              board: board), // comments section
        ],
      ),
    );
  }
}

/* 옷 정보 영역 */
class ClothesPanel extends StatelessWidget {
  const ClothesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    //Map<dynamic, dynamic> clothes = clothesProvider.getClothesByClothesId(1);
    return FutureBuilder(
        future: clothesProvider.getClothesByClothesId(1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final result = snapshot.data!;
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/clothesDetail',
                    arguments: result);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                color: Color(0xFFA8ABFF),
                child: Container(
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                          image: const DecorationImage(
                            image: AssetImage('assets/images/dog_profile.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result['storeName'],
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            result['name'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            result['personalColor'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              height: 70,
            );
          }
        });
  }
}

/* 댓글 영역 */
class CommentsPanel extends StatefulWidget {
  final CommentProvider commentProvider;
  final dynamic board;

  const CommentsPanel(
      {Key? key, required this.commentProvider, required this.board})
      : super(key: key);

  @override
  State<CommentsPanel> createState() => _CommentsPanelState();
}

class _CommentsPanelState extends State<CommentsPanel> {
  final TextEditingController _commentController = TextEditingController();

  void dispose() {
    // 페이지가 dispose 될 때 controller를 정리
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0), // 모서리를 더 둥글게 조정
      ),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _commentController, // 컨트롤러 할당
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  // 외곽선 테두리 스타일 설정
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(7), // 모서리 둥글기 설정
                ),
                hintText: '댓글을 남겨주세요',
                suffixIcon: IconButton(
                  onPressed: () {
                    if (_commentController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('내용을 입력해주세요'),
                        duration: Duration(seconds: 2), //올라와있는 시간
                      ));
                    } else {
                      commentProvider.createComments(widget.board['boardId'],
                          widget.board['userId'], _commentController.text);
                      FocusManager.instance.primaryFocus?.unfocus();
                      _commentController.clear();
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Color(0xFFA8ABFF),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '댓글을 입력해주세요';
                }
                return null;
              },
            ),
          ),
          Consumer<CommentProvider>(builder: (context, commentProvider, child) {
            final commentList =
                commentProvider.getCommentList(widget.board['boardId']);
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (c, i) {
                return Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(7.0),
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: Color(0xFFA8ABFF),
                            backgroundImage:
                                AssetImage('assets/images/dog_profile.png'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '유저${commentList[i]['userId']}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              commentList[i]['content'],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Spacer(),
                        /* 본인이 작성한 댓글인 경우 삭제 버튼 제공 */
                        if (commentList[i]['userId'] == 1)
                          IconButton(
                            onPressed: () {
                              commentProvider
                                  .deleteComments(commentList[i]['commentId']);
                            },
                            icon: Icon(Icons.delete, color: Colors.grey),
                          ),
                      ],
                    ));
              },
              itemCount: commentList.length,
            );
          })
        ],
      ),
    );
  }
}
