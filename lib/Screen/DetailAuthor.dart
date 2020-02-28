import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinta_app/API/Author/author_api.dart';
//import 'package:sinta_app/API/Author/Overview/overview.dart';

class DetailAuthorPage extends StatefulWidget{
  @override
  _DetailAuthorPageState createState() => _DetailAuthorPageState();
}

class _DetailAuthorPageState extends State<DetailAuthorPage>{

  Future _getDetailAuthor() async {
    final pref = await SharedPreferences.getInstance();
    String nidn = pref.getString('nidn');

    var data = await getAuthorOverview(nidn);
    print(data);

  }

  @override
  void initState() {
    _getDetailAuthor();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),

    );
  }

}

class Overview{

  Overview();
}