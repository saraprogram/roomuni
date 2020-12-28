import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/services.dart';

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  Map<String, String> _localizedStrings;


  /* static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'hello-world': 'Hello world!',
      'hello': 'english!',

    },
    'fr': {
      'hello-world': 'Bonjour le monde!',
      'hello': 'french le monde!',

    },
    'es': {
      'hello-world': 'Hola mundo!',
      'hello': 'Hola mundo!',

    },
    'ru': {
      'hello-world': 'Здравствуй, мир!',
      'hello': 'Здравствуй, мир!',

    },
  };
*/
  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
    await rootBundle.loadString('i18n/${locale.languageCode}.json');
    print("route bundle------------------$jsonString");
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }


  String translate(String key) {
    //return _localizedValues[locale.languageCode][key] ?? '** $key not found';
    return _localizedStrings[key];

  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
   ['en', 'fr','ar'].contains(locale.languageCode);
  // ['en', 'fr', 'es', 'ru'].contains(locale.languageCode);


  @override
  Future<AppLocalization> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalization localizations = new AppLocalization(locale);
    await localizations.load();
    return localizations;
  }


  /*
  @override
  Future<AppLocalization> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<AppLocalization>(
      AppLocalization(locale),
    );
  }
*/
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}