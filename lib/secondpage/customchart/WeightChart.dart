import 'package:custom_app/other/constant.dart';
import 'package:custom_app/secondpage/model/peroid_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeightChart extends StatefulWidget {
  final List<PeriodData> weightDataList;

  WeightChart({Key key, this.weightDataList}) : super(key: key);

  @override
  _WeightChartState createState() => _WeightChartState();
}

class ChartTimeData {
  DateTime time;
  double value;
}

class _WeightChartState extends State<WeightChart> {
  int threshold = 60;
  int difference = 5;

  List<Color> lineColorGradient = [
    Colors.black,
    Colors.black,
  ];

  List<FlSpot> data = [
    // FlSpot(38.0, 2),
    // FlSpot(35.0, 3),
    // FlSpot(36.0, 4),
    // FlSpot(37.0, 5),
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

  List<ChartTimeData> list = [];
  DateTime chartStartDate;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.weightDataList.length; i++) {
      ChartTimeData chartTimeData = ChartTimeData();
      chartTimeData.value = double.parse(widget.weightDataList[i].value
          .replaceAll(Constant.weightPostFix, ""));
      chartTimeData.time =
          Constant.convertStringToDate(widget.weightDataList[i].date);

      list.add(chartTimeData);
    }

    list.sort((a, b) {
      return a.time.compareTo(b.time);
    });

    if (list.length > 0) {
      chartStartDate = list[0].time;
    } else {
      chartStartDate = DateTime.now();
    }

    for (int i = 0; i < list.length; i++) {
      print(list[i].value.toString() + " " + list[i].time.toString());

      if (Constant.isSameDay(chartStartDate, list[i].time)) {
        data.add(
          FlSpot(0, (list[i].value - threshold) / difference),
        );
      } else if (list[i].time.isAfter(chartStartDate)) {
        Duration duration = list[i].time.difference(chartStartDate);
        data.add(
          FlSpot(duration.inDays.toDouble(),
              (list[i].value - threshold) / difference),
        );
      }
    }
    if (data.length == 0) {
      data.add(FlSpot(1, 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(
          'Gewicht',
          style: TextStyle(
              color: Color(Constant.toolbar_text_color),
              fontFamily: Constant.font_name),
        ),

        centerTitle: true,
        backgroundColor: Color(Constant.toolbar_color),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,

        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
          return touchedBarSpots.map((barSpot) {
            print(barSpot.spotIndex);
            return LineTooltipItem(
              '${list[barSpot.spotIndex].value}\n${getDate(list[barSpot.spotIndex].time)}',
              const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            );
          }).toList();
        }),
      ),
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
            double x = threshold.toDouble();
            if (value != 0) {
              x += difference * value;
            }
            return x.toString();
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: lineColor, width: 1)),
      maxX: data.length < 10 ? 16 : data.length.toDouble() * 2,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: true,
          colors: lineColorGradient,
          barWidth: 2,
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

  String getDay(int days) {
    return DateFormat(' dd').format(chartStartDate.add(Duration(days: days)));
  }

  String getMoth(int days) {
    return Constant.convertMonthToGerman(DateFormat('MMMM')
            .format(chartStartDate.add(Duration(days: days)))) +
        DateFormat(' yyyy').format(chartStartDate.add(Duration(days: days)));
  }

  String getDate(DateTime time) {
    return DateFormat('dd MMMM yyyy').format(time);
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
