class BoardCreate {
  int? userId;
  int? preferId;
  int? clothesId;
  String? content;
  String? photoUrl;

  BoardCreate(
      {this.userId,
        this.preferId,
        this.clothesId,
        this.content,
        this.photoUrl});

  BoardCreate.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    preferId = json['preferId'];
    clothesId = json['clothesId'];
    content = json['content'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['preferId'] = this.preferId;
    data['clothesId'] = this.clothesId;
    data['content'] = this.content;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}
