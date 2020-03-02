import 'package:sinta_app/Constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/Models/tabicon_data.dart';
import 'package:sinta_app/Screen/Search/index.dart' as SearchScreen;
import 'package:sinta_app/Screen/Author/index.dart' as AuthorScreen;
import 'package:sinta_app/design_course/category_list_view.dart';
import 'package:sinta_app/design_course/course_info_screen.dart';
import 'package:sinta_app/design_course/popular_course_list_view.dart';
import 'package:sinta_app/initialization.dart';
import 'package:sinta_app/main.dart';
import 'package:sinta_app/theme/design_theme.dart';
import 'package:sinta_app/Screen/Layout/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static String tag = 'author-page';

  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: DesignThemes.chipBackground,
  );
  
  @override
  void initState(){
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), 
        vsync: this
    );
    tabBody = SearchScreen.ScreenLayout(animationController: animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignThemes.chipBackground,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      SearchScreen.ScreenLayout(animationController: animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      AuthorScreen.ScreenLayout(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
  
}
