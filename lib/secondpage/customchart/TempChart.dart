import 'package:custom_app/other/constant.dart';
import 'package:custom_app/secondpage/model/peroid_data.dart';
import 'package:custom_app/secondpage/model/peroid_day.dart';
import 'package:custom_app/thirdpage/model/Treatments.dart';
import 'package:custom_app/thirdpage/model/investigation.dart';
import 'package:custom_app/thirdpage/model/medikamente.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TempChart extends StatefulWidget {
  final DateTime selectedDate;

  final List<PeriodData> tempDataList;

  TempChart({Key key, this.tempDataList, this.selectedDate}) : super(key: key);
  @override
  _TempChartState createState() => _TempChartState();
}

DateTime initialSelectedDay;
CalendarController calendarController = CalendarController();
Map<DateTime, List<dynamic>> pDay;
String dayOfCycle = "";
List<dynamic> p;

class ChartTimeData {
  DateTime time;
  double value;
}

class _TempChartState extends State<TempChart> {
  List<InvestigationsData> investigationList;
  List<MedikamenteData> medikamentList;
  List<Treatments> treatmentList;
  List<Color> lineColorGradient = [
    Constant.tempcolor,
    Constant.tempcolor,
    Constant.tempcolor,
    Constant.tempcolor,
  ];

