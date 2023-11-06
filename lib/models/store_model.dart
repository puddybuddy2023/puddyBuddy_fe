import 'package:flutter/material.dart';

class Store {
  late int boardId;
  late int userId;
  late int preferId;
  late int clothesId;
  late String content;
  late String create_date;
  late String photoUrl;

  Store({
    required this.boardId,
    required this.userId,
    required this.preferId,
    required this.clothesId,
    required this.content,
    required this.create_date,
    required this.photoUrl,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        boardId: json['boardId'],
        userId: json['userId'],
        preferId: json['preferId'],
        clothesId: json['clothesId'],
        content: json['content'],
        create_date: json['create_date'],
        photoUrl: json['photoUrl']);
  }
}