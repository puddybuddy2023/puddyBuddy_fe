import 'package:flutter/material.dart';
import '../models/comments_model.dart';
import 'package:dio/dio.dart';

const _API_PREFIX =
    'http://ec2-3-39-55-229.ap-northeast-2.compute.amazonaws.com/comments';

class CommentProvider with ChangeNotifier {
  /*댓글 전체 가져오기*/
  final List<dynamic> _commentList = List.empty(growable: true);
  List<dynamic> getCommentList(int boardId) {
    _fetchComments(boardId);
    return _commentList;
  }

  Future<void> _fetchComments(int boardId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get('$_API_PREFIX/$boardId');
    final result = (response.data)['result'];
    //Map<String, dynamic> responseMap = response.data;
    //print(response.data.toString());

    // final List<Comment> result = (response.data)["result"] // JSON 문자열을 파싱하여 Dart의 Map 형태로 변환
    //     .map<Comment>((json) => Comment.fromJson(json)) // Map에서 각 JSON 객체를 Board 모델로 mapping
    //     .toList(); // 리스트로 변환

    _commentList.clear(); // 이전에 저장된 목록을 비운다.
    _commentList.addAll(result);
    notifyListeners(); // 데이터가 업데이트되었음을 리스너에게 알린다.
  }

  /* 댓글 작성 */
  Future<void> createComments(int boardId, int userId, String content) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.post("$_API_PREFIX/create", data: {
      "boardId": boardId,
      "userId": userId,
      "content": content,
    });
    //Map<dynamic, dynamic> responseMap = (response.data)['result'][0];
    print((response.data));
  }

  /* 댓글 삭제 */
  Future<void> deleteComments(int commentId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/delete/$commentId",
        queryParameters: {'commentId': commentId});
  }
}

CommentProvider commentProvider = CommentProvider();
CommentProvider commentProvider2 = CommentProvider();
