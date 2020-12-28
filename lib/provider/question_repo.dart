
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';
import 'dart:async';
import 'dart:convert';

import 'package:roomie/provider/providers.dart';

class QuestionRepository {
  Future<List<Questions>> fetchQuestionDetails() async {
    //print('repo1-post');
    String token = await UserPreferences().getToken();
    //print('token ******* $token');
    //print('url------------------${APIPathHelper.getValue(APIPath.fetch_question)}');
    final response = await HttpClient.instance.fetchData(APIPathHelper.getValue(APIPath.fetch_question) , token);
    print('repo2 - post - ${response}');
    print('repo3 - post - ${response['data']}');
    final items = response['data'].cast<Map<String, dynamic>>();
    print("Response - $items");
    List<Questions> listOfUsers =  items.map<Questions>((json) {
      print("fromjsonnnnnnnnnnnnnnnnnnnnnnnnnnn");
      return Questions.fromJson(json);
    }).toList();
    print("Response - $listOfUsers");
    return listOfUsers;
    //print("Response - $response");
    //return Users.fromJson(response);
  }
}
