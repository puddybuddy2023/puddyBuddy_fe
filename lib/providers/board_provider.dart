import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _API_PREFIX =
    'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/boards';

class BoardProvider with ChangeNotifier {

  /*보드 전체 가져오기*/
  final List<dynamic> _boardList = List.empty(growable: true);

  List<dynamic> getBoardList() {
    _fetchBoards(); // 게시물 목록을 가져온다.
    return _boardList;
  }

  void _fetchBoards() async {
    // final response = await http
    //     .get(Uri.parse('$_API_PREFIX')); // 서버에서 게시물 데이터를 가져오는 GET 요청을 보낸다.
    //
    // final List<Board> result =
    //     jsonDecode(response.body)["result"] // JSON 문자열을 파싱하여 Dart의 Map 형태로 변환
    //         .map<Board>((json) =>
    //             Board.fromJson(json)) // Map에서 각 JSON 객체를 Board 모델로 mapping
    //         .toList(); // 리스트로 변환
    // print(jsonDecode(response.body)["result"]);

    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX");
    List<dynamic> result = (response.data)['result'];
    //print((response.data)['result']);

    _boardList.clear(); // 이전에 저장된 목록을 비운다.
    _boardList.addAll(result);
    //print(_boardList);
    notifyListeners(); // 데이터가 업데이트되었음을 리스너에게 알린다.
  }

  /* 게시물 업로드 */
  Future<void> createBoard(XFile? showImage, int userId, int preferId, int clothesId, String content) async {
    /* 사진부터 업로드해서 url을 받는다 */
    dynamic sendImage = showImage!.path;
    var imageFormData = FormData.fromMap({'file': await MultipartFile.fromFile(sendImage)});

    print("사진을 서버에 업로드 합니다.");
    var dio = Dio();
    //dio.options.contentType = Headers.formUrlEncodedContentType;

    try {
      dio.options.contentType = 'multipart/form-data';
      dio.options.maxRedirects.isFinite;

      //dio.options.headers = {'token': token};
      var response = await dio.post(
        'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/uploadNewImg',
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
      //print(boardResponse.data.toString());


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

  Future<Map<dynamic, dynamic>> getBoardDetail(int boardId) async{
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/$boardId");
    Map<dynamic, dynamic> responseMap = (response.data)['result'];
    //print(responseMap['content']);
    return responseMap;
  }


  Future<void> deleteBoard(int boardId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/delete/$boardId");
    //Map<dynamic, dynamic> responseMap = (response.data)['result'];
    print(response);
  }
}

BoardProvider boardProvider = BoardProvider();
