import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/prefer_model.dart';

const _API_PREFIX =
    'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/prefers';

class PreferProvider with ChangeNotifier {
  Future<Map<dynamic, dynamic>> fetchPreferById(int uid) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/$uid");
    Map<dynamic, dynamic> result = (response.data)['result'];
    print(result);
    return result;
  }

  final List<dynamic> _preferList = List.empty(growable: true);
  List<dynamic> getPreferList(int userId) {
    _fetchPrefers(userId);
    return _preferList;
  }

  Future<void> _fetchPrefers(int userId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get('$_API_PREFIX/$userId');
    final result = (response.data)['result'];

    _preferList.clear(); // 이전에 저장된 목록을 비운다.
    _preferList.addAll(result);
    notifyListeners(); // 데이터가 업데이트되었음을 리스너에게 알린다.
  }

  Future<void> createPrefer(int uid) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/create/$uid");
    Map<dynamic, dynamic> responseMap = (response.data)['result'][0];
    //print(_responseMap['name']);
  }

  Future<void> deletePrefer(int uid) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/delete/$uid");
    Map<dynamic, dynamic> responseMap = (response.data)['result'][0];
    //print(_responseMap['name']);
  }
}

PreferProvider preferProvider = PreferProvider();
