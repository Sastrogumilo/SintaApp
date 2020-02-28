import 'dart:async';

import 'package:sinta_app/Constant/constant.dart';
import 'package:sinta_app/Screen/Cari.dart';
import 'package:sinta_app/Screen/ImageSplashScreen.dart';
import 'package:sinta_app/Screen/HomePage.dart';
import 'package:sinta_app/Screen/Authors.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/Screen/TampilAuthor.dart';
//import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  runApp(new MaterialApp(
    title: 'Kosong',
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      primarySwatch: Colors.purple,
    ),
    home: new ImageSplashScreen(),
    routes: <String, WidgetBuilder>{
      homeScreen: (BuildContext context) => new HomeScreen(),
      imageSplash: (BuildContext context) => new ImageSplashScreen(),
      authors:  (BuildContext context) => new AuthorPage(),
      cari: (BuildContext context) => new CariPage(),
      listAuthor: (BuildContext context) => new ListAuthorPage(),
    },
  ));
}
