import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:sinta_app/API/Author/author_deserial.dart';
//import 'dart:async';

Client clientAuthor = Client();

final String baseUrl = "http://api.sinta.ristekdikti.go.id/author/detail/";
final String overview = "overview/";
final String scopus = "scopus/";
final String google = "google/";
final String book = "book/";
final String ipr = "ipr/";
final String bimbingan = "bimbingan/";
final String research = "research/";
final String service = "service/";

var listFitur = ['overview/', 
            "scopus/", 
            "google/", 
            "book/", 
            "ipr/", 
            "bimbingan/",
            "research/",
            "service/",];

String token;
String id;
Map<String, dynamic> listData;

getToken() async {
  final pref = await SharedPreferences.getInstance();
  token = pref.getString("token");
  //print("Token saat INI "+"$token");

  return token;
}

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


getAuthorOverview(authorId) async {
  getToken();
  id = authorId;
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  
  id = authorId;
  final response = await clientAuthor.get("$baseUrl"+"$overview"+"$id", headers: headers);
  //print("Response = "+ response.statusCode.toString());
  //print(response.body.toString());
  //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
  //print(hasilData.name);
  final data = jsonDecode(response.body);
  return data;
}


getAuthorScopus(authorId) async {
  getToken();
  id = authorId;
  String isi = scopus;
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  
  id = authorId;
  final response = await clientAuthor.get("$baseUrl"+"$isi"+"$id", headers: headers);
  print("Response = "+ response.statusCode.toString());
  //print(response.body.toString());
  //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
  //print(hasilData.name);
  final data = jsonDecode(response.body);
  return data;
}


getAuthorGoogle(authorId) async {
  getToken();
  id = authorId;
  String isi = "google/";
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  
  id = authorId;
  final response = await clientAuthor.get("$baseUrl"+"$isi"+"$id", headers: headers);
  print("Response = "+ response.statusCode.toString());
  //print(response.body.toString());
  //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
  //print(hasilData.name);
  final data = jsonDecode(response.body);
  print(response.body.toString());
  return data;
}


getAuthorBook(authorId) async {
  getToken();
  id = authorId;
  String isi = book;
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  
  id = authorId;
  final response = await clientAuthor.get("$baseUrl"+"$isi"+"$id", headers: headers);
  print("Response = "+ response.statusCode.toString());
  //print(response.body.toString());
  //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
  //print(hasilData.name);
  final data = jsonDecode(response.body);
  return data;
}


getAuthorIpr(authorId) async {
  getToken();
  id = authorId;
  String isi = ipr;
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  
  id = authorId;
  final response = await clientAuthor.get("$baseUrl"+"$isi"+"$id", headers: headers);
  print("Response = "+ response.statusCode.toString());
  //print(response.body.toString());
  //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
  //print(hasilData.name);
  final data = jsonDecode(response.body);
  return data;
}


getAuthorBimbingan(authorId) async {
  getToken();
  id = authorId;
  String isi = bimbingan;
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  
  id = authorId;
  final response = await clientAuthor.get("$baseUrl"+"$isi"+"$id", headers: headers);
  print("Response = "+ response.statusCode.toString());
  //print(response.body.toString());
  //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
  //print(hasilData.name);
  final data = jsonDecode(response.body);
  return data;
}


getAuthorResearch(authorId) async {
  getToken();
  id = authorId;
  String isi = research;
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  
  id = authorId;
  final response = await clientAuthor.get("$baseUrl"+"$isi"+"$id", headers: headers);
  print("Response = "+ response.statusCode.toString());
  //print(response.body.toString());
  //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
  //print(hasilData.name);
  final data = jsonDecode(response.body);
  return data;
}


getAuthorService(authorId) async {
  getToken();
  id = authorId;
  String isi = service;
  Map<String, String> headers = {
  "Content-Type" : "application/json",
  "Authorization" : "Bearer "+"$token",
  //"Content-Type" : "application/json"
  };
  
  id = authorId;
  final response = await clientAuthor.get("$baseUrl"+"$isi"+"$id", headers: headers);
  print("Response = "+ response.statusCode.toString());
  //print(response.body.toString());
  //AuthorOverview hasilData = new AuthorOverview.fromJson(data);
  //print(hasilData.name);
  final data = jsonDecode(response.body);
  return data;
}