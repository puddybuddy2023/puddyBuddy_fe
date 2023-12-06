import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  int? userId;
  String? nickname;

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
    //return userId!;
  }

  Future<void> getUserNickname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nickname = prefs.getString('nickname');
    //return nickname!;
  }
}

UserInfo userInfo = UserInfo();
