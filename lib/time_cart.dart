/*
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TimeChart extends StatefulWidget {
  final List<charts.Series> seriesList;
  final String title;

  TimeChart(this.seriesList, this.title);

  @override
  _TimeChartState createState() => _TimeChartState();
}

class _TimeChartState extends State<TimeChart> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [

              Expanded(
                child: charts.TimeSeriesChart(
                  widget.seriesList,
                  animate: true,
                  dateTimeFactory: const charts.LocalDateTimeFactory(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
*/

import 'package:custom_app/other/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> lineColorGradient = [
    Colors.black,
    Colors.black,
  ];

  List<FlSpot> data = [
    FlSpot(1, 3),
   /* FlSpot(2.6, 2),
    FlSpot(4.9, 5),
    FlSpot(6.8, 3.1),
    FlSpot(8, 4),
    FlSpot(9.5, 3),
    FlSpot(11, 4),
    FlSpot(13, 5),
    FlSpot(15, 6),*/
  ];

  Color lineColor = const Color(0xff505050);
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: const Color(0xFFCBE398)),
          child: LineChart(

            mainData(),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(


      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: lineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: lineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        topTitles: SideTitles(
          showTitles: true,
          reservedSize: 50,
          getTextStyles: (value) =>
              const TextStyle(color: Colors.black, fontSize: 14),
          getTitles: (value) {
            if (value != 0 && value % 6 == 0) {
              return getMoth(value.toInt());
            }
            return "";
          },
          margin: 8,
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTextStyles: (value) =>
              const TextStyle(color: Colors.black, fontSize: 12),
          getTitles: (value) {
            if (value % 2 == 0) {
              return "";
            }
            return getDay(value.toInt());
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.black,
            fontSize: 13,
          ),
          getTitles: (value) {
            double x = 35;
            if (value != 0) {
              x += 0.50 * value;
            }
            return x.toString();
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: lineColor, width: 1)),
      maxX: data.length <10 ? 16 : data.length.toDouble()*2,

      minY: 0,
      maxY: 8,
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: true,
          colors: lineColorGradient,
          barWidth: 3,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }

  DateTime dateTime = DateTime.now();

  String getDay(int days) {
    return DateFormat(' dd').format(dateTime.add(Duration(days: days)));
  }

  String getMoth(int days) {
    return Constant.convertMonthToGerman(
            DateFormat('MMMM').format(dateTime.add(Duration(days: days)))) +
        DateFormat(' yyyy').format(dateTime.add(Duration(days: days)));
  }

/*
  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }*/
}
