import 'package:flutter/material.dart';
import '../models/breed_tags_model.dart';
import 'package:dio/dio.dart';

const _API_PREFIX = 'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/breedTags';

class BreedTagProvider with ChangeNotifier {

  Future<Map<dynamic, dynamic>> fetchBreedTagById(int breedTagId) async{
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/$breedTagId");
    Map<dynamic, dynamic> responseMap = (response.data)['result'];
    print(responseMap['breedTagName']);
    return responseMap;
  }



}

BreedTagProvider breedTagProvider = BreedTagProvider();