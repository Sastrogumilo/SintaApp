import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

Client client = Client();

final baseUrl = "http://api.sinta.ristekdikti.go.id/";
final login = "fusio/public/index.php/consumer/login";

Map<String, String> headers = {};

class DebugInisialisasi{
  String error;
  DebugInisialisasi({this.error});

  factory DebugInisialisasi.fromJson(Map<String, dynamic> parsedJson) {
    return DebugInisialisasi(error: parsedJson['error']);
  }
}

class LoginToken{
  dynamic token;

  LoginToken({
    this.token,
  });
  factory LoginToken.fromJson(Map<String, dynamic> parsedJson){
    return LoginToken(
      token: parsedJson["token"],
    );
  }
}


Future getToken() async {

  var pref = await SharedPreferences.getInstance();
  Map<String, String> bodyLogin = {
    "username":"lombasinta",
    "password":"lombasinta123"
  };
  String body = jsonEncode(bodyLogin);

  var response = await client.post("$baseUrl"+"$login", body: body);
  print("Login = "+ response.statusCode.toString());

  final data = jsonDecode(response.body); 
  LoginToken _token = new LoginToken.fromJson(data);
  pref.setString("token", _token.token);
  //print(_token.token);
  //String new_token = pref.getString('token');
  //print(new_token);
}





