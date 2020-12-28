import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';

//enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }



class AddAdsProvider with ChangeNotifier{

  Ads ad;
  // Status _status =Status.Uninitialized;
  //Status get status => _status;

  Future<Map<String, dynamic>> Advertise(dynamic adData) async {

    String token = await UserPreferences().getToken();
    print(token);
    print('add advertise section');
    try{
      print("try");
      final response = await HttpClient.instance.postData(APIPathHelper.getValue(APIPath.add_ads), adData,token);
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

