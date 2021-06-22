// import 'package:charts_fl';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:cyv/models/style.dart';

class SubscriberSeries {
  final String year;
  final int subscribtion;
  final charts.Color barchar;
  SubscriberSeries(this.year, this.subscribtion, this.barchar);
}

class ChartData {
  static List<SubscriberSeries> data = [
    SubscriberSeries(
        'male',
        100,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        'female',
        200,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        'first year',
        300,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2014',
        400,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2013',
        500,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2012',
        100,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2013',
        300,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2010',
        150,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2011',
        200,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2012',
        300,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2017',
        250,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2018',
        270,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2019',
        10,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        )),
    SubscriberSeries(
        '2020',
        12,
        charts.ColorUtil.fromDartColor(
          Style.primaryColor,
        ))
  ];
}
