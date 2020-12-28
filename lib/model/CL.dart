class Reply {
  int rId;
  int queId;
  int userId;
  String description;
  String userName;
  String userImage;
  String createAt;

  Reply({
    this.rId,
    this.queId,
    this.userId,
    this.description,
    this.userName,
    this.userImage,
    this.createAt,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      rId: json["id"],
      queId: json["questionId"],
      userId: json["userId"],
      description: json["description"],
      userName: json["user_name"][0]["name"],
      userImage: json["user_avatar"][0]["avatar"],
      createAt: json["created_at"],

    );
  }
}
