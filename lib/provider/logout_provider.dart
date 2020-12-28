import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';

//enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }



class LogoutProvider with ChangeNotifier{


  Future<Map<String, dynamic>> Logout(dynamic adData) async {

    String token = await UserPreferences().getToken();
    print(token);
    print('remove question section');
    try{
      print("try remove");
      final response = await HttpClient.instance.postLogout(APIPathHelper.getValue(APIPath.logout), adData,token);
      print(response['status']);
      if(response['status'] == 'success')
      {
        var adData = response['data'];
        var remove = await UserPreferences().removeUser();
        print(remove);
        print('data');
        print(adData);
        notifyListeners();

        //return response;
        return {
          'status': 'success',
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

