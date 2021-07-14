import 'package:charts_flutter/flutter.dart';
import 'package:cyv/controllers/candidate.dart';
import 'package:cyv/controllers/user.dart';
import 'package:flutter/material.dart';
import '../../models/analysis.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cyv/models/style.dart';

class Subscribechart extends StatelessWidget {
  final int index;
  Subscribechart(this.index);
  Widget future(Function future, Widget screen) {
    return FutureBuilder(
        future: future(),
        builder: (ctx, fetchResultSnapshot) =>
            fetchResultSnapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : screen);
  }

  @override
  Widget build(BuildContext context) {
    return index == 0
        ? (ChartData.allUserAnalysis.isNotEmpty
            ? ChartsWidget(index)
            : future(CandidatesCtr.fetchAnalysis, ChartsWidget(index)))
        : (ChartData.resultAnalysis.isNotEmpty
            ? ChartsWidget(index)
            : future(UserCtr.fetchProgram, ChartsWidget(index)));
  }
}

class ChartsWidget extends StatelessWidget {
  final int index;
  ChartsWidget(this.index);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Style.primaryColor,
            ),
          ),
          Container(
            child: Text(
              index == 0 ? "All Voters" : "Result",
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
        ],
      ),
      ...(index == 0
          ? ChartData.allUserAnalysisSeries.entries
              .map((analysis) => StatistcsWidget(analysis.value))
              .toList()
          : ChartData.resultAnalysisSeries.entries
              .map((analysis) => StatistcsWidget(analysis.value))
              .toList())
    ]));
  }
}

class StatistcsWidget extends StatelessWidget {
  final List<Series<SubscriberSeries, String>> analysis;

  const StatistcsWidget(this.analysis);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Column(children: [
      Container(
          padding: EdgeInsets.all(10),
          child: Container(
            height: size * 0.65,
            child: charts.BarChart(
              analysis,
              domainAxis: new charts.OrdinalAxisSpec(
                  renderSpec: new charts.SmallTickRendererSpec(
                      labelRotation: 40,
                      labelStyle: new charts.TextStyleSpec(
                          lineHeight: 2.5,
                          fontSize: 15, // size in Pts.
                          color: charts.MaterialPalette.black),
                      lineStyle: new charts.LineStyleSpec(
                          thickness: 5, color: charts.MaterialPalette.white))),

              /// Assign a custom style for the measure axis.
              primaryMeasureAxis: new charts.NumericAxisSpec(
                  tickProviderSpec: StaticNumericTickProviderSpec(
                      ChartData.allUserYdomainLabel),
                  showAxisLine: true,
                  renderSpec: new charts.GridlineRendererSpec(

                      // Tick and Label styling here.
                      labelStyle: new charts.TextStyleSpec(
                          lineHeight: 2.0,
                          fontSize: 17, // size in Pts.
                          color: charts.MaterialPalette.black),

                      // Change the line colors to match text color.
                      lineStyle: new charts.LineStyleSpec(
                          thickness: 5, color: charts.MaterialPalette.white))),

              //animate: true,
              defaultRenderer: BarRendererConfig(
                fillPattern: FillPatternType.solid,
                cornerStrategy: const ConstCornerStrategy(10),
              ),
            ),
          )),
      SizedBox(
        height: 20,
      )
    ]);
  }
}
