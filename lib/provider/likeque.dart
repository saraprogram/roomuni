import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';

//enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }



class AddqueLikeProvider with ChangeNotifier{

  Like like;
  bool toggle;
  // Status _status =Status.Uninitialized;
  //Status get status => _status;

  Future<bool> AddqueLike(dynamic adData) async {

    String token = await UserPreferences().getToken();
    print(token);
    print('add like question section');
    try{
      print("like question");
      final response = await HttpClient.instance.postData(APIPathHelper.getValue(APIPath.add_que_like), adData,token);
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

        return toggle = true;

      }
    }
    catch(e)
    {
      //_status = Status.Unauthenticated;
      notifyListeners();
      return toggle = false;
    }

  }

}

