import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';

//enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }



class RemoveReplyProvider with ChangeNotifier{

  Reply reply;
  // Status _status =Status.Uninitialized;
  //Status get status => _status;

  Future<Map<String, dynamic>> RemoveReply(dynamic adData) async {

    String token = await UserPreferences().getToken();
    print(token);
    print('remove question section');
    try{
      print("try remove");
      final response = await HttpClient.instance.postData(APIPathHelper.getValue(APIPath.remove_reply), adData,token);
      print(response['status']);
      if(response['status'] == 'success')
      {
        var adData = response['data'];
        print('data');
        print(adData);
        //Ads Adsadd = Ads.fromJson(adData);
        //print(Adsadd);
        //UserPreferences().saveUser(authUser);
        notifyListeners();

        //return response;
        return {
          'status': true,
          'message': 'Successfully registered',
          'data': adData,
        };
      }
    }
    catch(e)
    {
      //_status = Status.Unauthenticated;
      notifyListeners();
      return {
        'status': false,
        'message': 'faield registered',
        'data': 'authUser'
      };
    }

  }

}

