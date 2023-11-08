import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/prefer_model.dart';
import 'package:dio/dio.dart';

const _API_PREFIX = 'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/prefers';

class PreferProvider with ChangeNotifier {

  Future<Map<dynamic, dynamic>> fetchPreferById(int uid) async{
    Response response;
    Dio dio = new Dio();
    response = await dio.get("$_API_PREFIX/$uid");
    Map<dynamic, dynamic> responseMap = (response.data)['result'][0];
    //print(_responseMap['name']);
    return responseMap;

  }
}

PreferProvider preferProvider = PreferProvider();