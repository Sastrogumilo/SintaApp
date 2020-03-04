import 'package:sinta_app/Constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/initialization.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}



class HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    getToken();
    super.initState();
  }
  
  Widget build(BuildContext context) {
    //bottom_navigation bottom = new bottom_navigation();
    return new Scaffold(
        appBar: AppBar(
          title: new Text("Home Page"),
        ),
        backgroundColor: Colors.white,
        body: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            
            // Foreground Background
            new Column(
              children: <Widget>[
                SizedBox(height: 70.0),
                SizedBox(
                  height: 0.0,
                  child: new Text(
                    "In Build",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            
            // Menu
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  elevation: 0.0,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
                  padding: EdgeInsets.only(
                  top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(authors);
                  },
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Image.asset( 
                        'assets/image/person.png',
                        height: 40.0,
                        width: 40.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: new Text(
                            "Author",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                  textColor: Color(0xFF292929),
                  color: Color(0xFFDADADA)
                ),
                Padding(
                  padding: const EdgeInsets.only(
                  left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                  child: new RaisedButton(
                      elevation: 0.0,
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                      padding: EdgeInsets.only(
                      top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(cari);
                      },
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Image.asset(
                            'assets/image/school.png',
                            height: 40.0, width: 40.0),
                          Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: new Text(
                                "Affiliation",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0
                                ),
                          ))
                        ],
                      ),
                      textColor: Color(0xFF292929),
                      color: Color(0xFFDADADA)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 30.0, bottom: 0.0),
                  child: new RaisedButton(
                      elevation: 0.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      padding: EdgeInsets.only(
                          top: 7.0, bottom: 7.0, right: 25.0, left: 7.0),
                      onPressed: () async {
                        //Navigator.of(context).pushReplacementNamed(journal);
                      },
                      child: new Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Image.asset(
                            'assets/image/book.png',
                            height: 40.0,
                            width: 40.0,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: new Text(
                                "Journal",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ))
                        ],
                      ),
                      textColor: Color(0xFF292929),
                      color: Color(0xFFDADADA)),
                )
              ],
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          //shape: const CircularNotchedRectangle(),
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.navigation),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: new Text('Author'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: new Text('Affiliation'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              title: new Text('Source'),
            ),
          ],
        ),
        /*floatingActionButton: bottom.floating_btn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
    
    );
  }

}