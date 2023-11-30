import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

const _API_PREFIX =
    "http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/users";

class UserProvider with ChangeNotifier {
  bool exists = false;

  Future<bool> userExists(String email) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.post("$_API_PREFIX/exists",
        queryParameters: {'email': 'puddybuddy2023@gmail.com'});
    print('hello');
    final result = (response.data)['result'];
    print(result);
    return result;
  }
}

UserProvider userProvider = UserProvider();
