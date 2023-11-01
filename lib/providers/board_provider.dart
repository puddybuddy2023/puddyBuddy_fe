import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/board_model.dart';


class BoardProvider with ChangeNotifier {
  final List<Board> _boardList = List.empty(growable: true);

  List<Board> getBoardList() {
    _fetchBoards();
    return _boardList;
  }

  void _fetchBoards() async {
    final response = await http
        .get(Uri.parse('http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/boards'));
    final List<Board> result = jsonDecode(response.body)
        .map<Board>((json) => Board.fromJson(json))
        .toList();

    _boardList.clear();
    _boardList.addAll(result);
    notifyListeners();
  }
}