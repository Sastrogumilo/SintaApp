import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/API/Search/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class ServicePage extends StatefulWidget {
  
  @override 
  _ServicePageState createState() => new _ServicePageState();

}
List<UserRiset> risets = [];

class _ServicePageState extends State<ServicePage>{

  Future<List<UserRiset>> _getUsers() async {
    
    final String baseUrl = "http://api.sinta.ristekdikti.go.id/author/detail/service/";
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
    //print(hasil.result);
    //print(hasil.author);
    
    //List<UserBimbingan> bimbingan = [];

    for(var u in hasil.result){
      UserRiset riset = UserRiset(u['judul'], 
                                  u['nama_ketua'], 
                                  u['thn_usulan_kegiatan'].toString(), 
                                  u['thn_pelaksanaan_kegiatan'].toString(), 
                                  u['dana_disetujui'].toString(), 
                                  u['bidang_fokus'],
                                  u['program_hibah'],
                                  u['nama_singkat_skema'],
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
        title: new Text('Daftar Artikel Pengabidan Masyarakat'),
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
                    child: Text("Author Belum Pernah Melakukan Pengabdian Masyarakat", textAlign: TextAlign.center,)));
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
        Text("Nama Ketua = "+user.namaKetua),
        Text("Tahun Pelaksanaa = "+user.tahunPelaksanaan),
        Text("Dana Disetujui = "+user.dana),
        Text("Bidang = "+user.bidang),
        Text("Program Hibah = "+user.programHibah),
        Text("Skema = "+user.skema),

        ],),
      ),
    );
  }

}

class UserRiset {
  final judul;
  final namaKetua;
  final tahun;
  final tahunPelaksanaan;
  final dana;
  final bidang;
  final programHibah;
  final skema;

  UserRiset(this.judul, this.namaKetua, this.tahun, this.tahunPelaksanaan, this.dana, this.bidang, this.programHibah, this.skema);
}


class Riset{
  final result;
  
  Riset({
    this.result, 

  });

  factory Riset.fromJson(Map<String, dynamic> parsedJson){
   return Riset(result: parsedJson['author']['services']['article'],
                      //author: listAuthor,
                  );
  }
}
