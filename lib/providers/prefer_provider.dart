import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/prefer_model.dart';

const _API_PREFIX =
    'http://ec2-3-39-55-229.ap-northeast-2.compute.amazonaws.com/prefers';

class PreferProvider with ChangeNotifier {
  Future<List<dynamic>> fetchPreferById(int userId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/users/$userId");
    List<dynamic> result = (response.data)['result'];
    //print(result);
    //notifyListeners();
    return result;
  }

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
      "personalColorId": 5,
      "breedTagId": breedTagId
    });
    print((response.data));
  }

  /* 선호조건 삭제 */
  Future<void> deletePrefer(int preferId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/delete/$preferId",
        queryParameters: {'preferId': preferId});
    //Map<dynamic, dynamic> result = (response.data)['result'];
    //print(result);
  }
}

PreferProvider preferProvider = PreferProvider();
