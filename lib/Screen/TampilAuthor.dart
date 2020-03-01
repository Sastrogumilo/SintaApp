import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/Constant/constant.dart';
import 'package:sinta_app/API/Search/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
//import 'package:sinta_app/API/Author/author_deserial.dart';
import 'package:sinta_app/API/Author/endpoint_api.dart';
//import 'package:sinta_app/API/Author/Overview/data.dart';

class ListAuthorPage extends StatefulWidget {
  
  @override 
  _ListAuthorPageState createState() => new _ListAuthorPageState();

}

class _ListAuthorPageState extends State<ListAuthorPage>{

  Future<List<User>> _getUsers() async {
    
    final String baseUrl = "http://api.sinta.ristekdikti.go.id/search?q=";
    
    final pref = await SharedPreferences.getInstance();
    String input = pref.getString('query');
    //print(input);
    String token = pref.getString("token");
    print("Token saat INI "+"$token");

    Map<String, String> headers = {
    "Content-Type" : "application/json",
    "Authorization" : "Bearer "+"$token",
    };

    final response = await client.get("$baseUrl"+"$input", headers: headers);
    final dataJson = jsonDecode(response.body);
    Cari hasil = new Cari.fromJson(dataJson);
    //var jsonData = hasil.result; //Data Hasil Olahan
    //print(hasil.result);

    List<User> users = [];

    for(var u in hasil.result){

      User user = User(u["author_id"], u["fullname"], u["NIDN"], u["afiliasi_name"]);
      users.add(user);
    }
    //print(users);
    print(users.length);
    return users; 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Daftar Author'),
        leading: new IconButton(icon: new Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pushReplacementNamed(cari))),
        body: Container(
          child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              //print(snapshot.data);
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading"),
                    
                  ),
                );
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
                       title: Text(snapshot.data[index].fullname),
                       subtitle: Text(snapshot.data[index].afiliasi), 
                       onTap: (){
                         idTap(snapshot.data[index]);
                         Navigator.push(context, 
                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                         );
                       },
                      );
                    },
                );
              }
            }
          ),
        ),
      );
  }
}

class DetailPage extends StatelessWidget{
  final User user;

  DetailPage(this.user);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullname),
      ),
      body: Container(

      ),
    );
  }
}

class User {
  final int authorId;
  final String fullname;
  final String nidn;
  final String afiliasi;

  User(this.authorId, this.fullname, this.nidn, this.afiliasi, );
}

idTap(user) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("nidn", user.nidn);
    String isi = pref.getString("nidn");
    print("NIDN = " +isi);
    await getAuthorOverview(isi);
    
}