import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:sinta_app/design_course/course_info_screen.dart';
import 'package:sinta_app/Screen/Affiliation/Detail/detail.dart';
//import 'package:sinta_app/design_course/popular_course_list_view.dart';
import 'package:sinta_app/Screen/Affiliation/List/list.dart';
import 'package:sinta_app/Screen/Affiliation/List/listHasil.dart';
import 'package:sinta_app/initialization.dart';
import 'package:sinta_app/main.dart';
import 'package:sinta_app/theme/design_theme.dart';
//import 'package:sinta_app/Screen/Author/List/widget_themes.dart' as ListAuthor;
import 'package:sinta_app/Screen/Layout/app_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLayoutAffiliation extends StatefulWidget {
  static String tag = 'author-page';
  const ScreenLayoutAffiliation({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  ScreenLayoutAffiliationState createState() => new ScreenLayoutAffiliationState();
}

class ScreenLayoutAffiliationState extends State<ScreenLayoutAffiliation> with TickerProviderStateMixin{
  Animation<double> topBarAnimation;
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  var _formKey = GlobalKey<FormState>();
  
  @override
  void initState(){
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    getToken();
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      AppHeader(
        titleTxt: 'Authors',
        jumlahTxt: '1000',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {

    /*return Container(
      color: DesignThemes.chipBackground,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );*/

    return Container(
      color: DesignThemes.chipBackground,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            
            getAppBarUI(),

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      getSearchBarUI(),
                      Flexible(
                        child: getPopularCourseUI(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Form(
        key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Form(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#F8FAFB'),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(13.0),
                      bottomLeft: Radius.circular(13.0),
                      topLeft: Radius.circular(13.0),
                      topRight: Radius.circular(13.0),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: TextFormField(
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: DesignThemes.nearlyBlue,
                            ),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Cari Afiliasi',
                              border: InputBorder.none,
                              helperStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: HexColor('#B9BABC'),
                              ),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                letterSpacing: 0.2,
                                color: HexColor('#B9BABC'),
                              ),
                            ),
                            onFieldSubmitted: (value){
                              getIsi(value);
                              //getHasilCariAuthor(value);
                              moveToHasil();
                              //tampilHasil(value);
                            },
                            validator: (value){
                              if(value == null){
                               Text('Tolong Diisikan ...');
                              } return ;
                            },
                            //onSaved: (value){
                             // String _isi = value;
                            //},
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Icon(Icons.search, color: HexColor('#B9BABC')),
                      )
                    ],
                  ),
                ),
              ),
            )
            
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    ));
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Afiliasi',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignThemes.grey,
                  ),
                ),
                Text(
                  'Registered',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignThemes.darkerText,
                  ),
                ),
                Text(
                  '1000',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignThemes.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            child: Image.asset('assets/image/sinta_logo2.png'),
          )
        ],
      ),
    );
  }
  
  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Flexible(
            child: UnivListView(
              callBack: () {
                moveToK();
              },
            ),
          ),

        ],
      ),
    );
  }
  void moveToHasil() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => HasilSearchUniv(),
      ),
    );
  }

  void moveToK() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => UnivInfoScreen(),
      ),
    );
  }

}
getIsi(isi) async {

  print(isi.toString());
  var pref = await SharedPreferences.getInstance();

  pref.setString('nama', isi);
  //String test = pref.getString('nama');
  //print("TEST = $test");

  }