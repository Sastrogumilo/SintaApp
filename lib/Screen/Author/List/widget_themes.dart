import 'package:sinta_app/design_course/course_info_screen.dart';
import 'package:sinta_app/design_course/popular_course_list_view.dart';
import 'package:sinta_app/theme/design_theme.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/API/Author/endpoint_api.dart';

class WidgetThemes extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController animationController;
  final Animation animation;

  const WidgetThemes(
      {Key key,
      this.titleTxt: "",
      this.subTxt: "",
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget listUI() {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Popular Course',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                letterSpacing: 0.27,
                color: DesignThemes.darkerText,
              ),
            ),
            Flexible(
              child: PopularCourseListView(
                callBack: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => CourseInfoScreen(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    }

    void moveTo() {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CourseInfoScreen(),
        ),
      );
    }
    
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 30 * (1.0 - animation.value), 0.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: <Widget>[
                    listUI(),
                    
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
