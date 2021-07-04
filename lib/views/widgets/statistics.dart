import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import '../../models/series_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cyv/models/style.dart';

class Subscribechart extends StatelessWidget {
  final int index;
  Subscribechart(this.index);
  @override
  Widget build(BuildContext context) {
    ChartData.fetchStatistics();
    final ydomainLabel = <TickSpec<int>>[
      TickSpec(0),
      TickSpec(20),
      TickSpec(40),
      TickSpec(60),
      TickSpec(80),
      TickSpec(100),
      TickSpec(120),
      TickSpec(140),
      TickSpec(160),
    ];
    final size = MediaQuery.of(context).size.height;
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "subscribers",
          data: ChartData.data,
          domainFn: (SubscriberSeries series, _) => series.title,
          measureFn: (SubscriberSeries series, _) => series.value,
          colorFn: (SubscriberSeries series, _) => series.color),
    ];
    var container = Container(
      height: 20,
      width: 20,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Style.primaryColor,
      ),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              container,
              Container(
                child: Text(
                  "ACTUAL Data",
                ),
                margin: EdgeInsets.only(right: 30),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Container(
                height: size * 0.65,
                child: charts.BarChart(
                  series,
                  domainAxis: new charts.OrdinalAxisSpec(
                      renderSpec: new charts.SmallTickRendererSpec(
                          labelRotation: 40,
                          labelStyle: new charts.TextStyleSpec(
                              lineHeight: 2.5,
                              fontSize: 15, // size in Pts.
                              color: charts.MaterialPalette.black),
                          lineStyle: new charts.LineStyleSpec(
                              thickness: 5,
                              color: charts.MaterialPalette.white))),

                  /// Assign a custom style for the measure axis.
                  primaryMeasureAxis: new charts.NumericAxisSpec(
                      tickProviderSpec:
                          StaticNumericTickProviderSpec(ydomainLabel),
                      showAxisLine: true,
                      renderSpec: new charts.GridlineRendererSpec(

                          // Tick and Label styling here.
                          labelStyle: new charts.TextStyleSpec(
                              lineHeight: 2.0,
                              fontSize: 17, // size in Pts.
                              color: charts.MaterialPalette.black),

                          // Change the line colors to match text color.
                          lineStyle: new charts.LineStyleSpec(
                              thickness: 5,
                              color: charts.MaterialPalette.white))),

                  //animate: true,
                  defaultRenderer: BarRendererConfig(
                    fillPattern: FillPatternType.solid,
                    cornerStrategy: const ConstCornerStrategy(10),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
