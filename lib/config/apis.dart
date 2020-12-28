import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:roomie/config/configs.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  static final HttpClient _singleton = HttpClient();

  static HttpClient get instance => _singleton;

  Future<dynamic> fetchData(String url,String token, {Map<String, String> params}) async {
    var responseJson;
    var uri = APIBase.baseURL + url + ((params != null) ? this.queryParameters(params) : "");
    var headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};
    //var header = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      final response = await http.get(uri, headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
/*
*************************************************************************
 */
  String queryParameters(Map<String, String> params) {
    if (params != null) {
      final jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }
  /*
  **********************************************************************
   */

  Future<dynamic> postData(String url, dynamic body ,String token,{Map<String, String> params}) async {
    var responseJson1;
   // var header = {HttpHeaders.contentTypeHeader: 'application/json'};
    var headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};
    var uri = APIBase.baseURL + url + ((params != null) ? this.queryParameters(params) : "");

    try {
      final response1 = await http.post(uri, body: body ,headers: headers);
      responseJson1 = _returnResponse(response1);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson1;
  }

  //************************************

  Future<dynamic> postLogout(String url, dynamic body ,String token,{Map<String, String> params}) async {
    var responseJson1;
    var header = {HttpHeaders.contentTypeHeader: 'application/json'};
    var headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};
    var uri = APIBase.baseURL + url + ((params != null) ? this.queryParameters(params) : "");
    print('submit uri ************ $uri');
    print('submit body *********** $body');
    print('header-----------$headers');
    try {
      print('vareddddddddddddddddddddd');
      final response1 = await http.post(uri,headers: headers);
      print('status  ---- ${response1.statusCode}');
      responseJson1 = _returnResponse(response1);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson1;
  }

  //*******************************************


  Future<dynamic> postLogin(String url, dynamic body ,{Map<String, String> params}) async {
    var responseJson;
    var header = {HttpHeaders.contentTypeHeader: 'application/json'};
    var uri = APIBase.baseURL + url + ((params != null) ? this.queryParameters(params) : "");
print(body);
print(uri);
    try {
      final response = await http.post(uri, body: body);
      print(response.statusCode);
      responseJson = _returnResponse(response);
      print('status  -------------------------------------------- ${responseJson}');
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  /*

   */

  dynamic _returnResponse(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        //print('status check - ${json.decode(response.body)}');
        var responseJson = json.decode(response.body);
        print("dakhel return");
        print(response.body);
        print("response likeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee$responseJson");
        return responseJson;
      case 201:
        //print('status check - ${json.decode(response.body)}');
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
        throw UnauthorisedException('Invalid user or password');
      case 403:
        throw UnauthorisedException(response.body);
      case 404:
        throw UnauthorisedException(response.body);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
