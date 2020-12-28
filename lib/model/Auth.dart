import 'package:roomie/model/models.dart';

class AuthResponse {
  final String token;
  Users user;
  final String url;

  AuthResponse({
    this.token,
    this.user,
    this.url,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> parsedJson){
    return AuthResponse(
        token: parsedJson['token'],
        user: Users.fromJson(parsedJson['user'][0]),
        url: parsedJson['image_url']
    );
  }


  Map<String, dynamic> toJson() => {
    'token': token,
    'user':user,
  };
}