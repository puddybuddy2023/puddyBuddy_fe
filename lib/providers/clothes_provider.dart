import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

const _API_PREFIX = 'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/stores';

class ClothesProvider with ChangeNotifier {
  final List<dynamic> _clothesList = List.empty(growable: true);

  List<dynamic> getClothesList() {
    _fetchClothes();
    return _clothesList;
  }

  Future<void> _fetchClothes() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get('$_API_PREFIX');
    final result = (response.data)['result'];

    //print(response.data.toString());


    _clothesList.clear(); // 이전에 저장된 목록을 비운다.
    _clothesList.addAll(result);
    notifyListeners(); // 데이터가 업데이트되었음을 리스너에게 알린다.

  }
}

ClothesProvider clothesProvider = ClothesProvider();