import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinta_app/design_course/design_course_app_theme.dart';
//import 'package:sinta_app/design_course/models/category.dart';
import 'package:sinta_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:sinta_app/Screen/Affiliation/Detail/detail.dart';

Client clientListView = Client();

class HasilSearchUniv extends StatefulWidget {
  const HasilSearchUniv({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _HasilSearchUnivState createState() => _HasilSearchUnivState();
}

class _HasilSearchUnivState extends State<HasilSearchUniv>
    with TickerProviderStateMixin {

  Future<List<Univ>> _getUniv() async {

    var pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    String nama = pref.getString('nama');
    
    final String items = '&items=1000';

    final String baseUrl = 'http://api.sinta.ristekdikti.go.id/affiliations?q=';


    Map<String, String> headers = {
    "Content-Type" : "application/json",
    "Authorization" : "Bearer "+"$token",
    };

    final response = await clientListView.get("$baseUrl"+'$nama'+'$items', headers: headers);
    print(response.statusCode.toString());
    final dataJson = jsonDecode(response.body);
    Cari data = new Cari.fromJson(dataJson);
    //print(data.affiliations.toString());

    //Authors({this.nidn, this.name, this.googleHindex, this.scopusHindex, this.img = 'assets/design_course/interFace1.png', });

    List<Univ> univs = [];
    for(var u in data.affiliations){
      Univ univ = Univ(u["kode_pt"].toString(), u["afiliasi_abbrev"].toString(), u["city"]["name"].toString(), u["afiliasi_abbrev"].toString(), u["rank"].toString(), u["img"].toString());
      univs.add(univ);
    }
    print(univs.length.toString());
    return univs;
  }
  

  AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
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
        future: _getUniv(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //print(snapshot.data.length.toString());
          if (snapshot.data == null) {
            return Align(alignment: Alignment.center,
            child: CircularProgressIndicator(),);
          } else {
            print(snapshot.data.length.toString());
            return GridView(
              padding: const EdgeInsets.all(0.25),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                //Category.popularCourseList.length,
                snapshot.data.length,
                (int index) {
                  final int count = snapshot.data.length; //Category.popularCourseList.length;
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
                      //getUnivNIDN(snapshot.data[index]);
                      widget.callBack();
                    },
                    category: snapshot.data[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
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
  final Univ category;
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
                getUnivNIDN(category);
                //callback();
                Navigator.push(context, MaterialPageRoute(builder: (context) => UnivInfoScreen()));
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
                                                fontSize: 14,
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
                                                  category.kota,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    letterSpacing: 0.1,
                                                    color: DesignCourseAppTheme
                                                        .grey,
                                                  ),
                                                )
                                                )],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 60,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
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
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignCourseAppTheme.grey
                                      .withOpacity(0.1),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 
                                  10.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            child: AspectRatio(
                                aspectRatio: 0.4,
                                child: Image.network(category.img)),
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

class Univ{
  final name;
  final sintaScore;
  final kota;
  final website;
  final img;
  final kodePT;
  Univ(this.kodePT, this.name, this.kota, this.website, this.sintaScore, this.img);

}

class Cari{
  final affiliations;
  
  Cari({this.affiliations,});

  factory Cari.fromJson(Map<String, dynamic> parsedJson){
    return Cari(affiliations: parsedJson['affiliations']);
  }
}

getUnivNIDN(category) async {
  var pref = await SharedPreferences.getInstance();
  //print(category.nidn);
  pref.setString("kodePT", category.kodePT);
  String isi = pref.getString("kodePT");
  print("Kode PT = " +isi);
  //await getAuthorNIDN(isi);

}
