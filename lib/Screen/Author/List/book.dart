import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/API/Author/endpoint_api.dart';
import 'package:sinta_app/API/Search/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class BookPage extends StatefulWidget {
  
  @override 
  _BookPageState createState() => new _BookPageState();

}
List<UserBook> books = [];

class _BookPageState extends State<BookPage>{

  Future<List<UserBook>> _getBook() async {
    
    final String baseUrl = "http://api.sinta.ristekdikti.go.id/author/detail/book/";
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
    Book hasil = new Book.fromJson(dataJson);
    //var jsonData = hasil.result; //Data Hasil Olahan
    //print(hasil.result);
    print(response.body.toString());
    
    //List<UserBimbingan> bimbingan = [];

    for(var u in hasil.result){
      UserBook book = UserBook(u['title'], 
                                  u['ISBN'], 
                                  u['author_name'].toString(), 
                                  u['tempat'].toString(), 
                                  u['penerbit'].toString(), 
                                  u['year'].toString(),
                                );
      books.add(book);
    }
    //print(users);
    //print(users.length);
    return books; 
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Daftar Terbitan Buku'),
        leading: new IconButton(icon: new Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))),
        body: Container(
          child: FutureBuilder(
            future: _getBook(),
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
                    child: Text("Author Belum Pernah Menerbitkan Buku", textAlign: TextAlign.center,)));
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
  final UserBook user;

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
        Text("No ISBN = "+user.isbn),
        Text("Nama Pengaran = "+user.author),
        Text("Tempat = "+user.tempat),
        Text("Penerbit = "+user.penerbit),
        Text("Tahun = "+user.tahun),
        

        ],),
      ),
    );
  }

}

class UserBook {
  final judul;
  final isbn;
  final author;
  final tempat;
  final penerbit;
  final tahun;

  UserBook(this.judul, 
            this.isbn, 
            this.author, 
            this.tempat, 
            this.penerbit, 
            this.tahun, 
            //this.tanggalPublikasi,
            );
}


class Book{
  final result;
  
  Book({
    this.result, 

  });

  factory Book.fromJson(Map<String, dynamic> parsedJson){
   return Book(result: parsedJson['author']['books']['book'],
                      //author: listAuthor,
                  );
  }
}

