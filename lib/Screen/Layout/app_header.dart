import 'package:sinta_app/theme/design_theme.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/API/Author/endpoint_api.dart';

class AppHeader extends StatelessWidget {
  final String titleTxt;
  final String jumlahTxt;
  final AnimationController animationController;
  final Animation animation;

  const AppHeader(
      {Key key,
      this.titleTxt: "",
      this.jumlahTxt: "",
      this.animationController,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
              child: Row(
                children: <Widget>[
                  Expanded(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Authors',
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
            ),
          ),
        );
      },
    );
  }
}
