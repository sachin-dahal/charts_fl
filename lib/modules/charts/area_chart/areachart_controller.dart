import 'package:charts_fl/models/chart_data_model.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AreaChartController extends GetxController {
  List<ChartdataModel> chartList;
  bool isArea = true;

  @override
  void onInit() {
    super.onInit();
    fetchExData();
  }

  void toggleAreaSpline(bool spline) {
    isArea = spline;
    update();
  }

  fetchExData() async {
    ByteData exFile = await rootBundle.load("assets/chart_data.xlsx");
    var bytes =
        exFile.buffer.asUint8List(exFile.offsetInBytes, exFile.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    chartList = [];

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table].rows) {
        chartList.add(
          ChartdataModel(
            date: DateTime.parse(row[0]).toLocal(),
            y1: double.parse(row[1]),
            y2: double.parse(row[2]),
          ),
        );
      }
    }
    Future.delayed(Duration(seconds: 2), () => update());
  }

  List<AreaSeries<ChartdataModel, DateTime>> getAreaSeries() {
    return <AreaSeries<ChartdataModel, DateTime>>[
      AreaSeries<ChartdataModel, DateTime>(
        dataSource: chartList,
        name: 'Android',
        legendIconType: LegendIconType.circle,
        color: Colors.blue[300],
        xValueMapper: (ChartdataModel sales, _) => sales.date,
        yValueMapper: (ChartdataModel sales, _) => sales.y1,
      ),
      AreaSeries<ChartdataModel, DateTime>(
        dataSource: chartList,
        name: 'iOS',
        legendIconType: LegendIconType.circle,
        color: Colors.red[300],
        xValueMapper: (ChartdataModel sales, _) => sales.date,
        yValueMapper: (ChartdataModel sales, _) => sales.y2,
      )
    ];
  }

  List<SplineAreaSeries<ChartdataModel, DateTime>> getSplineSeries() {
    return <SplineAreaSeries<ChartdataModel, DateTime>>[
      SplineAreaSeries<ChartdataModel, DateTime>(
        dataSource: chartList,
        name: 'Android',
        legendIconType: LegendIconType.circle,
        color: Colors.blue[300],
        xValueMapper: (ChartdataModel sales, _) => sales.date,
        yValueMapper: (ChartdataModel sales, _) => sales.y1,
      ),
      SplineAreaSeries<ChartdataModel, DateTime>(
        dataSource: chartList,
        name: 'iOS',
        legendIconType: LegendIconType.circle,
        color: Colors.red[300],
        xValueMapper: (ChartdataModel sales, _) => sales.date,
        yValueMapper: (ChartdataModel sales, _) => sales.y2,
      )
    ];
  }
}
