
class Questions {
  int queId;
  int userId;
  String title;
  String description;
  int replies_count;
  int likes_count;
  String university;
  String city;
  String tag;
  String userName;
  String createAt;
  String userImage;


  Questions({
    this.queId,
    this.userId,
    this.title,
    this.description,
    this.replies_count,
    this.likes_count,
    this.university,
    this.city,
    this.tag,
    this.userName,
    this.createAt,
    this.userImage,

  });

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      queId: json["id"],
      userId: json["userId"],
      title: json["title"],
      description: json["description"],
      replies_count: json["replies_count"],
      likes_count: json["likes_count"],
      university: json["university"],
      city: json["city"],
      tag: json["tag"],
      userName: json["user_name"][0]["name"],
      userImage: json["user_avatar"][0]["avatar"],
      //createAt: json["created_at"],

    );
  }
}

