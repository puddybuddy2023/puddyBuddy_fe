import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/prefer_model.dart';

const _API_PREFIX =
    'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/prefers';

class PreferProvider with ChangeNotifier {
  // Future<List<dynamic>> fetchPreferById(int uid) async {
  //   Response response;
  //   Dio dio = new Dio();
  //   response = await dio.get("$_API_PREFIX/users/$uid");
  //   List<dynamic> result = (response.data)['result'];
  //   //print(result);
  //   //notifyListeners();
  //   return result;
  // }

  final List<dynamic> _preferList = List.empty(growable: true);
  List<dynamic> getPreferListByUserId(int userId) {
    _fetchPrefersByUserId(userId);
    return _preferList;
  }

  Future<void> _fetchPrefersByUserId(int userId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get('$_API_PREFIX/users/$userId');
    final result = (response.data)['result'];

    _preferList.clear(); // 이전에 저장된 목록을 비운다.
    _preferList.addAll(result);
    notifyListeners(); // 데이터가 업데이트되었음을 리스너에게 알린다.
  }

  /* 선호조건 생성 */
  Future<void> createPrefer(
      int userId, String preferName, int breedTagId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.post("$_API_PREFIX/create/$userId", data: {
      "userId": userId,
      "preferName": preferName,
      "chest": 5,
      "back": 5,
      "personalColorId": 1,
      "breedTagId": breedTagId
    });
    print((response.data));
  }

  Future<void> deletePrefer(int userId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/delete/$userId");
    Map<dynamic, dynamic> responseMap = (response.data)['result'];
    //print(_responseMap['name']);
  }
}

PreferProvider preferProvider = PreferProvider();
