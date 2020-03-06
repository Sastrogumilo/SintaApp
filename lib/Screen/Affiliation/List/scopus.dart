import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' show Client;

Client clientScopusUniv = Client();


class UnivScopusPage extends StatefulWidget {
  
  @override 
  _UnivScopusPageState createState() => new _UnivScopusPageState();

}


class _UnivScopusPageState extends State<UnivScopusPage>{

  Future<List<UserRiset>> _getUsers() async {
    
    final String baseUrl = "http://api.sinta.ristekdikti.go.id/affiliation/detail/scopus/";
    final String jumlah = "?items=1000";
    
    final pref = await SharedPreferences.getInstance();
    String input = pref.getString('kodePT');
    //String input = "54481";
    //print(input);
    String token = pref.getString("token");
    //print("Token saat INI "+"$token");

    Map<String, String> headers = {
    "Content-Type" : "application/json",
    "Authorization" : "Bearer "+"$token",
    };

    print("$baseUrl"+"$input"+"$jumlah");
    final response = await clientScopusUniv.get("$baseUrl"+"$input"+"$jumlah", headers: headers);
    print(response.body.toString());
    final dataJson = jsonDecode(response.body);
    Riset hasil = new Riset.fromJson(dataJson);
    //var jsonData = hasil.result; //Data Hasil Olahan
    //print(hasil.result);
    //print(hasil.author);
    
    //List<UserBimbingan> bimbingan = [];
    List<UserRiset> risets = [];
    for(var u in hasil.result){
      UserRiset riset = UserRiset(u['title'].toString(), 
                                  u['quartile'].toString(), 
                                  u['publicationName'].toString(), 
                                  u['creator'].toString(), 
                                  u['issn'].toString(), 
                                  u['coverDisplayDate'].toString(),
                                  u['doi'].toString(),
                                  u['citedby_count'].toString(),
                                  u['aggregationType'].toString(),

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
        title: new Text('Daftar Scopus Author'),
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
              if(snapshot.data.length == 0 || snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Tidak Ada Data", textAlign: TextAlign.center,)));
              } else if (snapshot.hasError){
                  return Container(
                  child: Center(
                    child: Text('Error: ${snapshot.error}')));}
              } return ListView.builder(
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
        Text("Quartile = "+user.quartile),
        Text("Nama Publikator = "+user.publicationName),
        Text("Pembuat = "+user.creator),
        Text("ISSN = "+user.issn),
        Text("Tanggal Terbit = "+user.coverDisplayDate),
        Text("DOI = "+user.doi),
        Text("Total Sitasi = "+user.totalCitasi),
        Text("Aggregasi = "+user.aggregationType),
        

        ],),
      ),
    );
  }

}

class UserRiset {
  final judul;
  final quartile;
  final publicationName;
  final creator;
  final issn;
  final coverDisplayDate;
  final doi;
  final totalCitasi;
  final aggregationType;



  UserRiset(this.judul, 
            this.quartile, 
            this.publicationName, 
            this.creator, 
            this.issn, 
            this.coverDisplayDate, 
            this.doi,
            this.totalCitasi,
            this.aggregationType,
            //this.tanggalPublikasi,
            );
}


class Riset{
  final result;
  
  Riset({
    this.result, 

  });

  factory Riset.fromJson(Map<String, dynamic> parsedJson){
   return Riset(result: parsedJson['afiliasi']['scopus']['article'],
                      //author: listAuthor,
                  );
  }
}

