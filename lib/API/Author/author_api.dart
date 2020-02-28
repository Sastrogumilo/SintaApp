import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

Client clientAuthor = Client();

final String baseUrl = "http://api.sinta.ristekdikti.go.id/author/detail/overview/";

Future getAuthorApi(authorId) async {

  String id = authorId;
  
  final pref = await SharedPreferences.getInstance();
  String token = pref.getString("token");
  print("Token saat INI "+"$token");

  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  
  id = authorId;
  final resoponse = await clientAuthor.get("$baseUrl"+"$id", headers: headers);
  print("Response = "+ resoponse.statusCode.toString());
  print(resoponse.body.toString());

}