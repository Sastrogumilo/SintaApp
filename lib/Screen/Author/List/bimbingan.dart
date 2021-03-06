import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';

Client clientBimbingan = Client();

class BimbinganPage extends StatefulWidget {
  
  @override 
  _BimbinganPageState createState() => new _BimbinganPageState();

}

class _BimbinganPageState extends State<BimbinganPage>{

  Future<List<UserBimbingan>> _getBimbingan() async {
    
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
    
    print("$baseUrl"+"$input"+"$jumlah");
    final response = await clientBimbingan.get("$baseUrl"+"$input"+"$jumlah", headers: headers);
    //print(response.body.toString());
    final dataJson = json.decode(response.body);
    Bimbingan hasilBimbingan = new Bimbingan.fromJson(dataJson);
    //var jsonData = hasil.result; //Data Hasil Olahan
    //print(hasil.result);
    //print(hasil.author);
    
    //List<UserBimbingan> bimbingan = [];
    List<UserBimbingan> bimbingans = [];
    for(var u in hasilBimbingan.resultBimbingan){
      UserBimbingan bimbingan = UserBimbingan(u['dc_title'].toString(), 
                                              u['dc_subject'].toString(), 
                                              u['dc_description'].toString(),
                                              );
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
            future: _getBimbingan(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Align(alignment: Alignment.center,
                  child: CircularProgressIndicator());
                  
                case ConnectionState.done:
                
              //print(snapshot.data.toString());
              if(snapshot.data.length == 0){
                return SizedBox(
                  child: Center(
                    child: Text("Author Belum Pernah Membimbing")));
              } else if (snapshot.hasError){
                  return Container(
                  child: Center(
                    child: Text('Error: ${snapshot.error}')));}
              }return ListView.builder(
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
            ),
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

  UserBimbingan(this.judul, this.subject, this.deskripsi, );
}


class Bimbingan{
  final resultBimbingan;
  //final List<Authors>author;
  
  Bimbingan({
    this.resultBimbingan, 
    //this.author
  });

  factory Bimbingan.fromJson(Map<String, dynamic> parsedJson){

    return Bimbingan(resultBimbingan: parsedJson['author']['bimbingan']['article'],
                      //author: listAuthor,
                    );
  }
}

