import 'package:flutter/foundation.dart';

class APIBase{
  static String get baseURL {
    print(kReleaseMode);
    if (kReleaseMode) {
      return "http://foodsuggest.net/api/v1";
    } else {
      return "http://localhost:8000/api/v1";
      //return "http://foodsuggest.net/api/v1";



    }

  }
}