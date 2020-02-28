import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:sinta_app/API/Author/author_deserial.dart';
//import 'dart:async';

Client clientAuthor = Client();

final String baseUrl = "http://api.sinta.ristekdikti.go.id/journal/";
final String overview = "detail/";

String token;
String id;
Map<String, dynamic> listData;

getTokenJournal() async {
  final pref = await SharedPreferences.getInstance();
  token = pref.getString("token");
  print("Token saat INI "+"$token");

  return token;
}
/*

getAuthor(authorId) async {
  
  getToken();
  id = authorId;
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  print("ID = "+id);
  
  for(String fitur in listFitur){
    //print("Fitur Sekarang = "+"$baseUrl"+"$fitur");
    final response = await clientAuthor.get("$baseUrl"+"$fitur"+"$id", headers: headers);
    print("Response Fitur $fitur = "+ response.statusCode.toString());
    //print(response.body.toString());
    //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
    //print(hasilData.name);
    listData = jsonDecode(response.body);
    //listData.add(data);
  }
  print(listData);
    
  return listData;
}
*/

getJournalOverview(afiId) async {
  getTokenJournal();
  id = afiId;
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  final response = await clientAuthor.get("$baseUrl"+"$overview"+"$id", headers: headers);
  print("Response = "+ response.statusCode.toString());
  //print(response.body.toString());
  //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
  //print(hasilData.name);
  final data = jsonDecode(response.body);
  return data;
}
