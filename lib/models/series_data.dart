// import 'package:charts_fl';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:cyv/models/style.dart';

class SubscriberSeries {
  final String title;
  final int value;
  final charts.Color color;
  SubscriberSeries(this.title, this.value, this.color);
}

class ChartData {
  static List<SubscriberSeries> data = [];
  static var random = Random();
  static void fetchStatistics() {
    data = [];
    values.forEach((element) {
      data.add(SubscriberSeries(
          element,
          random.nextInt(100),
          charts.ColorUtil.fromDartColor(
            Style.primaryColor,
          )));
    });
  }

  static var values = [
    'Male',
    'Female',
    'Football',
    'basketball',
    'handball',
  ];
}
