import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';

//enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }



class GetImageProvider with ChangeNotifier{

  // Status _status =Status.Uninitialized;
  //Status get status => _status;

  Future<Map> getImage(dynamic adData) async {

    String token = await UserPreferences().getToken();
    print(token);
    print('add advertise section');
    try{
      print("try");
      final response = await HttpClient.instance.postData(APIPathHelper.getValue(APIPath.get_image), adData,token);

        notifyListeners();
return response;

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

