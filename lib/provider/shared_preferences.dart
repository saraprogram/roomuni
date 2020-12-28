import 'package:roomie/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future<bool> saveUser(AuthResponse user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('shared vared shod');
    prefs.setInt("userId", user.user.userId);
    prefs.setString("name", user.user.name);
    prefs.setString("email", user.user.email);
    prefs.setString("token", user.token);
    prefs.setString("gender", user.user.gender);
    prefs.setString("avatar", user.user.avatar);
    prefs.setString("imageurl", user.url);

    //prefs.setInt("approve_policy", user.user.approve_policy);
   //,
    //
    //
    //
    // prefs.setInt("approve_terms", user.user.approve_terms);
    //prefs.setString("approve_terms", user.user.email_verified_at);


    /*
    prefs.setInt("userId", user.userId);
    prefs.setString("name", user.name);
    prefs.setString("email", user.email);
    prefs.setString("token", user.token);
    prefs.setString("gender", user.gender);
    prefs.setString("avatar", user.avatar);
    prefs.setString("approve_policy", user.approve_policy);
    prefs.setString("approve_terms", user.approve_terms);
    prefs.setString("approve_terms", user.email_verified_at);
    */


    print("save user object prefere");
    print(user.user.name);
    print(user.url);
    //print(prefs.getString('token'));

    return true;
  }


  Future<Users> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("userId");
    String name = prefs.getString("name");
    String email = prefs.getString("email");
    String gender = prefs.getString("gender");
    String avatar = prefs.getString("avatar");
    //String url = prefs.getString("imageurl");




    print("get current user ********************************************$name");

    return Users(
        userId: userId,
        name: name,
        email: email,
        gender: gender,
        avatar: avatar,
        );
  }

  Future<String> getimage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = prefs.getString("imageurl");
    return url;
  }


  Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userId");

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("gender");
    prefs.remove("avatar");
    prefs.remove("token");

    return true;
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
