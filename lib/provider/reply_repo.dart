
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';
import 'dart:async';
import 'dart:convert';

import 'package:roomie/provider/providers.dart';

class ReplyRepository {
  Future<List<Reply>> fetchReplyDetails() async {
    String token = await UserPreferences().getToken();
    final response = await HttpClient.instance.fetchData(APIPathHelper.getValue(APIPath.fetch_reply),token);
    final items = response['data'].cast<Map<String, dynamic>>();
    List<Reply> listOfReplies =  items.map<Reply>((json) {
      return Reply.fromJson(json);
    }).toList();
    return listOfReplies;
  }
}
