class Board {
  late int boardId;
  late int userId;
  late int preferId;
  late int clothesId;
  late String content;
  late String create_date;
  late String photoUrl;

  Board({
    required this.boardId,
    required this.userId,
    required this.preferId,
    required this.clothesId,
    required this.content,
    required this.create_date,
    required this.photoUrl,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
        boardId: json['boardId'],
        userId: json['userId'],
        preferId: json['preferId'],
        clothesId: json['clothesId'],
        content: json['content'],
        create_date: json['create_date'],
        photoUrl: json['photoUrl']);
  }
}