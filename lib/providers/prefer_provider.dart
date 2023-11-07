import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/prefer_model.dart';
import 'package:dio/dio.dart';

//const _API_PREFIX = 'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/prefers';

class PreferProvider with ChangeNotifier {
  final Map responseMap = Map<String, dynamic>();

  // Map<String, dynamic> getPreferById(int uid){
  //   fetchPreferById(uid);
  //   return responseMap;
  // }

  Future<void> fetchPreferById(int uid) async{
    Response response;
    Dio dio = new Dio();
    print(uid);
    response = await dio.get("http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/prefers/1");
    //Map<String, dynamic> responseMap = response.data;
    print(response.data.toString());
  }
}

PreferProvider preferProvider = PreferProvider();