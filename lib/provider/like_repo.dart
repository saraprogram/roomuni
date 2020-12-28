
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';
import 'dart:async';
import 'dart:convert';

import 'package:roomie/provider/providers.dart';

class LikeRepository {
  Future<List<Like>> fetchLikeDetails() async {
    print('repo1-likeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    String token = await UserPreferences().getToken();
    print('token ******* $token');
    print('url------------------${APIPathHelper.getValue(APIPath.fetch_like)}');
    final response = await HttpClient.instance.fetchData(APIPathHelper.getValue(APIPath.fetch_like),token);
    print('repo2 - likeeeeeeeeeeeeeeeeeeeeee - ${response}');
    print('repo3 - likeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee - ${response['data']}');
    final items = response['data'].cast<Map<String, dynamic>>();
    print("items likeeeeeeeeeee--------------$items");
    List<Like> listOfLikes =  items.map<Like>((json) {
      print("dakheş item shodddddddddddddddddddddddddddddddddddd");
      return Like.fromJson(json);
    }).toList();

    print("loop like tamom.........$listOfLikes");
    return listOfLikes;
    //print("Response - $response");
    //return Users.fromJson(response);
  }
}
