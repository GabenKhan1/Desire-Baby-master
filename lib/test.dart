import 'package:custom_app/secondpage/model/peroid_data.dart';
import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
import 'package:fl_animated_linechart/chart/line_chart.dart';
import 'package:flutter/material.dart';

import 'other/constant.dart';

class Test extends StatefulWidget {
  final List<PeriodData> tempDataList;



  const Test({Key key, this.tempDataList}) : super(key: key);@override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<Test> {
  int chartIndex = 0;




  @override
  Widget build(BuildContext context) {
    Map<DateTime, double> line1 = createLine2();
    LineChart chart;

    chart = LineChart.fromDateTimeMaps(
      [line1],
      [Colors.black],
    );


    return Scaffold(
      appBar: AppBar(
        title: Text("Basaltemperatur"),
      ),
      body: Container(
        child: widget.tempDataList.length == 0 ? Center(child: Text(
          "Chart is empty",
          style: TextStyle(
            color: Color(0xFF196319),
            fontSize: 20,
            fontFamily: Constant.font_name,
          ),
        )) :  Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Expanded(
                    child: AnimatedLineChart(
                      chart,
                      key: UniqueKey(),
                    )),
              ]),
        ),
      ),
    );
  }

  Map<DateTime, double> createLine2() {
    Map<DateTime, double> data = {};

    for (int i = 0; i < widget.tempDataList.length; i++) {
      data[Constant.convertStringToDate(widget.tempDataList[i].date)] =
          double.parse(widget.tempDataList[i].value
              .replaceAll(Constant.tempPostFix, ""));
    }
    return data;
  }
}
