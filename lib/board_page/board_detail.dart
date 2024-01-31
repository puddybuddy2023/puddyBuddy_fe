import 'package:flutter/material.dart';
import 'package:mungshinsa/providers/clothes_provider.dart';
import 'package:mungshinsa/user_info.dart';
import 'package:mungshinsa/widgets.dart';
import 'package:provider/provider.dart';
import '../../models/comments_model.dart';
import 'package:mungshinsa/providers/board_provider.dart';
import 'package:mungshinsa/providers/prefer_api.dart';
import '../../providers/comments_provider.dart';
import '../../providers/breed_tags_api.dart';
import '../providers/user_api.dart';

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
      appBar: const GoBackAppBar(),
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
                            backgroundImage:
                                AssetImage('assets/images/user_profile.png'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FutureBuilder(
                            future: userProvider.getUserByUserId(
                                board['userId']), // 비동기 작업을 수행할 Future를 지정합니다.
                            builder: (context, snapshot) {
                              // 비동기 작업의 상태에 따라 UI를 빌드합니다.
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // 작업이 아직 완료되지 않은 경우
                                return CircularProgressIndicator(); // 로딩 중 인디케이터 등을 표시할 수 있습니다.
                              } else if (snapshot.hasError) {
                                // 에러가 발생한 경우
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final result = snapshot.data;
                                return Text(
                                  result!['nickname'],
                                  style: TextStyle(fontSize: 16),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    if (board['userId'] == userInfo.userId)
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('알림'),
                              content: Text('삭제하시겠습니까?'),
                              actions: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xFFA8ABFF),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              minimumSize:
                                                  Size(100, 40), // 버튼의 최소 크기 지정
                                            ),
                                            onPressed: () {
                                              boardProvider.deleteBoard(
                                                  board['boardId']);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text('예',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          SizedBox(width: 8), // 버튼 간격 조절
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              minimumSize:
                                                  Size(100, 40), // 버튼의 최소 크기 지정
                                            ),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text('아니오',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
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
        Navigator.pushNamed(context, '/clothesDetail', arguments: board);
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
                        duration: Duration(seconds: 2), // 올라와있는 시간
                      ));
                    } else {
                      commentProvider.createComments(widget.board['boardId'],
                          userInfo.userId!, _commentController.text);
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
                        if (commentList[i]['userId'] == userInfo.userId)
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text('알림'),
                                  content: Text('삭제하시겠습니까?'),
                                  actions: [
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color(0xFFA8ABFF),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  minimumSize: Size(
                                                      100, 40), // 버튼의 최소 크기 지정
                                                ),
                                                onPressed: () {
                                                  commentProvider
                                                      .deleteComments(
                                                          commentList[i]
                                                              ['commentId']);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('예',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                              SizedBox(width: 8), // 버튼 간격 조절
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  minimumSize: Size(
                                                      100, 40), // 버튼의 최소 크기 지정
                                                ),
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text('아니오',
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
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