  TextEditingController tempControler = TextEditingController();
  double threshold = 34;
  double difference = .41;
  double imageSize = 30;

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
  DateTime selectedDateForPeriodData;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < widget.tempDataList.length; i++) {
      ChartTimeData chartTimeData = ChartTimeData();
      chartTimeData.value = double.parse(
          widget.tempDataList[i].value.replaceAll(Constant.tempPostFix, ""));
      chartTimeData.time =
          Constant.convertStringToDate(widget.tempDataList[i].date);

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
    bool isData = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Basaltemperatur',
          style: TextStyle(
              color: Color(Constant.toolbar_text_color),
              fontFamily: Constant.font_name),
        ),
        centerTitle: true,
        backgroundColor: Color(Constant.toolbar_color),
        automaticallyImplyLeading: false,
      ),
      body: isData == false
          ? Column(children: [
              Container(
                padding: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.87,
                child: LineChart(
                  mainData(),
                ),
              ),
            ])
          : Center(
              child: CircularProgressIndicator(
              backgroundColor: Constant.bar_color,
            )),
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
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey,
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
          reservedSize: 20,
          getTextStyles: (value) =>
              const TextStyle(color: Colors.black, fontSize: 12),
          getTitles: (value) {
            if (value % 14 == 0) {
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
          reservedSize: 30,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: lineColor, width: 1)),
      maxX: data.length < 10 ? 12 : data.length.toDouble() * 2,
      minY: 0,
      maxY: 15,
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: false,
          colors: lineColorGradient,
          barWidth: 3,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: true,
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

  List<PeriodDay> periodDayList;
}








        // leading: IconButton(
        //     icon: Image(
        //       image: AssetImage("assets/edit.png"),
        //     ),
        //     onPressed: () {
        //       showDialog(
        //           context: context,
        //           builder: (BuildContext context) {
        //             return Dialog(
        //               shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(20.0)),
        //               child: Container(
        //                 height: MediaQuery.of(context).size.height * 0.42,
        //                 child: Padding(
        //                   padding: const EdgeInsets.only(
        //                       top: 40.0, left: 30, right: 30),
        //                   child: Column(
        //                     children: [
        //                       Row(
        //                         children: [
        //                           Expanded(
        //                             child: SingleChildScrollView(
        //                               child: Column(
        //                                 children: [
        //                                   TableCalendar(
        //                                       initialSelectedDay:
        //                                           initialSelectedDay,
        //                                       holidays: pDay,
        //                                       // events: events,
        //                                       startingDayOfWeek:
        //                                           StartingDayOfWeek.monday,
        //                                       startDay: DateTime.utc(2020),
        //                                       endDay: DateTime.utc(2050),
        //                                       calendarController:
        //                                           calendarController,
        //                                       locale: 'de',
        //                                       weekendDays: [],
        //                                       onDaySelected: (DateTime day,
        //                                           List events, List holidays) {
        //                                         selectedDateForPeriodData = day;
        //                                       },
        //                                       initialCalendarFormat:
        //                                           CalendarFormat.week,
        //                                       builders: CalendarBuilders(),
        //                                       daysOfWeekStyle: DaysOfWeekStyle(
        //                                           weekdayStyle: TextStyle(
        //                                               fontFamily:
        //                                                   Constant.font_name,
        //                                               fontSize: Constant
        //                                                   .HeadingTextSize)),
        //                                       calendarStyle: CalendarStyle(
        //                                           canEventMarkersOverflow: true,
        //                                           eventDayStyle: TextStyle(
        //                                               fontWeight:
        //                                                   FontWeight.bold,
        //                                               color: Color(0xFF196319),
        //                                               fontFamily:
        //                                                   Constant.font_name,
        //                                               fontSize: Constant
        //                                                   .HeadingTextSize),
        //                                           weekdayStyle: TextStyle(
        //                                               fontFamily:
        //                                                   Constant.font_name,
        //                                               fontSize: Constant
        //                                                   .HeadingTextSize),
        //                                           holidayStyle: TextStyle(
        //                                               color: Colors.red[600],
        //                                               fontFamily:
        //                                                   Constant.font_name,
        //                                               fontSize:
        //                                                   Constant.HeadingTextSize),
        //                                           outsideHolidayStyle: TextStyle(color: Colors.red[600], fontFamily: Constant.font_name, fontSize: Constant.HeadingTextSize),
        //                                           selectedColor: Color(0xFF196319),
        //                                           todayColor: Colors.grey),
        //                                       headerStyle: HeaderStyle(
        //                                         titleTextStyle: TextStyle(
        //                                             fontFamily:
        //                                                 Constant.font_name,
        //                                             fontSize: 20),
        //                                         formatButtonVisible: false,
        //                                         centerHeaderTitle: true,
        //                                       )),
        //                                   Container(
        //                                     margin: EdgeInsets.only(top: 30),
        //                                     child: ListView.builder(
        //                                       itemCount: investigationList ==
        //                                               null
        //                                           ? 0
        //                                           : investigationList.length,
        //                                       shrinkWrap: true,
        //                                       itemBuilder: (context, index) {
        //                                         return Container(
        //                                           margin: EdgeInsets.only(
        //                                               top: 10,
        //                                               right: 20,
        //                                               left: 20),
        //                                           child: Row(
        //                                             children: [
        //                                               Text(
        //                                                   investigationList[index]
        //                                                       .time,
        //                                                   style: TextStyle(
        //                                                       fontSize: Constant
        //                                                           .HeadingTextSize,
        //                                                       fontFamily: Constant
        //                                                           .font_name)),
        //                                               Expanded(
        //                                                 flex: 1,
        //                                                 child: Container(),
        //                                               ),
        //                                               Expanded(
        //                                                   flex: 7,
        //                                                   child: Container(
        //                                                       margin: EdgeInsets
        //                                                           .only(
        //                                                               left: 25),
        //                                                       child: Text(
        //                                                         investigationList[
        //                                                                 index]
        //                                                             .investigations,
        //                                                         style: TextStyle(
        //                                                             fontSize:
        //                                                                 Constant
        //                                                                     .HeadingTextSize,
        //                                                             fontFamily:
        //                                                                 Constant
        //                                                                     .font_name),
        //                                                       ))),
        //                                               Container(
        //                                                 margin: EdgeInsets.only(
        //                                                     right: 15),
        //                                                 child: Image(
        //                                                   image: investigationList[
        //                                                                   index]
        //                                                               .isChecked ==
        //                                                           1
        //                                                       ? AssetImage(
        //                                                           'assets/bell_2.png')
        //                                                       : AssetImage(
        //                                                           'assets/bell_1.png'),
        //                                                 ),
        //                                               ),
        //                                             ],
        //                                           ),
        //                                         );
        //                                       },
        //                                     ),
        //                                   ),
        //                                   ListView.builder(
        //                                     itemCount: medikamentList == null
        //                                         ? 0
        //                                         : medikamentList.length,
        //                                     shrinkWrap: true,
        //                                     itemBuilder: (context, index) {
        //                                       return Container(
        //                                           margin: EdgeInsets.only(
        //                                               top: 10,
        //                                               right: 20,
        //                                               left: 20),
        //                                           child: Column(
        //                                             children: [
        //                                               Container(
        //                                                 margin: EdgeInsets.only(
        //                                                     top: 5),
        //                                                 child: Row(
        //                                                   children: [
        //                                                     Expanded(
        //                                                       flex: 1,
        //                                                       child: Column(
        //                                                         children: [
        //                                                           Align(
        //                                                             alignment:
        //                                                                 Alignment
        //                                                                     .topLeft,
        //                                                             child: Text(
        //                                                               medikamentList[
        //                                                                       index]
        //                                                                   .time,
        //                                                               style:
        //                                                                   TextStyle(
        //                                                                 fontFamily:
        //                                                                     Constant.font_name,
        //                                                                 fontSize:
        //                                                                     Constant.HeadingTextSize,
        //                                                               ),
        //                                                             ),
        //                                                           ),
        //                                                           ListView
        //                                                               .builder(
        //                                                             itemCount: medikamentList[index].timeList ==
        //                                                                     null
        //                                                                 ? 0
        //                                                                 : medikamentList[index]
        //                                                                     .timeList
        //                                                                     .length,
        //                                                             shrinkWrap:
        //                                                                 true,
        //                                                             itemBuilder:
        //                                                                 (context,
        //                                                                     timeIndex) {
        //                                                               return Container(
        //                                                                 margin: EdgeInsets.only(
        //                                                                     top:
        //                                                                         5),
        //                                                                 child:
        //                                                                     Text(
        //                                                                   medikamentList[index]
        //                                                                       .timeList[timeIndex],
        //                                                                   style: TextStyle(
        //                                                                       fontSize: Constant.HeadingTextSize,
        //                                                                       fontFamily: Constant.font_name),
        //                                                                 ),
        //                                                               );
        //                                                             },
        //                                                           ),
        //                                                         ],
        //                                                       ),
        //                                                     ),
        //                                                     Expanded(
        //                                                         flex: 4,
        //                                                         child: Column(
        //                                                           children: [
        //                                                             Row(
        //                                                               children: [
        //                                                                 SizedBox(
        //                                                                   width:
        //                                                                       30,
        //                                                                   height:
        //                                                                       30,
        //                                                                   child:
        //                                                                       Image(
        //                                                                     image:
        //                                                                         AssetImage(medikamentList[index].typeOfExpenditureImage),
        //                                                                   ),
        //                                                                 ),
        //                                                                 Container(
        //                                                                   margin:
        //                                                                       EdgeInsets.only(left: 5),
        //                                                                   child:
        //                                                                       Text(
        //                                                                     medikamentList[index].drugController,
        //                                                                     style:
        //                                                                         TextStyle(
        //                                                                       fontFamily: Constant.font_name,
        //                                                                       fontSize: Constant.HeadingTextSize,
        //                                                                     ),
        //                                                                   ),
        //                                                                 ),
        //                                                               ],
        //                                                             ),
        //                                                             Row(
        //                                                               children: [
        //                                                                 Container(
        //                                                                   margin:
        //                                                                       EdgeInsets.only(left: 37),
        //                                                                   child:
        //                                                                       Text(
        //                                                                     medikamentList[index].dosageController,
        //                                                                     style:
        //                                                                         TextStyle(
        //                                                                       fontFamily: Constant.font_name,
        //                                                                       fontSize: Constant.HeadingTextSize,
        //                                                                     ),
        //                                                                   ),
        //                                                                 ),
        //                                                               ],
        //                                                             ),
        //                                                           ],
        //                                                         )),
        //                                                     Container(
        //                                                       margin: EdgeInsets
        //                                                           .only(
        //                                                               right:
        //                                                                   15),
        //                                                       child: Image(
        //                                                         image: medikamentList[index]
        //                                                                     .isChecked ==
        //                                                                 1
        //                                                             ? AssetImage(
        //                                                                 'assets/bell_2.png')
        //                                                             : AssetImage(
        //                                                                 'assets/bell_1.png'),
        //                                                       ),
        //                                                     ),
        //                                                   ],
        //                                                 ),
        //                                               )
        //                                             ],
        //                                           ));
        //                                     },
        //                                   ),
        //                                 ],
        //                               ),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           Image(
        //                             image: AssetImage('assets/temperature.png'),
        //                             width: imageSize,
        //                             height: imageSize,
        //                           ),
        //                           Container(
        //                             width:
        //                                 MediaQuery.of(context).size.width * 0.2,
        //                             margin:
        //                                 EdgeInsets.only(left: 20, right: 20),
        //                             child: TextFormField(
        //                               keyboardType: TextInputType.number,
        //                               style: TextStyle(
        //                                   fontFamily: Constant.font_name),
        //                               controller: tempControler,
        //                               decoration: InputDecoration(
        //                                   isDense: true,
        //                                   contentPadding: EdgeInsets.symmetric(
        //                                       horizontal: 0, vertical: 2),
        //                                   hintText: ''),
        //                             ),
        //                           ),
        //                           Text(
        //                             Constant.tempPostFix,
        //                             style: TextStyle(
        //                                 color: Colors.black,
        //                                 fontFamily: Constant.font_name,
        //                                 fontSize: 15),
        //                           ),
        //                         ],
        //                       ),
        //                       SizedBox(
        //                         height:
        //                             MediaQuery.of(context).size.height * 0.03,
        //                       ),
        //                       ElevatedButton(
        //                         onPressed: () {
        //                           String date = Constant.covertDateToString(
        //                               widget.selectedDate);
        //                           if (tempControler.text != "") {
        //                             PeriodData p = new PeriodData();

        //                             CustomDB.instance
        //                                 .getPeriodDataWithType(date, TEMP)
        //                                 .then((value) => {
        //                                       p.text = 'temprature',
        //                                       p.imageName = AssetImage(
        //                                               'assets/temperature.png')
        //                                           .assetName,
        //                                       p.date = date,
        //                                       p.type = 7,
        //                                       p.value = tempControler.text +
        //                                           Constant.tempPostFix,
        //                                     });
        //                           }

        //                           Navigator.pop(context);
        //                         },
        //                         style: ElevatedButton.styleFrom(
        //                           minimumSize: Size(
        //                               MediaQuery.of(context).size.width * 0.3,
        //                               MediaQuery.of(context).size.height *
        //                                   0.05),
        //                           shape: RoundedRectangleBorder(
        //                             borderRadius: BorderRadius.circular(20.0),
        //                           ),
        //                           primary: Constant.new_color,
        //                         ),
        //                         child: Text(
        //                           "OK",
        //                           style: TextStyle(color: Colors.white),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             );
        //           });
        //     }),