import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const _API_PREFIX =
    'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/petsize';

class SizeMeasure with ChangeNotifier {
  Future<Map<dynamic, dynamic>> MeasureResult(
      int preferId, int neck, int chest, int back, int leg) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.post("$_API_PREFIX/create",
        data: {
          'preferId': 1,
          'neck': neck,
          'chest': chest,
          'back': back,
          'leg': leg
        },
        options: Options(contentType: Headers.jsonContentType));
    Map<dynamic, dynamic> result = (response.data)['result'];
    print(result);
    return result;
  }

  Future<Map<dynamic, dynamic>> getSizeInfo(
      int breedTagId, int petSizeId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/getInfo",
        data: {
          'breedTag': 1,
          'petsizeId': petSizeId,
        },
        options: Options(contentType: Headers.jsonContentType));
    Map<dynamic, dynamic> result = (response.data)['result'];
    print(result);
    return result;
  }
}

SizeMeasure sizeMeasure = SizeMeasure();
