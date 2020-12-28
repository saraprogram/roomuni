import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {

  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");

  AppLanguage() {
    //_adsRepository = AdsRepository();
    fetchLocale();
  }

  void fetchLocale() async {
    print("app lan vared shod");

    var prefs = await SharedPreferences.getInstance();

    print(prefs.getString('language_code'));

    if (prefs.getString('language_code') == null) {
      prefs.setString('language_code', 'en');
      _appLocale = Locale(prefs.getString('language_code'));
      //return Null;
    }else{
    _appLocale = Locale(prefs.getString('language_code'));
    //return Null;
      }
  }


  void changeLanguage(Locale type) async {
    print("change language--------------------$type");
    print(_appLocale);
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      print(_appLocale);
      return;
    }
    if (type == Locale("es")) {
      print("arabic");
      _appLocale = Locale("es");
      await prefs.setString('language_code', 'es');
      await prefs.setString('countryCode', '');
    } else {
      print("enlish");
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
