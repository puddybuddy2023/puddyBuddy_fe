import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const _API_PREFIX =
    'http://ec2-3-39-55-229.ap-northeast-2.compute.amazonaws.com/petsize';

class SizeMeasure with ChangeNotifier {
  Future<Map<dynamic, dynamic>> MeasureResult(int preferId, int breedTagId,
      double neck, double chest, double back, double leg) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.post(
      "$_API_PREFIX/create",
      data: {
        'preferId': preferId,
        'breedTagId': breedTagId,
        'neck': neck,
        'chest': chest,
        'back': back,
        'leg': leg
      },
    );
    Map<dynamic, dynamic> result = (response.data)['result'];
    print(result);
    return result;
  }

  Future<Map<dynamic, dynamic>> getSizeInfo(int petSizeId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/getInfo/$petSizeId",
        data: {
          'petsizeId': petSizeId,
        },
        options: Options(contentType: Headers.jsonContentType));
    Map<dynamic, dynamic> result = (response.data)['result'];
    print(result);
    return result;
  }

  Future<Map<dynamic, dynamic>> getPetSize(int petSizeId) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/show/$petSizeId",
        data: {
          'petsizeId': petSizeId,
        },
        options: Options(contentType: Headers.jsonContentType));
    Map<dynamic, dynamic> result = (response.data)['result'];
    print(result);
    return result;
  }
}

SizeMeasure sizeMeasure = SizeMeasure();
