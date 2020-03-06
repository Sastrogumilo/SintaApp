// import 'package:sinta_app/Screen/Search/benchmark/asean/asean_chart.dart';
import 'package:sinta_app/theme/design_theme.dart';
import 'package:flutter/material.dart';
import 'package:sinta_app/Screen/Search/index.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'asean_chart.dart' as Asean;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
  
  AseanMap aseanMap;
  
  static Tahun indo, myanmar, pinoy, singapura, thailand, vietman;
  List<charts.Series<Asean.LinearSales, num>> dataLinear = [
    new charts.Series<Asean.LinearSales, int>(
        id: 'INDONESIA',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Asean.LinearSales sales, _) => sales.year,
        measureFn: (Asean.LinearSales sales, _) => sales.sales,
        data: [
          new Asean.LinearSales(0, 722),
          new Asean.LinearSales(1, 641),
          new Asean.LinearSales(2, 690),
          new Asean.LinearSales(3, 801),
          new Asean.LinearSales(4, 968),
          new Asean.LinearSales(5, 1163),
          new Asean.LinearSales(6, 1326),
          new Asean.LinearSales(7, 1374),
          new Asean.LinearSales(8, 1517),
          new Asean.LinearSales(9, 2093),
          new Asean.LinearSales(10, 2771),
          new Asean.LinearSales(11, 3376),
          new Asean.LinearSales(12, 4004),
          new Asean.LinearSales(13, 5401),
          new Asean.LinearSales(14, 6866),
          new Asean.LinearSales(15, 8460),
          new Asean.LinearSales(16, 12594),
          new Asean.LinearSales(17, 21283),
          new Asean.LinearSales(18, 34125),
          new Asean.LinearSales(19, 43208),
        ],
      ),
    new charts.Series<Asean.LinearSales, int>(
      id: 'MYANMAR',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (Asean.LinearSales sales, _) => sales.year,
      measureFn: (Asean.LinearSales sales, _) => sales.sales,
      data: [
          new Asean.LinearSales(2000, 1739),
          new Asean.LinearSales(2001, 1522),
          new Asean.LinearSales(2002, 1875),
          new Asean.LinearSales(2003, 2433),
          new Asean.LinearSales(2004, 2844),
          new Asean.LinearSales(2005, 3451),
          new Asean.LinearSales(2006, 4522),
          new Asean.LinearSales(2007, 5514),
          new Asean.LinearSales(2008, 8206),
          new Asean.LinearSales(2009, 11442),
          new Asean.LinearSales(2010, 15690),
          new Asean.LinearSales(2011, 20699),
          new Asean.LinearSales(2012, 20699),
          new Asean.LinearSales(2013, 25620),
          new Asean.LinearSales(2014, 29095),
          new Asean.LinearSales(2015, 27950),
          new Asean.LinearSales(2016, 30573),
          new Asean.LinearSales(2017, 33178),
          new Asean.LinearSales(2018, 33481),
          new Asean.LinearSales(2019, 35697),
      ],
    ),
    new charts.Series<Asean.LinearSales, int>(
      id: 'FILIPINA',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (Asean.LinearSales sales, _) => sales.year,
      measureFn: (Asean.LinearSales sales, _) => sales.sales,
      data: [
          new Asean.LinearSales(2000, 579),
          new Asean.LinearSales(2001, 467),
          new Asean.LinearSales(2002, 617),
          new Asean.LinearSales(2003, 722),
          new Asean.LinearSales(2004, 674),
          new Asean.LinearSales(2005, 889),
          new Asean.LinearSales(2006, 902),
          new Asean.LinearSales(2007, 1002),
          new Asean.LinearSales(2008, 1098),
          new Asean.LinearSales(2009, 1223),
          new Asean.LinearSales(2010, 1337),
          new Asean.LinearSales(2011, 1593),
          new Asean.LinearSales(2012, 1752),
          new Asean.LinearSales(2013, 1973),
          new Asean.LinearSales(2014, 2269),
          new Asean.LinearSales(2015, 2769),
          new Asean.LinearSales(2016, 3136),
          new Asean.LinearSales(2017, 3590),
          new Asean.LinearSales(2018, 3851),
          new Asean.LinearSales(2019, 5065),
      ],
    ),
    new charts.Series<Asean.LinearSales, int>(
      id: 'SINGAPURA',
      colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
      domainFn: (Asean.LinearSales sales, _) => sales.year,
      measureFn: (Asean.LinearSales sales, _) => sales.sales,
      data: [
          new Asean.LinearSales(2000, 5964),
          new Asean.LinearSales(2001, 6146),
          new Asean.LinearSales(2002, 6928),
          new Asean.LinearSales(2003, 8229),
          new Asean.LinearSales(2004, 9911),
          new Asean.LinearSales(2005, 10957),
          new Asean.LinearSales(2006, 11783),
          new Asean.LinearSales(2007, 12223),
          new Asean.LinearSales(2008, 13300),
          new Asean.LinearSales(2009, 14031),
          new Asean.LinearSales(2010, 15715),
          new Asean.LinearSales(2011, 16702),
          new Asean.LinearSales(2012, 18359),
          new Asean.LinearSales(2013, 19436),
          new Asean.LinearSales(2014, 20118),
          new Asean.LinearSales(2015, 20733),
          new Asean.LinearSales(2016, 21908),
          new Asean.LinearSales(2017, 22782),
          new Asean.LinearSales(2018, 22694),
          new Asean.LinearSales(2019, 22969),
      ],
    ),
    new charts.Series<Asean.LinearSales, int>(
      id: 'THAILAND',
      colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
      domainFn: (Asean.LinearSales sales, _) => sales.year,
      measureFn: (Asean.LinearSales sales, _) => sales.sales,
      data: [
          new Asean.LinearSales(2000, 2252),
          new Asean.LinearSales(2001, 2336),
          new Asean.LinearSales(2002, 2912),
          new Asean.LinearSales(2003, 3368),
          new Asean.LinearSales(2004, 3991),
          new Asean.LinearSales(2005, 5066),
          new Asean.LinearSales(2006, 6107),
          new Asean.LinearSales(2007, 6862),
          new Asean.LinearSales(2008, 8055),
          new Asean.LinearSales(2009, 8648),
          new Asean.LinearSales(2010, 10095),
          new Asean.LinearSales(2011, 10877),
          new Asean.LinearSales(2012, 12277),
          new Asean.LinearSales(2013, 12532),
          new Asean.LinearSales(2014, 13752),
          new Asean.LinearSales(2015, 13152),
          new Asean.LinearSales(2016, 14927),
          new Asean.LinearSales(2017, 16760),
          new Asean.LinearSales(2018, 18769),
          new Asean.LinearSales(2019, 19431),
      ],
    ),
    new charts.Series<Asean.LinearSales, int>(
      id: 'VIETNAM',
      colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
      domainFn: (Asean.LinearSales sales, _) => sales.year,
      measureFn: (Asean.LinearSales sales, _) => sales.sales,
      data: [
          new Asean.LinearSales(2000, 398),
          new Asean.LinearSales(2001, 435),
          new Asean.LinearSales(2002, 440),
          new Asean.LinearSales(2003, 661),
          new Asean.LinearSales(2004, 704),
          new Asean.LinearSales(2005, 849),
          new Asean.LinearSales(2006, 986),
          new Asean.LinearSales(2007, 1149),
          new Asean.LinearSales(2008, 1540),
          new Asean.LinearSales(2009, 1747),
          new Asean.LinearSales(2010, 2162),
          new Asean.LinearSales(2011, 2380),
          new Asean.LinearSales(2012, 3134),
          new Asean.LinearSales(2013, 3743),
          new Asean.LinearSales(2014, 4033),
          new Asean.LinearSales(2015, 4483),
          new Asean.LinearSales(2016, 5818),
          new Asean.LinearSales(2017, 6646),
          new Asean.LinearSales(2018, 8765),
          new Asean.LinearSales(2019, 12446),
      ],
    ),
  ];  

  Map<String, dynamic> listDataAseanMap;
  List<charts.Series<Asean.LinearSales, num>> dataLinearAsean = [];

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  fetchAsean()async{
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');

    Map<String, String> headers = {
      "Content-Type" : "application/json",
      "Authorization" : "Bearer "+"$token",
    };
    //print(token);
    
  final String baseUrl = "http://api.sinta.ristekdikti.go.id/asean_benchmark";

  final response = await get("$baseUrl", headers: headers);
  //print(response.body.toString());
  print("========================================//////////////////////////////");
  var jsonData = jsonDecode(response.body);
  Mapping map = new Mapping.fromJson(jsonData);
  print(map.data['ID']['2000']);
  
  /*AseanMap aseanMap = AseanMap(map.data['ID'], 
                                map.data['MY'], 
                                map.data['PH'], 
                                map.data['SG'], 
                                map.data['TH'], 
                                map.data['VN'],
                                );
    
    indo = Tahun(aseanMap.indo['2000'], aseanMap.indo['2001'], aseanMap.indo['2002'], aseanMap.indo['2003'], aseanMap.indo['2004'], aseanMap.indo['2005'], aseanMap.indo['2006'], aseanMap.indo['2007'], aseanMap.indo['2008'], aseanMap.indo['2009'], aseanMap.indo['2010'], aseanMap.indo['2011'], aseanMap.indo['2012'], aseanMap.indo['2013'], aseanMap.indo['2014'], aseanMap.indo['2015'], aseanMap.indo['2016'], aseanMap.indo['2017'], aseanMap.indo['2018'], aseanMap.indo['2019']);
    myanmar = Tahun(aseanMap.myanmar['2000'], aseanMap.myanmar['2001'], aseanMap.myanmar['2002'], aseanMap.myanmar['2003'], aseanMap.myanmar['2004'], aseanMap.myanmar['2005'], aseanMap.myanmar['2006'], aseanMap.myanmar['2007'], aseanMap.myanmar['2008'], aseanMap.myanmar['2009'], aseanMap.myanmar['2010'], aseanMap.myanmar['2011'], aseanMap.myanmar['2012'], aseanMap.myanmar['2013'], aseanMap.myanmar['2014'], aseanMap.myanmar['2015'], aseanMap.myanmar['2016'], aseanMap.myanmar['2017'], aseanMap.myanmar['2018'], aseanMap.myanmar['2019']);
    pinoy = Tahun(aseanMap.pinoy['2000'], aseanMap.pinoy['2001'], aseanMap.pinoy['2002'], aseanMap.pinoy['2003'], aseanMap.pinoy['2004'], aseanMap.pinoy['2005'], aseanMap.pinoy['2006'], aseanMap.pinoy['2007'], aseanMap.pinoy['2008'], aseanMap.pinoy['2009'], aseanMap.pinoy['2010'], aseanMap.pinoy['2011'], aseanMap.pinoy['2012'], aseanMap.pinoy['2013'], aseanMap.pinoy['2014'], aseanMap.pinoy['2015'], aseanMap.pinoy['2016'], aseanMap.pinoy['2017'], aseanMap.pinoy['2018'], aseanMap.pinoy['2019']);
    singapura = Tahun(aseanMap.singapure['2000'], aseanMap.singapure['2001'], aseanMap.singapure['2002'], aseanMap.singapure['2003'], aseanMap.singapure['2004'], aseanMap.singapure['2005'], aseanMap.singapure['2006'], aseanMap.singapure['2007'], aseanMap.singapure['2008'], aseanMap.singapure['2009'], aseanMap.singapure['2010'], aseanMap.singapure['2011'], aseanMap.singapure['2012'], aseanMap.singapure['2013'], aseanMap.singapure['2014'], aseanMap.singapure['2015'], aseanMap.singapure['2016'], aseanMap.singapure['2017'], aseanMap.singapure['2018'], aseanMap.singapure['2019']);
    thailand = Tahun(aseanMap.thailand['2000'], aseanMap.thailand['2001'], aseanMap.thailand['2002'], aseanMap.thailand['2003'], aseanMap.thailand['2004'], aseanMap.thailand['2005'], aseanMap.thailand['2006'], aseanMap.thailand['2007'], aseanMap.thailand['2008'], aseanMap.thailand['2009'], aseanMap.thailand['2010'], aseanMap.thailand['2011'], aseanMap.thailand['2012'], aseanMap.thailand['2013'], aseanMap.thailand['2014'], aseanMap.thailand['2015'], aseanMap.thailand['2016'], aseanMap.thailand['2017'], aseanMap.thailand['2018'], aseanMap.thailand['2019']);
    vietman = Tahun(aseanMap.vietman['2000'], aseanMap.vietman['2001'], aseanMap.vietman['2002'], aseanMap.vietman['2003'], aseanMap.vietman['2004'], aseanMap.vietman['2005'], aseanMap.vietman['2006'], aseanMap.vietman['2007'], aseanMap.vietman['2008'], aseanMap.vietman['2009'], aseanMap.vietman['2010'], aseanMap.vietman['2011'], aseanMap.vietman['2012'], aseanMap.vietman['2013'], aseanMap.vietman['2014'], aseanMap.vietman['2015'], aseanMap.vietman['2016'], aseanMap.vietman['2017'], aseanMap.vietman['2018'], aseanMap.vietman['2019']);*/
    
    listDataAseanMap = map.data;

    setState(() {
      parseData(listDataAseanMap);
    });
  }
  
  void parseData(Map<String, dynamic> data){
    var i = 0;
    List<String> name = ['INDONESIA', 'MALAYSIA', 'PHILIPINE', 'SINGAPORE', 'THAILAND', 'VIETNAM'];
    List<String> id = ['ID', 'MY', 'PH', 'SG', 'TH', 'VN'];
    for (var i = 0; i < data.length; i++) {
      print("=================================================== PARSE DATA SEARCH ==================================================");
      //print(data[id[i]]);
      dataLinearAsean.add(
        new charts.Series<Asean.LinearSales, int>(
          id: name[i],
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (Asean.LinearSales sales, _) => sales.year,
          measureFn: (Asean.LinearSales sales, _) => sales.sales,
          data: generateDataAsean(data[id[i]]),
        ),
      );
    }
  }

  List generateDataAsean(Map<String, dynamic> data){
    List<Asean.LinearSales> hasil = [];
    data.forEach((key, item)=>{
      hasil.add(new Asean.LinearSales(int.parse(key.substring(3)), int.parse(item))),
      print(key + " : " + item)
    });
    print(hasil.length);
    return hasil;
  }
  @override
  void initState() {
    fetchAsean();
    super.initState();
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
                    //dataLinear,
                    dataLinearAsean,
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

class DataAseanMap{
  final data;
  DataAseanMap(this.data);
}

class AseanMap{
  final indo;
  final myanmar;
  final pinoy;
  final singapure;
  final thailand;
  final vietman;

  AseanMap(this.indo, 
        this.myanmar,
        this.pinoy,
        this.singapure,
        this.thailand,
        this.vietman,
    );
}

class Mapping{
  final data;

  Mapping({this.data});

  factory Mapping.fromJson(Map<String, dynamic> parsedJson){
    return Mapping(data: parsedJson['data']);
  }
}

class Tahun{
  final a2000;
  final a2001;
  final a2002;
  final a2003;
  final a2004;
  final a2005;
  final a2006;
  final a2007;
  final a2008;
  final a2009;
  final a2010;
  final a2011;
  final a2012;
  final a2013;
  final a2014;
  final a2015;
  final a2016;
  final a2017;
  final a2018;
  final a2019;

  Tahun(this.a2000,
        this.a2001,
        this.a2002,
        this.a2003,
        this.a2004,
        this.a2005,
        this.a2006,
        this.a2007,
        this.a2008,
        this.a2009,
        this.a2010,
        this.a2011,
        this.a2012,
        this.a2013,
        this.a2014,
        this.a2015,
        this.a2016,
        this.a2017,
        this.a2018,
        this.a2019,
      );

}
