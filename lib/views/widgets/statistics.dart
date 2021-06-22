import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import '../../models/series_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cyv/models/style.dart';

class Subscribechart extends StatelessWidget {
  final List<SubscriberSeries> data;

  Subscribechart(this.data);
  @override
  Widget build(BuildContext context) {
    final staticLabel = <TickSpec<int>>[
      TickSpec(100),
      TickSpec(150),
      TickSpec(200),
      TickSpec(250),
      TickSpec(300),
      TickSpec(350),
      TickSpec(400),
      TickSpec(450),
      TickSpec(500),
    ];
    final size = MediaQuery.of(context).size.height;
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "subscribers",
          data: data,
          domainFn: (SubscriberSeries series, _) => series.year.toString(),
          measureFn: (SubscriberSeries series, _) => series.subscribtion,
          colorFn: (SubscriberSeries series, _) => series.barchar)
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
          SizedBox(
            height: size * 0.09,
          ),
          Container(
              // width: size * 0.8,
              padding: EdgeInsets.all(10),
              child:
                  // SizedBox(height: size * 0.2),
                  Container(
                height: size * 0.6,
                child: charts.BarChart(
                  series,
                  domainAxis: new charts.OrdinalAxisSpec(
                      renderSpec: new charts.SmallTickRendererSpec(
                          labelRotation: 30,

                          // Tick and Label styling here.
                          labelStyle: new charts.TextStyleSpec(
                              lineHeight: 2.0,
                              fontSize: 15, // size in Pts.
                              color: charts.MaterialPalette.black),

                          // Change the line colors to match text color.
                          lineStyle: new charts.LineStyleSpec(
                              thickness: 5,
                              color: charts.MaterialPalette.white))),

                  /// Assign a custom style for the measure axis.
                  primaryMeasureAxis: new charts.NumericAxisSpec(
                      tickProviderSpec:
                          StaticNumericTickProviderSpec(staticLabel),
                      showAxisLine: true,
                      renderSpec: new charts.GridlineRendererSpec(

                          // Tick and Label styling here.
                          labelStyle: new charts.TextStyleSpec(
                              lineHeight: 2.0,
                              fontSize: 17, // size in Pts.
                              color: charts.MaterialPalette.black),

                          // Change the line colors to match text color.
                          lineStyle: new charts.LineStyleSpec(
                              thickness: 3,
                              color: charts.MaterialPalette.white))),

                  animate: true,
                  defaultRenderer: BarRendererConfig(
                    fillPattern: FillPatternType.solid,
                    cornerStrategy: const ConstCornerStrategy(8),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
