import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


//Client client = Client();

class GoogleSchoolarPage extends StatefulWidget {
  
  @override 
  _GoogleSchoolarPageState createState() => new _GoogleSchoolarPageState();

}
List<UserRiset> risets = [];

class _GoogleSchoolarPageState extends State<GoogleSchoolarPage>{

  Future<List<UserRiset>> _getUsers() async {
    //getToken();
    final String baseUrl = "http://api.sinta.ristekdikti.go.id/author/detail/google/";
    //final String jumlah = "?items=1000";
    
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
    var client = http.Client();
    final response = await client.get("$baseUrl"+"$input", headers: headers);

    final dataJson = jsonDecode(response.body);
    Riset hasil = new Riset.fromJson(dataJson);
    //var jsonData = hasil.result; //Data Hasil Olahan
    //print(hasil.result);
    print(response.body.toString());
    
    //List<UserBimbingan> bimbingan = [];

    for(var u in hasil.result){
      UserRiset riset = UserRiset(u['title'], 
                                  u['authors'], 
                                  u['jurnal_name'].toString(), 
                                  u['year'].toString(), 
                                  u['citation'].toString(), 
                                  u['akreditasi'].toString(),
                                );
      risets.add(riset);
    }
    //print(users);
    //print(users.length);
    return risets; 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Daftar Google Schoolar Author'),
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
                    child: Text("Tidak Ada Data", textAlign: TextAlign.center,)));
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
                       subtitle: Text(snapshot.data[index].coverDisplayDate),
                       isThreeLine: true,
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
  final UserRiset user;

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
        child: Column(
         //crossAxisAlignment: CrossAxisAlignment.baseline,
          children: <Widget>[
        Text("Judul = " + user.judul),
        Text("Quartile = "+user.authors),
        Text("Nama Publikator = "+user.jurnalName),
        Text("Pembuat = "+user.year),
        Text("ISSN = "+user.citation),
        Text("Tanggal Terbit = "+user.akreditasi),

        ],),
      ),
    );
  }

}

class UserRiset {
  final judul;
  final authors;
  final jurnalName;
  final year;
  final citation;
  final akreditasi;



  UserRiset(this.judul, 
            this.authors, 
            this.jurnalName, 
            this.year, 
            this.citation, 
            this.akreditasi, 
            //this.tanggalPublikasi,
            );
}


class Riset{
  final result;
  
  Riset({
    this.result, 

  });

  factory Riset.fromJson(Map<String, dynamic> parsedJson){
   return Riset(result: parsedJson['author']['g_scholar']['article'],
                      //author: listAuthor,
                  );
  }
}

