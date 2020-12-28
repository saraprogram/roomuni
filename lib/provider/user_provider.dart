import 'package:flutter/foundation.dart';
import 'package:roomie/model/models.dart';

class UserProvider with ChangeNotifier {
  Users _user = new Users();

  Users get user => _user;

  void setUser(Users user) {
    _user = user;
    notifyListeners();
  }
}
