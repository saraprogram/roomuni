import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';
import 'package:shared_preferences/shared_preferences.dart';

//enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class LoginProvider with ChangeNotifier{

  Users user;
  ApiResponse<List<LoginR>> _log = ApiResponse.uninitialized('message');

  ApiResponse<List<LoginR>> get logs=> _log;


  // Status _status =Status.Uninitialized;
  //Status get status => _status;

  Future<Map<String, dynamic>> Login(dynamic registerData) async {
    _log = ApiResponse.loading('loading...... ');
    print("satatsttfdgcfdg:,,,,,,,,,,,,,,,,,$_log");

    try{

      print("in data........$registerData");
      final response = await HttpClient.instance.postLogin(APIPathHelper.getValue(APIPath.login), registerData);
      print(response['status']);
      if(response['status'] == 'success')
      {
        var userData = response['data'];
        print("after vared");
        print(userData['user']);

        var userr = Users.fromJson(userData['user'][0]);
        print("userrr");
        print(userr.name);
print(userData);
        var token = new AuthResponse.fromJson(userData);
        print(token.token);

        UserPreferences().saveUser(token);
        // _log = ApiResponse.completed(response);


        notifyListeners();

        return response;

       // final parsed = response.cast<Map<String, dynamic>>();
        print(user);

        var dara = AuthResponse.fromJson(userData);

        print(dara.token);
        /*
        print("Result: ${userData}");
        print(userData['token']);
        print(userData['user']);
        var test = json.encode(response);
         Users authUser = Users.fromJson(response);
        print(authUser.token);*/
        //UserPreferences().saveUser(authUser);
       // SharedPreferences prefs = await SharedPreferences.getInstance();
        //now set the token inside the shared_preferences
        //I assumed that the token is a field in the json response, but check it before!!
        //await prefs.setString('token',userData['token']);
        //notifyListeners();
        //return Users.fromJson(userData);
      }
      else{
        return response['data'];
      }
    }
    catch(e)
    {

      _log = ApiResponse.error(e.toString());
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

