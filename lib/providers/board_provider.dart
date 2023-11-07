import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/board_model.dart';

const _API_PREFIX =
    'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/boards';

class BoardProvider with ChangeNotifier {

  /*보드 전체 가져오기*/
  final List<Board> _boardList = List.empty(growable: true);

  List<Board> getBoardList() {
    _fetchBoards(); // 게시물 목록을 가져온다.
    return _boardList;
  }

  void _fetchBoards() async {
    final response = await http
        .get(Uri.parse('$_API_PREFIX')); // 서버에서 게시물 데이터를 가져오는 GET 요청을 보낸다.

    final List<Board> result =
        jsonDecode(response.body)["result"] // JSON 문자열을 파싱하여 Dart의 Map 형태로 변환
            .map<Board>((json) =>
                Board.fromJson(json)) // Map에서 각 JSON 객체를 Board 모델로 mapping
            .toList(); // 리스트로 변환
    //print(jsonDecode(response.body)["result"]);

    _boardList.clear(); // 이전에 저장된 목록을 비운다.
    _boardList.addAll(result);
    notifyListeners(); // 데이터가 업데이트되었음을 리스너에게 알린다.
  }

  /*게시물 업로드*/
  Future<String> createBoard(XFile? showImage) async {
    String uri = 'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/boards';
    final url = Uri.parse('$uri/create');
    if (showImage == null) {
      return "";
    }
    // open the image file
    final bytes = await showImage.readAsBytes();



    // create the multipart request
    final request = http.MultipartRequest('POST', url)
      ..files.add(http.MultipartFile.fromBytes('photoUrl', bytes,
          filename: 'example.jpg'));


    // print(request);

    // send the request
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    // check the response status code
    if (response.statusCode == 201) {
      final responseJson = jsonDecode(responseBody);
      final imageUrl = responseJson['profile_image_url'];
      print(imageUrl);
      return imageUrl;
    } else {
      throw Exception('Failed to post image');
    }
    // Response response;
    // Dio dio = new Dio();
    // dio.options.headers["Content-Type"] = "multipart/form-data";
    //
    // var formData = FormData.fromMap({
    //   "userId": 1,
    //   "preferId": 1,
    //   "clothesId": 1,
    //   "content": "와라락",
    //   'photoUrl': 'https://i.pinimg.com/564x/cb/84/7e/cb847e424e02a31d20a995f2dbbd3d7a.jpg'
    // });
    //
    // dio.options.contentType = 'multipart/form-data';
    // dio.options.maxRedirects.isFinite;
    //
    // response = await dio.post('$_API_PREFIX/create', data: formData);
    // print(response.data.toString());
  }

  Future<void> getBoardDetail(int id) async {
    Response response;
    Dio dio = new Dio();
  }

  Future<void> deleteBoard() async {
    Response response;
    Dio dio = new Dio();
  }

}

BoardProvider boardProvider = BoardProvider();
