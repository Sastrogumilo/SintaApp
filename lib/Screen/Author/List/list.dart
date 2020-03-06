import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinta_app/design_course/design_course_app_theme.dart';
//import 'package:sinta_app/design_course/models/category.dart';
import 'package:sinta_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

enum LoadMoreStatus {LOADING, STABLE}

Client clientListView = Client();

class PopularAuthorListView extends StatefulWidget {
  const PopularAuthorListView({Key key, this.callBack}) : super(key: key);

  final Function callBack;
  @override
  _PopularAuthorListViewState createState() => _PopularAuthorListViewState();
}

class _PopularAuthorListViewState extends State<PopularAuthorListView>
    with TickerProviderStateMixin {

  ScrollController _scrollController;
  
  
  //int items = 1000;
  
  Future<List<Authors>> _getAuthors() async {

    var pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    //print("Items = "+items.toString());
    final String baseUrl = 'http://api.sinta.ristekdikti.go.id/authors?items=10000';

    Map<String, String> headers = {
    "Content-Type" : "application/json",
    "Authorization" : "Bearer "+"$token",
    };

    final response = await clientListView.get("$baseUrl", headers: headers);
    print(response.statusCode.toString());
    final dataJson = jsonDecode(response.body);
    Cari data = new Cari.fromJson(dataJson);
    //print(data.authors.toString());

    //Authors({this.nidn, this.name, this.googleHindex, this.scopusHindex, this.img = 'assets/design_course/interFace1.png', });
    
    List<Authors> authors = [];
    for(var u in data.authors){
      Authors author = Authors(u['nidn'].toString(), 
                                u['id'].toString(), u['fullname'].toString(), 
                                u['affiliation']['name'].toString(), 
                                "assets/design_course/interFace1.png");
      authors.add(author);
    }
    //print(authors.length.toString());
    return authors;
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
    return Padding(
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
    );
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
  final Authors category;
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
                callback();
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
                                                  category.googleHindex,
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
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignCourseAppTheme.grey
                                      .withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1.48,
                                child: Image.asset(category.img.toString())),
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

class Authors{
  final name;
  final authorId;
  final googleHindex;
  final img;
  final nidn;
  Authors(this.nidn, this.authorId, this.name, this.googleHindex, this.img);

}

class Cari{
  final authors;
  
  Cari({this.authors,});

  factory Cari.fromJson(Map<String, dynamic> parsedJson){
    return Cari(authors: parsedJson['authors']);
  }
}

getAuthorNIDN(category) async {
  var pref = await SharedPreferences.getInstance();
  print(category.authorId);
  pref.setString("nidn", category.authorId);
  String isi = pref.getString("nidn");
  print("NIDN = " +isi);
  //await getAuthorNIDN(isi);

}
