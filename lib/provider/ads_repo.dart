
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';
import 'dart:async';
import 'dart:convert';

import 'package:roomie/provider/providers.dart';

class AdsRepository {
  Future<List<Ads>> fetchAdsDetails() async {
    print('repo1');
    String token = await UserPreferences().getToken();
    print('token ******* $token');
    final response = await HttpClient.instance.fetchData(APIPathHelper.getValue(APIPath.fetch_ads) ,token );
    print('repo2 - ${response}');
    print('repo3 - ${response['data']}');
    final items = response['data'].cast<Map<String, dynamic>>();
    print('repo4 - $items');
    //print("Response - ${Ads.fromJson(response['data'])}");
    List<Ads> listOfUsers =  items.map<Ads>((json) {
      return Ads.fromJson(json);
    }).toList();
    print("list ads----------------$listOfUsers");
    return listOfUsers;
    //return Users.fromJson(response);
  }
}
