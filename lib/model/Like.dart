class Like {
  int lId;
  int userId;
  int queId;
  int like;

  Like({
    this.lId,
    this.queId,
    this.userId,
    this.like,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      lId: json["id"],
      queId: json["que_id"],
      userId: json["user_id"],
      like: json["like"],
    );
  }
}