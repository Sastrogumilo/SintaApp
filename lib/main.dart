import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sinta_app/Constant/constant.dart';
import 'package:sinta_app/Screen/Cari.dart';
import 'package:sinta_app/Screen/ImageSplashScreen.dart';
import 'package:sinta_app/Screen/HomePage.dart';
import 'package:sinta_app/Screen/Authors.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/Screen/TampilAuthor.dart';
import 'package:sinta_app/theme/app_theme.dart';
//import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp()));
}
/*
Future main() async {
  runApp(new MaterialApp(
    title: 'Kosong',
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      primarySwatch: Colors.purple,
    ),
    home: new ImageSplashScreen(),
    routes: <String, WidgetBuilder>{
      routerMap['_homescreen']: (BuildContext context) => new HomeScreen(),
      routerMap['_spalshscreen']: (BuildContext context) => new ImageSplashScreen(),
      routerMap['_authors']:  (BuildContext context) => new AuthorPage(),
      routerMap['_search']: (BuildContext context) => new CariPage(),
      routerMap['_listauthors']: (BuildContext context) => new ListAuthorPage(),
    },
  ));
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppThemes.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: new HomeScreen(),
      routes: <String, WidgetBuilder>{
        routerMap['_homescreen']: (BuildContext context) => new HomeScreen(),
        routerMap['_spalshscreen']: (BuildContext context) => new ImageSplashScreen(),
        routerMap['_authors']:  (BuildContext context) => new AuthorPage(),
        routerMap['_search']: (BuildContext context) => new CariPage(),
        routerMap['_listauthors']: (BuildContext context) => new ListAuthorPage(),
      },
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
