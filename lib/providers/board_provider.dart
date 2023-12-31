import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../models/board_model.dart';

const _API_PREFIX =
    'http://ec2-3-39-55-229.ap-northeast-2.compute.amazonaws.com/boards';

class BoardProvider with ChangeNotifier {
  final List<dynamic> _boardList = List.empty(growable: true);

  /* 보드 전체 가져오기 */
  List<dynamic> getBoardList() {
    _fetchBoards(); // 게시물을 가져온다.
    return _boardList;
  }

  void _fetchBoards() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX");
    List<dynamic> result = (response.data)['result'];
    //print((response.data)['result']);

    _boardList.clear(); // 이전에 저장된 목록을 비운다.
    _boardList.addAll(result);
    notifyListeners(); // 데이터가 업데이트되었음을 리스너에게 알린다.
  }

  /* 사용자 아이디로 보드 가져오기 */
  // final List<dynamic> _boardListForUserId = List.empty(growable: true);
  // List<dynamic> getBoardListByUserId(int userId) {
  //   _fetchBoardsByUserId(userId); // 게시물을 가져온다.
  //   return _boardList;
  // }
  //
  // void _fetchBoardsByUserId(int userId) async {
  //   Response response;
  //   Dio dio = new Dio();
  //   response = await dio.get("$_API_PREFIX", queryParameters: {'user_id': 1});
  //   List<dynamic> result = (response.data)['result'];
  //   //print((response.data)['result']);
  //
  //   _boardListForUserId.clear(); // 이전에 저장된 목록을 비운다.
  //   _boardListForUserId.addAll(result);
  //   //print(_boardList);
  //   notifyListeners();
  // }

  Future<List<dynamic>> fetchBoardsByUserId(int userId) async {
    Response response;
    Dio dio = new Dio();
    response =
        await dio.get("$_API_PREFIX", queryParameters: {'user_id': userId});
    List<dynamic> result = (response.data)['result'];

    // List<Board> boards = (response.data).map<Board>((json) {
    //   return Board.fromJson(json);
    // }).toList();
    return result;

    //print((response.data)['result']);
  }

  /* 옷 아이디로 보드 가져오기 */
  Future<List<dynamic>> fetchBoardsByClothesId(int clothesId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio
        .get("$_API_PREFIX", queryParameters: {'clothes_id': clothesId});
    List<dynamic> result = (response.data)['result'];
    //print(result);
    return result;
  }

  /* 게시글 상세보기 */
  Future<Map<dynamic, dynamic>> getBoardDetail(int boardId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/$boardId");
    Map<dynamic, dynamic> result = (response.data)['result'];
    //print(responseMap['content']);
    return result;
  }

  /* 게시물 업로드 */
  Future<void> createBoard(XFile? showImage, int userId, int preferId,
      int clothesId, String content) async {
    /* 사진부터 업로드해서 url을 받는다 */
    dynamic sendImage = showImage!.path;
    var imageFormData =
        FormData.fromMap({'file': await MultipartFile.fromFile(sendImage)});

    print("사진을 서버에 업로드 합니다.");

    var dio = Dio();
    //dio.options.contentType = Headers.formUrlEncodedContentType;

    try {
      dio.options.contentType = 'multipart/form-data';
      dio.options.maxRedirects.isFinite;

      //dio.options.headers = {'token': token};
      var response = await dio.post(
        'http://ec2-3-39-55-229.ap-northeast-2.compute.amazonaws.com/uploadNewImg',
        data: imageFormData,
      );
      print('성공적으로 업로드했습니다');
      print(response.data['uploadImg']);

      /* 이제 게시물 업로드 */
      Response boardResponse;
      Dio boardDio = new Dio();
      boardResponse = await boardDio.post('$_API_PREFIX/create', data: {
        "userId": userId,
        "preferId": preferId,
        "clothesId": clothesId,
        "content": content,
        "photoUrl": response.data['uploadImg']
      });
      print(boardResponse.data.toString());
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.response?.statusCode}');
        print('Response Data: ${e.response?.data}');
        print('Error: ${e.error}'); // 추가된 부분
      } else {
        print('Unexpected Error: $e');
      }
    }
  }

/* 게시글 삭제 */
  Future<void> deleteBoard(int boardId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/delete/$boardId",
        queryParameters: {'boardId': boardId});
    //Map<dynamic, dynamic> responseMap = (response.data)['result'];
    print(response);
  }
}

BoardProvider boardProvider = BoardProvider();
