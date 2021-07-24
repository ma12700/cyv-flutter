// import 'package:charts_fl';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cyv/models/candidates.dart';
import 'package:cyv/models/style.dart';
import 'package:cyv/models/user.dart';

class SubscriberSeries {
  final String title;
  final int value;
  final charts.Color color;
  SubscriberSeries(this.title, this.value, this.color);
}

class ChartData {
  static Map<String, List<SubscriberSeries>> allUserAnalysis = {};
  static Map<String, List<SubscriberSeries>> resultAnalysis = {};
  static List<charts.TickSpec<int>> allUserYdomainLabel = [];
  static List<charts.TickSpec<int>> resultYdomainLabel = [];
  static Map<String, List<charts.Series<SubscriberSeries, String>>>
      allUserAnalysisSeries = {};
  static Map<String, List<charts.Series<SubscriberSeries, String>>>
      resultAnalysisSeries = {};

  static void storeAllUserAnalysis(List<dynamic> data) {
    int max = 0;
    data.forEach((element) {
      var keyValuePair = (element['key'] as String).split('.');
      if (!allUserAnalysis.containsKey(keyValuePair[0])) {
        allUserAnalysis[keyValuePair[0]] = [];
      }
      if (max < element['value']) {
        max = element['value'];
      }
      allUserAnalysis[keyValuePair[0]].add(SubscriberSeries(
          keyValuePair[1],
          element['value'],
          charts.ColorUtil.fromDartColor(
            Style.primaryColor,
          )));
    });
    allUserYdomainLabel.clear();
    for (var i = 0; i <= (max + 10); i += 20) {
      allUserYdomainLabel.add(charts.TickSpec(i));
    }

    if (allUserYdomainLabel.length < 2) {
      allUserYdomainLabel.add(charts.TickSpec(0));
      allUserYdomainLabel.add(charts.TickSpec(20));
    }
    allUserAnalysisSeries.clear();
    allUserAnalysis.forEach((key, value) {
      allUserAnalysisSeries[key] = [
        charts.Series(
            id: key,
            data: value,
            domainFn: (SubscriberSeries series, _) => series.title,
            measureFn: (SubscriberSeries series, _) => series.value,
            colorFn: (SubscriberSeries series, _) => series.color),
      ];
    });
  }

  static void storeResultAnalysis(List<dynamic> data) {
    int max = 0;
    data.forEach((element) {
      var keyValuePair = (element['key'] as String).split('.');
      if (keyValuePair[0] != CandidatesModel.tracks[User.trackID].dividedBy) {
        if (!resultAnalysis.containsKey(keyValuePair[0])) {
          resultAnalysis[keyValuePair[0]] = [];
        }
        if (max < element['value']) {
          max = element['value'];
        }
        resultAnalysis[keyValuePair[0]].add(SubscriberSeries(
            keyValuePair[1],
            element['value'],
            charts.ColorUtil.fromDartColor(
              Style.primaryColor,
            )));
      }
    });
    resultYdomainLabel.clear();
    for (var i = 0; i <= (max + 10); i += 20) {
      resultYdomainLabel.add(charts.TickSpec(i));
    }

    if (resultYdomainLabel.length < 2) {
      resultYdomainLabel.add(charts.TickSpec(0));
      resultYdomainLabel.add(charts.TickSpec(20));
    }
    resultAnalysisSeries.clear();
    resultAnalysis.forEach((key, value) {
      resultAnalysisSeries[key] = [
        charts.Series(
            id: key + "2",
            data: value,
            domainFn: (SubscriberSeries series, _) => series.title,
            measureFn: (SubscriberSeries series, _) => series.value,
            colorFn: (SubscriberSeries series, _) => series.color),
      ];
    });
  }

  static void clearData() {
    allUserAnalysisSeries.clear();
    resultAnalysisSeries.clear();
    allUserAnalysis.clear();
    resultAnalysis.clear();
    allUserYdomainLabel.clear();
    resultYdomainLabel.clear();
  }
}
