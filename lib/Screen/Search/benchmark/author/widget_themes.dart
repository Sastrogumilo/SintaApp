// import 'package:sinta_app/Screen/Search/benchmark/asean/asean_chart.dart';
import 'package:sinta_app/theme/design_theme.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/Screen/Search/index.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'author_chart.dart' as Author;

class WidgetThemes extends StatefulWidget{
  const WidgetThemes({Key key, 
      this.titleTxt: "",
      this.subTxt: "",
      this.mainScreenAnimationController,
      this.mainScreenAnimation
  }) : super(key: key);
  
  final String titleTxt;
  final String subTxt;
  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;


  @override
  WidgetThemesState createState() => new WidgetThemesState();
}

class WidgetThemesState extends State<WidgetThemes> with TickerProviderStateMixin {
  CategoryType categoryType = CategoryType.ui;
  final List<charts.Series<Author.LinearSales, num>> dataPie = [
      new charts.Series<Author.LinearSales, int>(
        id: 'Sales',
        domainFn: (Author.LinearSales sales, _) => sales.year,
        measureFn: (Author.LinearSales sales, _) => sales.sales,
        data: [
          new Author.LinearSales(0, 100),
          new Author.LinearSales(1, 75),
          new Author.LinearSales(2, 25),
          new Author.LinearSales(3, 5),
        ],
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (Author.LinearSales row, _) => '${row.year}: ${row.sales}',
      ),
  ];  

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: DesignThemes.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: DesignThemes.grey.withOpacity(0.2), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                  child: Author.DonutAutoLabelChart(
                    dataPie,
                    widget.titleTxt,
                  ),
                ),
              ),
              
            ),
          ),
        );
      },
    );  
  }

}