import 'dart:math';

/// Example of a stacked area chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:sinta_app/theme/design_theme.dart';

import '../../../../main.dart';

class StackedAreaLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final String title;

  StackedAreaLineChart(this.seriesList, this.title, {this.animate});

  @override
  Widget build(BuildContext context) {
                
    return Container(
      height: 600,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.LineChart(seriesList,
                  defaultRenderer: new charts.LineRendererConfig(includeArea: true, stacked: true),
                  animate: false
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}