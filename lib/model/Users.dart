class Users {
  int userId;
  String name;
  String email;
  String password;

  //String email_verified_at;
  //String renewalToken;
  String gender;
  String avatar;
  int approve_policy;
  int approve_terms;
  int replies_count;
  int questions_count;
  int ads_count;

  Users({
    this.userId,
    this.name,
    this.email,
  //this.email_verified_at ,
    this.gender,
    this.avatar,
    this.approve_policy,
    this.approve_terms,
    this.replies_count,
    this.ads_count,
    this.questions_count,
    this.password,
  });

  factory Users.fromJson(Map<String, dynamic> responseData) {
    return Users(
        userId: responseData["id"],
        name: responseData["name"],
        email: responseData["email"],
      //password: responseData["password"],
      gender: responseData["gender"],
        avatar: responseData["avatar"],
        approve_policy: responseData["approve_policy"],
        approve_terms: responseData["approve_terms"],
        replies_count: responseData["replies_count"],
        questions_count: responseData["questions_count"],
        ads_count: responseData["ads_count"]

      //email_verified_at: responseData["email_verified_at"],
    );
  }
}
