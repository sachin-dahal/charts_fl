import 'package:charts_fl/modules/charts/area_chart/areachart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AreaChartPage extends StatelessWidget {
  final AreaChartController _areaChartController =
      Get.put(AreaChartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GetBuilder<AreaChartController>(builder: (_areaChartController) {
          return Center(
            child: _areaChartController.chartList == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Fecting Data..."),
                      SizedBox(height: 10.0),
                      CircularProgressIndicator(),
                    ],
                  )
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SfCartesianChart(
                          legend: Legend(
                              isVisible: true, position: LegendPosition.bottom),
                          title: ChartTitle(text: 'Sales Comparison Chart'),
                          plotAreaBorderWidth: 1,
                          primaryXAxis: DateTimeAxis(
                              dateFormat: DateFormat.y(),
                              interval: 1,
                              intervalType: DateTimeIntervalType.years,
                              majorGridLines: MajorGridLines(width: 1),
                              edgeLabelPlacement: EdgeLabelPlacement.shift),
                          primaryYAxis: NumericAxis(
                            labelFormat: '{value}M',
                            title: AxisTitle(text: 'Revenue'),
                            interval: 1,
                            majorTickLines: MajorTickLines(size: 10),
                          ),
                          series: _areaChartController.isArea
                              ? _areaChartController.getAreaSeries()
                              : _areaChartController.getSplineSeries(),
                          tooltipBehavior: TooltipBehavior(enable: true),
                        ),
                        SizedBox(height: 30.0),
                        _areaChartController.isArea
                            ? Text("Switch to Spline")
                            : Text("Switch to Area"),
                        Switch(
                            value: _areaChartController.isArea,
                            onChanged: _areaChartController.toggleAreaSpline)
                      ],
                    ),
                  ),
          );
        }),
      ),
    );
  }
}
