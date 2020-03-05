import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/API/Search/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' show Client;

Client client = Client();

class IprPage extends StatefulWidget {
  
  @override 
  _IprPageState createState() => new _IprPageState();

}
List<UserRiset> risets = [];

class _IprPageState extends State<IprPage>{

  Future<List<UserRiset>> _getUsers() async {
    
    final String baseUrl = "http://api.sinta.ristekdikti.go.id/author/detail/ipr/";
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
    Riset hasil = new Riset.fromJson(dataJson);
    //var jsonData = hasil.result; //Data Hasil Olahan
    print(response.body.toString());
    //print(hasil.author);
    
    //List<UserBimbingan> bimbingan = [];

    for(var u in hasil.result){
      UserRiset riset = UserRiset(u['title'], 
                                  u['kategori'], 
                                  u['tahun_permohonan'].toString(), 
                                  u['pemegang_paten'].toString(), 
                                  u['inventor'].toString(), 
                                  u['status'].toString(),
                                  u['tgl_publikasi'].toString(),
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
        title: new Text('Daftar Artikel IPR'),
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
                    child: Text("Author Belum Pernah Mengajukan IPR", textAlign: TextAlign.center,)));
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
                       subtitle: Text(snapshot.data[index].tahun),
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
        Text("Kategori = "+user.kategori),
        Text("Tahun = "+user.tahun),
        Text("Pemegang Paten = "+user.pemegangPaten),
        Text("Nama Inventor = "+user.inventor),
        Text("Status = "+user.status),
        Text("Tanggal Publikasi = "+user.tanggalPublikasi,

        )],),
      ),
    );
  }

}

class UserRiset {
  final judul;
  final kategori;
  final tahun;
  final pemegangPaten;
  final inventor;
  final status;
  final tanggalPublikasi;

  UserRiset(this.judul, 
            this.kategori, 
            this.tahun, 
            this.pemegangPaten, 
            this.inventor, 
            this.status, 
            this.tanggalPublikasi,);
}


class Riset{
  final result;
  
  Riset({
    this.result, 

  });

  factory Riset.fromJson(Map<String, dynamic> parsedJson){
   return Riset(result: parsedJson['author']['hki']['hki'],
                      //author: listAuthor,
                  );  
  }
}

