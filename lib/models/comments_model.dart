class Comment {
  late int commentId;
  late int userId;
  late int boardId;
  late String content;

  Comment({
    required this.commentId,
    required this.userId,
    required this.boardId,
    required this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        commentId: json['commentId'],
        userId: json['userId'],
        boardId: json['boardId'],
        content: json['content']);
  }
}