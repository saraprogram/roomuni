import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';

//enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }



class UpdateUserProvider with ChangeNotifier{


  Future<Map<String, dynamic>> updateUser(dynamic adData) async {

    String tokenn = await UserPreferences().getToken();
    print('update user section');
    try{
      print("try update");
      final response = await HttpClient.instance.postData(APIPathHelper.getValue(APIPath.update), adData,tokenn);
      print(response['status']);
      if(response['status'] == 'success')
      {

        var userData = response['data'];
        print("after vared");
        print(userData['user']);
        var userr = Users.fromJson(userData['user']);
        print(userr.name);

        // _log = ApiResponse.completed(response);


        notifyListeners();
        //AuthResponse saveUser = AuthResponse.fromJson(bb);
        //UserPreferences().saveUser(saveUser);

        //return response;
        return {
          'status': 'success',
          'message': 'Successfully registered',
          'data': response,
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

