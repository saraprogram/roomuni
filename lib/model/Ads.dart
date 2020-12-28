class Ads {
  int adsId;
  int userId;
  String title;
  String description;
  String tag;
  String university;
  String city;
  String whatsApp;
  String email;
  String userName;
  String userAvatar;

  Ads({
    this.adsId,
    this.userId,
    this.title,
    this.description,
    this.tag,
    this.university,
    this.city,
    this.whatsApp,
    this.email,
    this.userName,
    this.userAvatar,
  });

  factory Ads.fromJson(Map<String, dynamic> json) {
    return Ads(
      adsId: json["id"],
      userId: json["userId"],
      title: json["title"],
      description: json["description"],
      tag: json["tag"],
      university: json["university"],
      city: json["city"],
      whatsApp: json["whatsapp_num"],
      email: json["email"],
      userName: json["user_name"][0]["name"],
      userAvatar: json["user_image"][0]["avatar"],
    );
  }
}
