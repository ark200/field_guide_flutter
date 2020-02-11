import 'dart:core';

import 'package:http/http.dart' as http;
class NetworkCall
{
  var boddy;
  var status;

  NetworkCall(this.boddy,this.status);
}

class ApiCall
{
  static final String TAG = "ApiCall";
  static String web_url = "http://18.191.40.18/";
  static String end_url = "&key=AIzaSyArDc0ju05bFkYGy4D90Dv9bAYl9hII5Ws";

  static Future<http.Response> makeGetRequest(url) async
  {
//    return http.get(web_url+url);
    http.Response response = await http.get(web_url+url);
    return response;
  }


}

