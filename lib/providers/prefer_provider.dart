import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/prefer_model.dart';


class BoardProvider with ChangeNotifier {
  final List<Prefer> _boardList = List.empty(growable: true);

  List<Prefer> getPreferList() {
    _fetchBoards(); // 게시물 목록을 가져온다.
    return _boardList;
  }

  void _fetchBoards() async {
    final response = await http
        .get(Uri.parse('http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/prefers')); // 서버에서 게시물 데이터를 가져오는 GET 요청을 보낸다.

    final List<Prefer> result = jsonDecode(response.body)["result"] // JSON 문자열을 파싱하여 Dart의 Map 형태로 변환
        .map<Prefer>((json) => Prefer.fromJson(json)) // Map에서 각 JSON 객체를 Board 모델로 mapping
        .toList(); // 리스트로 변환

    _boardList.clear(); // 이전에 저장된 목록을 비운다.
    _boardList.addAll(result);
    notifyListeners(); // 데이터가 업데이트되었음을 리스너에게 알린다.
  }
}