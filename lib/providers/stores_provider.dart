import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

const _API_PREFIX = 'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/stores';

class StoresProvider with ChangeNotifier {
  final List<dynamic> _storesList = List.empty(growable: true);

  List<dynamic> getStoreList(int boardId) {
    _fetchStores(boardId);
    return _storesList;
  }

  Future<void> _fetchStores(int boardId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get('$_API_PREFIX/$boardId');
    final result = (response.data)['result'];
    //Map<String, dynamic> responseMap = response.data;
    //print(response.data.toString());

    // final List<Comment> result = (response.data)["result"] // JSON 문자열을 파싱하여 Dart의 Map 형태로 변환
    //     .map<Comment>((json) => Comment.fromJson(json)) // Map에서 각 JSON 객체를 Board 모델로 mapping
    //     .toList(); // 리스트로 변환

    _storesList.clear(); // 이전에 저장된 목록을 비운다.
    _storesList.addAll(result);
    notifyListeners(); // 데이터가 업데이트되었음을 리스너에게 알린다.

  }
}

StoresProvider storesProvider = StoresProvider();