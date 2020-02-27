import 'package:http/http.dart' show Client;
//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

Client client = Client();

Map<String, String> headers = {
  "Application/data" : "wbqbiarjQM0PB1RWzvalXmgZeHhYQBUFrx998d6v",
  "X-Parse-REST-API-Key" : "tucEGaVGztVSvPlPdDuzL6IbvJNs9LSSIZ8H5pT0",
  //"Content-Type" : "application/json"
};

final String baseUrl = "http://api.sinta.ristekdikti.go.id/author/detail/overview/";

Future getAuthorApi(authorId) async {
  String id;
  id = authorId;
  final resoponse = await client.get("$baseUrl"+"$id");
  print(resoponse.toString());

}