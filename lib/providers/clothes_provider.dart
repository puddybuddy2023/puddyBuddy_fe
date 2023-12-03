import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

const _API_PREFIX =
    'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/clothes';

class ClothesProvider with ChangeNotifier {
  /* 옷 검색 */
  Future<List<dynamic>> clothesSearch(int colorId, int sizeClothes_id,
      int personalcolor_id, int store_id) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get('$_API_PREFIX/search', queryParameters: {
      'color_id': colorId,
      'sizeClothes_id': sizeClothes_id,
      'personalcolor_id': personalcolor_id,
      'store_id': store_id,
    });
    List<dynamic> result = (response.data)['result'];
    print(response.data.toString());
    return result;
  }

  // final List<dynamic> _clothesList = List.empty(growable: true);
  //
  // List<dynamic> getClothesList(
  //     int colorId, int sizeClothes_id, int personalcolor_id, int store_id) {
  //   _fetchClothes(colorId, sizeClothes_id, personalcolor_id, store_id);
  //   return _clothesList;
  // }
  //
  // Future<void> _fetchClothes(int colorId, int sizeClothes_id,
  //     int personalcolor_id, int store_id) async {
  //   Response response;
  //   Dio dio = new Dio();
  //   response = await dio.get('$_API_PREFIX/search', queryParameters: {
  //     'color_id': colorId,
  //     'sizeClothes_id': sizeClothes_id,
  //     'personalcolor_id': personalcolor_id,
  //     'store_id': store_id,
  //   });
  //   final result = (response.data)['result'];
  //
  //   //print(response.data.toString());
  //
  //   _clothesList.clear(); // 이전에 저장된 목록을 비운다.
  //   _clothesList.addAll(result);
  //   notifyListeners(); // 데이터가 업데이트되었음을 리스너에게 알린다.
  // }

  /* 옷 id로 옷 정보 가져오기 */
  Future<Map<dynamic, dynamic>> getClothesByClothesId(int clothesId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/$clothesId",
        queryParameters: {'clothes_id': clothesId});
    Map<dynamic, dynamic> result = (response.data)['result'];
    //print(result);
    return result;
  }

  /* 옷 사진 받아오기 */
  Future<Map<dynamic, dynamic>> getClothesPhoto(int clothesId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(
        "http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/clothesPhotos/$clothesId",
        queryParameters: {'clothes_id': clothesId});
    Map<dynamic, dynamic> result = (response.data)['result'];
    //print(result);
    return result;
  }
}

ClothesProvider clothesProvider = ClothesProvider();
