// import 'package:sinta_app/Screen/Search/benchmark/asean/asean_chart.dart';
import 'package:sinta_app/theme/design_theme.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/Screen/Search/index.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'asean_chart.dart' as Asean;

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
  
  List<charts.Series<Asean.LinearSales, num>> dataLinear = [
    new charts.Series<Asean.LinearSales, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Asean.LinearSales sales, _) => sales.year,
        measureFn: (Asean.LinearSales sales, _) => sales.sales,
        data: [
          new Asean.LinearSales(0, 200),
          new Asean.LinearSales(1, 300),
          new Asean.LinearSales(2, 350),
          new Asean.LinearSales(3, 400),
        ],
      ),
    new charts.Series<Asean.LinearSales, int>(
      id: 'Tablet',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (Asean.LinearSales sales, _) => sales.year,
      measureFn: (Asean.LinearSales sales, _) => sales.sales,
      data: [
        new Asean.LinearSales(0, 200),
        new Asean.LinearSales(1, 30),
        new Asean.LinearSales(2, 80),
        new Asean.LinearSales(3, 90),
      ],
    ),
    new charts.Series<Asean.LinearSales, int>(
      id: 'Mobile',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (Asean.LinearSales sales, _) => sales.year,
      measureFn: (Asean.LinearSales sales, _) => sales.sales,
      data: [
        new Asean.LinearSales(0, 100),
        new Asean.LinearSales(1, 202),
        new Asean.LinearSales(2, 90),
        new Asean.LinearSales(3, 14),
      ],
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
                  child: Asean.StackedAreaLineChart(
                    dataLinear,
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