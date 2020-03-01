import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

Client clientAuthor = Client();

final String baseUrl = "http://api.sinta.ristekdikti.go.id/asean_benchmark/";

Map<String, dynamic> listData;

getTokenBenchmark() async {
  final pref = await SharedPreferences.getInstance();
  String token = pref.getString("token");
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
  String token = getTokenBenchmark();
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  final response = await clientAuthor.get("$baseUrl", headers: headers);
  print("Response = "+ response.statusCode.toString());
  //print(response.body.toString());
  //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
  //print(hasilData.name);
  final data = jsonDecode(response.body);
  return data;
}
