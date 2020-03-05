import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/API/Search/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class BimbinganPage extends StatefulWidget {
  
  @override 
  _BimbinganPageState createState() => new _BimbinganPageState();

}
List<UserBimbingan> bimbingans = [];

class _BimbinganPageState extends State<BimbinganPage>{

  Future<List<UserBimbingan>> _getUsers() async {
    
    final String baseUrl = "http://api.sinta.ristekdikti.go.id/author/detail/bimbingan/";
    final String jumlah = "?items=1000";
    
    final pref = await SharedPreferences.getInstance();
    String input = pref.getString('nidn');
    //String input = "54481";
    //print(input);
    String token = pref.getString("token");
    //print("Token saat INI "+"$token");

    Map<String, String> headers = {
    "Content-Type" : "application/json",
    "Authorization" : "Bearer "+"$token",
    };

    final response = await client.get("$baseUrl"+"$input"+"$jumlah", headers: headers);
    final dataJson = jsonDecode(response.body);
    Bimbingan hasil = new Bimbingan.fromJson(dataJson);
    //var jsonData = hasil.result; //Data Hasil Olahan
    //print(hasil.result);
    //print(hasil.author);
    
    //List<UserBimbingan> bimbingan = [];

    for(var u in hasil.result){
      UserBimbingan bimbingan = UserBimbingan(u['dc_title'], u['dc_subject'], u['dc_description'], u['authors']);
      bimbingans.add(bimbingan);
    }
    //print(users);
    //print(users.length);
    return bimbingans; 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Daftar Artikel Bimbingan'),
        leading: new IconButton(icon: new Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))),
        body: Container(
          child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Align(alignment: Alignment.center,
                  child: CircularProgressIndicator());
                  
                case ConnectionState.done:
              //print(snapshot.data);
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Author Belum Pernah Membimbing")));
              } else if (snapshot.hasError){
                  return Container(
                  child: Center(
                    child: Text('Error: ${snapshot.error}')));
              } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    
                    return ListTile(
                      leading: CircleAvatar(
                       radius: 20,
                       child: ClipOval(
                         child: Image.asset('assets/image/person.png'),
                       ),
                      ),
                       title: Text(snapshot.data[index].judul),
                       subtitle: Text(snapshot.data[index].subject),
                       onTap: (){
                         //idTap(snapshot.data[index]);
                         Navigator.push(context, 
                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                         );
                       },
                      );
                    },
                );
              }
            }
            }),
        ),
      );
  }
}

class DetailPage extends StatelessWidget{
  final UserBimbingan user;

  DetailPage(this.user);
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: 
                      Builder(
                        builder: (BuildContext context){
                          return IconButton(icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                              );
                            }
                          ),
        title: Text(user.judul),
      ),
      body: Container(
        child: Text(user.deskripsi),
      ),
    );
  }

}

class UserBimbingan {
  final judul;
  final subject;
  final deskripsi;
  var author;
  UserBimbingan(this.judul, this.subject, this.deskripsi, this.author);
}


class Bimbingan{
  final result;
  //final List<Authors>author;
  
  Bimbingan({
    this.result, 
    //this.author
  });

  factory Bimbingan.fromJson(Map<String, dynamic> parsedJson){
    
    //var list = parsedJson['author']['bimbingan']['article']as List;

    //List<Authors> listAuthor = list.map((i) => Authors.fromJson(i)).toList();

    return Bimbingan(result: parsedJson['author']['bimbingan']['article'],
                      //author: listAuthor,
                    );
  }
}

