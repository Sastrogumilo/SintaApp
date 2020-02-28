import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

/* 
{
    "result": {
        "authors": [],
        "affiliations": [],
        "journals": [],
        "documents": []
    }
}
*/

class Cari{
  final result;
  
  Cari({this.result,});

  factory Cari.fromJson(Map<String, dynamic> parsedJson){
    return Cari(result: parsedJson['result']['authors']);
  }

}

Client client = Client(); 

final String baseUrl = "http://api.sinta.ristekdikti.go.id/search?q=";

Future cariApi(query) async {

  String input = query;
  
  final pref = await SharedPreferences.getInstance();
  String token = pref.getString("token");
  print("Token saat INI "+"$token");

  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };

  final response = await client.get("$baseUrl"+"$input", headers: headers);
  final data = jsonDecode(response.body);
  print(data);
  //print(data.toString());
  //Cari hasil = new Cari.fromJson(data);
  //final hasilData = hasil.result;
  //print(hasilData);

}