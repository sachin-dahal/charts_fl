import 'package:charts_fl/modules/charts/area_chart/areachart_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chart View",
      home: AreaChartPage(),
    );
  }
}
