import 'package:flutter/material.dart';
import 'package:roomie/data/demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String FARSI = 'fa';
const String ARABIC = 'ar';
const String HINDI = 'hi';

Future<Locale> setLocale(String languageCode) async {
  print("set lacal");
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  print("set-langcode-----------------$LAGUAGE_CODE");
  print("set- langcode-----------------$languageCode");

  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  print("get lacale");
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  print("get- lancode------------------$languageCode");
  print("get- lancode------------------${_prefs.getString(LAGUAGE_CODE)}");

  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case FARSI:
      return Locale(FARSI, "IR");
    case ARABIC:
      return Locale(ARABIC, "SA");
    case HINDI:
      return Locale(HINDI, "IN");
    default:
      return Locale(ENGLISH, 'US');
  }
}

String getTranslated(BuildContext context, String key) {
  print("translate--------------$key");
  return DemoLocalization.of(context).translate(key);
}
