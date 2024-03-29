import 'package:flutter/material.dart';
import 'package:mungshinsa/providers/clothes_provider.dart';
import 'package:provider/provider.dart';
import '../models/comments_model.dart';
import 'package:mungshinsa/providers/board_provider.dart';
import 'package:mungshinsa/providers/prefer_api.dart';
import "../providers/comments_provider.dart";
import "../providers/breed_tags_api.dart";

class ReviewDetail extends StatefulWidget {
  const ReviewDetail({super.key});

  @override
  State<ReviewDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends State<ReviewDetail> {
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/userPage',
                              arguments: board['userId'],
                            );
                          },
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xFFA8ABFF),
                                backgroundImage: AssetImage(
                                    'assets/images/user_profile.png'),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '사용자${board['userId']}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  if (board['userId'] == 1)
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete, color: Colors.grey),
                    ),
                ],
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
                  return ClothesCard(board: result);
                } else {
                  return Container(
                    height: 70,
                  );
                }
              }),

          CommentsPanel(board: board), // comments section
        ],
      ),
    );
  }
}

/* 착용 제품 카드 */
class ClothesCard extends StatelessWidget {
  final dynamic board;
  const ClothesCard({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    //Map<dynamic, dynamic> clothes = clothesProvider.getClothesByClothesId(1);
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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
              FutureBuilder<Map<dynamic, dynamic>>(
                future: clothesProvider.getClothesPhoto(board['clothesId']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    const CircularProgressIndicator();
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      // 에러가 있다면 에러 메시지를 보여줄 위젯
                      return const Center(
                          child: Text('이미지를 불러오는 중에 에러가 발생했어요.'));
                    } else {
                      // 데이터를 성공적으로 불러왔을 때 Container를 보여줄 위젯
                      final photoResult = snapshot.data!;
                      return Container(
                        margin: const EdgeInsets.only(
                            left: 5, right: 9, top: 5, bottom: 5),
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                          image: DecorationImage(
                            image: NetworkImage(
                                photoResult['photourl1']), // 가져온 이미지로 설정
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    board['storeName'],
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    board['name'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    board['personalColor'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                margin: const EdgeInsets.all(5),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/shop_arrow.png'), // 가져온 이미지로 설정
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* 댓글 영역 */
class CommentsPanel extends StatefulWidget {
  final dynamic board;

  const CommentsPanel({Key? key, required this.board}) : super(key: key);

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
                      commentProvider.createComments(widget.board['boardId'],
                          widget.board['userId'], _commentController.text);
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
          Consumer<CommentProvider>(builder: (context, commentProvider, child) {
            final commentList =
                commentProvider2.getCommentList(widget.board['boardId']);
            //print(commentList);
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
