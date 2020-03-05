import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinta_app/Screen/Journal/Detail/detail.dart';
import 'package:sinta_app/design_course/design_course_app_theme.dart';
//import 'package:sinta_app/design_course/models/category.dart';
import 'package:sinta_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

enum LoadMoreStatus {LOADING, STABLE}

Client clientListView = Client();

class HasilSearchJournal extends StatefulWidget {
  const HasilSearchJournal({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _HasilSearchJournalState createState() => _HasilSearchJournalState();
}

class _HasilSearchJournalState extends State<HasilSearchJournal>
    with TickerProviderStateMixin {

  ScrollController _scrollController;
  
  
  
  List<Journals> jurnals = [];

  Future<List<Journals>> _getAuthors() async {

    var pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    String nama = pref.getString('nama');
    print(nama.toString());
    //print("Items = "+items.toString());
    final String baseUrl = 'http://api.sinta.ristekdikti.go.id/journals?q=';
    final String jumlah = "&items=1000";

    Map<String, String> headers = {
    "Content-Type" : "application/json",
    "Authorization" : "Bearer "+"$token",
    };

    final response = await clientListView.get("$baseUrl"+'$nama'+'$jumlah', headers: headers);
    print(response.statusCode.toString());
    final dataJson = jsonDecode(response.body);
    Cari data = new Cari.fromJson(dataJson);
    //print(data.authors.toString());

    //Authors({this.nidn, this.name, this.googleHindex, this.scopusHindex, this.img = 'assets/design_course/interFace1.png', });
    
    
    for(var u in data.authors){
      Journals jurnal = Journals(u['id'].toString(), 
                                  u['name'], 
                                  u['institusi'], 
                                  u['sinta_score'].toString(), 
                                  u['impact_3'].toString());
      jurnals.add(jurnal);
    }
      
    print(jurnals.length.toString());
    return jurnals;
  }

  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      //_getAuthors(items = items + 10);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder(
        future: this._getAuthors(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //print(snapshot.data.length.toString());
          if (snapshot.data == null) {
            return Align(alignment: Alignment.center,
            child: CircularProgressIndicator(),);
          } else {
            var list = snapshot.data;

            return GridView(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                //Category.popularCourseList.length,
                list.length,
                (int index) {
                  final int count = list.length; //Category.popularCourseList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    
                    callback: () {
                      //getAuthorNIDN(snapshot.data[index]);
                      widget.callBack();
                    },
                    category: list[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.8,
              ),
            );
          }
        },
      ),
    ));
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
      this.category,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Journals category;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                getAuthorNIDN(category);
                //callback();
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JournalInfoScreen()));
              },
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                // border: new Border.all(
                                //     color: DesignCourseAppTheme.notWhite),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: Text(
                                              category.name,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 16,
                                                right: 16,
                                                bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Flexible(child:
                                                Text(
                                                  category.institusi,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 14,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .grey,
                                                  ),
                                                ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                          ),
                          
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Journals{
  final name;
  final id;
  final institusi;
  final sintaScore;
  final impact;
  Journals(this.id, this.name, this.institusi, this.sintaScore, this.impact);

}

class Cari{
  final authors;
  
  Cari({this.authors,});

  factory Cari.fromJson(Map<String, dynamic> parsedJson){
    return Cari(authors: parsedJson['journals']);
  }
}

getAuthorNIDN(category) async {
  var pref = await SharedPreferences.getInstance();
  //print(category.nidn);
  pref.setString("jurnalID", category.id);
  String isi = pref.getString("jurnalID");
  print("Jurnal ID = " +isi);
  //await getAuthorNIDN(isi);

}



