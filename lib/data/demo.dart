import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization {
  DemoLocalization(this.locale);

  final Locale locale;
  static DemoLocalization of(BuildContext context) {
    print("dakhel demo");
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  Map<String, String> _localizedValues;

  Future<void> load() async {
    print('i18n/${locale.languageCode}.json');
    String jsonStringValues =
    await rootBundle.loadString('i18n/${locale.languageCode}.json');
    print("rootbndle-----------------$jsonStringValues");
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    print("local val");
    print(_localizedValues[key]);
    return _localizedValues[key];
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<DemoLocalization> delegate =
  _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fa', 'ar', 'hi'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    print("dakheı ye ja dg");
    print(locale);
    DemoLocalization localization = new DemoLocalization(locale);
    await localization.load();
    print(localization);
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalization> old) => false;
}
