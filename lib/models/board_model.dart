class Board {
  late int? boardId;
  late int? userId;
  late String? nickname;
  late String? email;
  late String? content;

  late String photoUrl;

  Board({
    required this.boardId,
    required this.userId,
    required this.nickname,
    required this.email,
    required this.content,

    required this.photoUrl,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
        boardId: json['boardId'],
        userId: json['userId'],
        nickname: json['nickname'],
        email: json['email'],
        content: json['content'],
        photoUrl: json['photoUrl']);
  }
}
