import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

//enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class GetUserProvider with ChangeNotifier{

  Users user;
  //ApiResponse<List<LoginR>> _log = ApiResponse.uninitialized('message');

  //ApiResponse<List<LoginR>> get logs=> _log;


  // Status _status =Status.Uninitialized;
  //Status get status => _status;

  Future<Map<String, dynamic>> Getuser() async {
    //_log = ApiResponse.loading('loading...... ');
    String tokenn = await UserPreferences().getToken();

    try{
      print("get userrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      final response = await HttpClient.instance.fetchData(APIPathHelper.getValue(APIPath.get_user), tokenn);
      print(response['status']);
      if(response['status'] == 'success')
      {
        var userData = response['data'];
        print("after vared");
        print(userData['image_url']);
        print(userData);
        var userr = Users.fromJson(userData['user'][0]);
        print(userr.name);
        var  data={
          'token' : tokenn,
          'user' : userData['user'],
          'image_url' : userData['image_url'],
        };
         print(data);
        var token = new AuthResponse.fromJson(data);
        print("toye getusser");
        print(token.token);
        print(token.url);

        var result = UserPreferences().saveUser(token);
       // _log = ApiResponse.completed(response);
        print("after getusser");
print(result);
        print(response);

        notifyListeners();

        return response;

      }
    }
    catch(e)
    {

      //_log = ApiResponse.error(e.toString());
      notifyListeners();
      print("exception---------------------------------");
      print(e);
      print(e.toString());
      //print(_log);
      throw(Exception(e));
      //_status = Status.Unauthenticated;
      notifyListeners();
      //print('e error,,,,,,,,,,,,,,,,');
      //print(e);
      //throw e;
      //throw UnauthorisedException(response.body);
    }

  }

}

