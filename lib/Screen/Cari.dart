
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinta_app/Constant/constant.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:sinta_app/API/Search/search.dart';

class CariPage extends StatefulWidget 
{
  static String tag = 'author-page';
  @override
  _CariState createState() =>_CariState();
}

class _CariState extends State<CariPage>
{
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();
  String _authorId;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: new AppBar(title: const Text("Cari Author"),
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back), 
        onPressed: () => Navigator.of(context).pushReplacementNamed(homeScreen))),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: new Column(
              children: <Widget>[
                SizedBox(
                  height: 12,),
                  TextFormField(
                    decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white30,
                          icon:Icon(Icons.credit_card),
                          hintText: "ID/NIDN",
                          labelText: "Masukan Nama Author"
                        ),
                        onSaved: (value) => _authorId = value,
                        keyboardType: TextInputType.text,
                        //onFieldSubmitted: _handleSubmit(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: RaisedButton(
                      onPressed:  _handleSubmit,
                      child: Text("Kirim"),
                    ),
                  )
              ],
            ), 
          ) 
        ),
      ),
    );
  }

  bool _validateDanSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      //_scaffoldstate.currentState.showSnackBar(SnackBar(content: Text("Memproses Data")));
      return true;
    }
    return false;
  }
  _handleSubmit() async {
    String query;
    _validateDanSave();
    query = _authorId;
    final pref = await SharedPreferences.getInstance();
    pref.setString("query", query);
    Navigator.of(context).pushReplacementNamed(listAuthor);
  }

}