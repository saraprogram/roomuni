import 'package:flutter/material.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';

//enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class RegisterProvider with ChangeNotifier{

  Users user;
 // Status _status =Status.Uninitialized;
  //Status get status => _status;

  Future<Map<String, dynamic>> Register(dynamic registerData) async {
    try{
      final response = await HttpClient.instance.postLogin(APIPathHelper.getValue(APIPath.register), registerData);
      if(response['status'] == 'success')
      {
        var userData = response['data'];
        Users authUser = Users.fromJson(userData);
        //UserPreferences().saveUser(authUser);
        return {
          'status': true,
          'message': 'Successfully registered',
          'data': authUser,
        };
      }
    }
    catch(e)
    {
      //_status = Status.Unauthenticated;
      notifyListeners();
      throw(Exception(e));
     /* return {
        'status': false,
        'message': 'faield registered',
        'data': 'authUser'
      }; */
    }

  }

}

