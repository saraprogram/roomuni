import 'package:flutter/material.dart';
import 'package:roomie/data/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentData with ChangeNotifier {
  String currentLanguage;
  Locale locale;

  LanguageHelper languageHelper = LanguageHelper();

  Locale get getlocale => locale;



  CurrentData() {
    //_adsRepository = AdsRepository();
    fetchLocale();
  }

  void fetchLocale() async {
    print("app lan vared shod");

    var prefs = await SharedPreferences.getInstance();

    print('lan code-----------------${prefs.getString('language_code')}');

    if (prefs.getString('language_code') == null) {
      prefs.setString('language_code', 'en');
      locale = Locale(prefs.getString('language_code'));
      //return Null;
    }else{
      locale = Locale(prefs.getString('language_code'));
      //return Null;
    }
  }








  Future<void> changeLocale(String newLocale) async {

    print('change lan ');
    Locale convertedLocale;
    var prefs = await SharedPreferences.getInstance();


    currentLanguage = newLocale;

    print('current lan in chnage function------------------$currentLanguage');

    convertedLocale = languageHelper.convertLangNameToLocale(newLocale);
    locale = convertedLocale;
    print('locale------------------------$locale');
    print(locale.languageCode);
    await prefs.setString('language_code', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode);

    notifyListeners();
  }

  defineCurrentLanguage(context) {
    String definedCurrentLanguage;
print("define current lan");
    if (currentLanguage != null){
      print('current lan ---------------------$currentLanguage');
      definedCurrentLanguage = currentLanguage;

    }
    else {
      print(
          "locale from currentData: ${Localizations.localeOf(context).toString()}");
      definedCurrentLanguage = languageHelper
          .convertLocaleToLangName(Localizations.localeOf(context).toString());
    }

    return definedCurrentLanguage;
  }
}