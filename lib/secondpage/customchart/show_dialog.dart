// import 'package:custom_app/db/custom_db.dart';
// import 'package:custom_app/other/constant.dart';
// import 'package:custom_app/secondpage/customchart/TempChart.dart';
// import 'package:custom_app/secondpage/model/peroid_data.dart';
// import 'package:custom_app/secondpage/model/peroid_day.dart';
// import 'package:custom_app/thirdpage/model/Treatments.dart';
// import 'package:custom_app/thirdpage/model/investigation.dart';
// import 'package:custom_app/thirdpage/model/medikamente.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// import '../../save_value.dart';

// class ShowDialog extends StatefulWidget {
//   final DateTime selectedDate;
//   ShowDialog({
//     Key key,
//     this.selectedDate,
//   }) : super(key: key);

//   @override
//   State<ShowDialog> createState() => _ShowDialogState();
// }

// int temp = 7;
// DateTime initialSelectedDay;
// CalendarController calendarController = CalendarController();
// Map<DateTime, List<dynamic>> pDay;
// String dayOfCycle = "";
// List<dynamic> p;

// TextEditingController tempControler = TextEditingController();
// int threshold = 32;
// double difference = 1.0;
// List<InvestigationsData> investigationList;
// List<MedikamenteData> medikamentList;
// List<Treatments> treatmentList;
// List<ChartTimeData> list = [];
// DateTime chartStartDate;
// DateTime selectedDateForPeriodData;

// class _ShowDialogState extends State<ShowDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       child: Container(
//         height: 300,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 40.0, left: 30, right: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           TableCalendar(
//                               initialSelectedDay: initialSelectedDay,
//                               holidays: pDay,
//                               // events: events,
//                               startingDayOfWeek: StartingDayOfWeek.monday,
//                               startDay: DateTime.utc(2020),
//                               endDay: DateTime.utc(2050),
//                               calendarController: calendarController,
//                               locale: 'de',
//                               weekendDays: [],
//                               onDaySelected:
//                                   (DateTime day, List events, List holidays) {
//                                 loadDataDateVise(day);
//                                 loadPeriodDay();
//                                 loadCycleDay(day);
//                                 selectedDateForPeriodData = day;
//                               },
//                               initialCalendarFormat: CalendarFormat.week,
//                               builders: CalendarBuilders(),
//                               daysOfWeekStyle: DaysOfWeekStyle(
//                                   weekdayStyle: TextStyle(
//                                       fontFamily: Constant.font_name,
//                                       fontSize: Constant.HeadingTextSize)),
//                               calendarStyle: CalendarStyle(
//                                   canEventMarkersOverflow: true,
//                                   eventDayStyle: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xFF196319),
//                                       fontFamily: Constant.font_name,
//                                       fontSize: Constant.HeadingTextSize),
//                                   weekdayStyle: TextStyle(
//                                       fontFamily: Constant.font_name,
//                                       fontSize: Constant.HeadingTextSize),
//                                   holidayStyle: TextStyle(
//                                       color: Colors.red[600],
//                                       fontFamily: Constant.font_name,
//                                       fontSize: Constant.HeadingTextSize),
//                                   outsideHolidayStyle: TextStyle(
//                                       color: Colors.red[600],
//                                       fontFamily: Constant.font_name,
//                                       fontSize: Constant.HeadingTextSize),
//                                   selectedColor: Color(0xFF196319),
//                                   todayColor: Colors.grey),
//                               headerStyle: HeaderStyle(
//                                 titleTextStyle: TextStyle(
//                                     fontFamily: Constant.font_name,
//                                     fontSize: 20),
//                                 formatButtonVisible: false,
//                                 centerHeaderTitle: true,
//                               )),
//                           Container(
//                             margin: EdgeInsets.only(top: 30),
//                             child: ListView.builder(
//                               itemCount: investigationList == null
//                                   ? 0
//                                   : investigationList.length,
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 return Container(
//                                   margin: EdgeInsets.only(
//                                       top: 10, right: 20, left: 20),
//                                   child: Row(
//                                     children: [
//                                       Text(investigationList[index].time,
//                                           style: TextStyle(
//                                               fontSize:
//                                                   Constant.HeadingTextSize,
//                                               fontFamily: Constant.font_name)),
//                                       Expanded(
//                                         flex: 1,
//                                         child: Container(),
//                                       ),
//                                       Expanded(
//                                           flex: 7,
//                                           child: Container(
//                                               margin: EdgeInsets.only(left: 25),
//                                               child: Text(
//                                                 investigationList[index]
//                                                     .investigations,
//                                                 style: TextStyle(
//                                                     fontSize: Constant
//                                                         .HeadingTextSize,
//                                                     fontFamily:
//                                                         Constant.font_name),
//                                               ))),
//                                       Container(
//                                         margin: EdgeInsets.only(right: 15),
//                                         child: Image(
//                                           image: investigationList[index]
//                                                       .isChecked ==
//                                                   1
//                                               ? AssetImage('assets/bell_2.png')
//                                               : AssetImage('assets/bell_1.png'),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           ListView.builder(
//                             itemCount: medikamentList == null
//                                 ? 0
//                                 : medikamentList.length,
//                             shrinkWrap: true,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                   margin: EdgeInsets.only(
//                                       top: 10, right: 20, left: 20),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         margin: EdgeInsets.only(top: 5),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               flex: 1,
//                                               child: Column(
//                                                 children: [
//                                                   Align(
//                                                     alignment:
//                                                         Alignment.topLeft,
//                                                     child: Text(
//                                                       medikamentList[index]
//                                                           .time,
//                                                       style: TextStyle(
//                                                         fontFamily:
//                                                             Constant.font_name,
//                                                         fontSize: Constant
//                                                             .HeadingTextSize,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   ListView.builder(
//                                                     itemCount: medikamentList[
//                                                                     index]
//                                                                 .timeList ==
//                                                             null
//                                                         ? 0
//                                                         : medikamentList[index]
//                                                             .timeList
//                                                             .length,
//                                                     shrinkWrap: true,
//                                                     itemBuilder:
//                                                         (context, timeIndex) {
//                                                       return Container(
//                                                         margin: EdgeInsets.only(
//                                                             top: 5),
//                                                         child: Text(
//                                                           medikamentList[index]
//                                                                   .timeList[
//                                                               timeIndex],
//                                                           style: TextStyle(
//                                                               fontSize: Constant
//                                                                   .HeadingTextSize,
//                                                               fontFamily: Constant
//                                                                   .font_name),
//                                                         ),
//                                                       );
//                                                     },
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Expanded(
//                                                 flex: 4,
//                                                 child: Column(
//                                                   children: [
//                                                     Row(
//                                                       children: [
//                                                         SizedBox(
//                                                           width: 30,
//                                                           height: 30,
//                                                           child: Image(
//                                                             image: AssetImage(
//                                                                 medikamentList[
//                                                                         index]
//                                                                     .typeOfExpenditureImage),
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           margin:
//                                                               EdgeInsets.only(
//                                                                   left: 5),
//                                                           child: Text(
//                                                             medikamentList[
//                                                                     index]
//                                                                 .drugController,
//                                                             style: TextStyle(
//                                                               fontFamily:
//                                                                   Constant
//                                                                       .font_name,
//                                                               fontSize: Constant
//                                                                   .HeadingTextSize,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         Container(
//                                                           margin:
//                                                               EdgeInsets.only(
//                                                                   left: 37),
//                                                           child: Text(
//                                                             medikamentList[
//                                                                     index]
//                                                                 .dosageController,
//                                                             style: TextStyle(
//                                                               fontFamily:
//                                                                   Constant
//                                                                       .font_name,
//                                                               fontSize: Constant
//                                                                   .HeadingTextSize,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 )),
//                                             Container(
//                                               margin:
//                                                   EdgeInsets.only(right: 15),
//                                               child: Image(
//                                                 image: medikamentList[index]
//                                                             .isChecked ==
//                                                         1
//                                                     ? AssetImage(
//                                                         'assets/bell_2.png')
//                                                     : AssetImage(
//                                                         'assets/bell_1.png'),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ));
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Container(
//                       margin: EdgeInsets.only(left: 20, right: 20),
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         style: TextStyle(fontFamily: Constant.font_name),
//                         controller: tempControler,
//                         decoration: InputDecoration(
//                             isDense: true,
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 0, vertical: 2),
//                             hintText: ''),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     Constant.tempPostFix,
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: Constant.font_name,
//                         fontSize: 15),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Container(),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.03,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   String date =
//                       Constant.covertDateToString(widget.selectedDate);
//                   if (tempControler.text != "") {
//                     PeriodData p = new PeriodData();

//                     CustomDB.instance
//                         .getPeriodDataWithType(date, temp)
//                         .then((value) => {
//                               p.text = 'temprature',
//                               p.imageName = AssetImage('assets/temperature.png')
//                                   .assetName,
//                               p.date = date,
//                               p.type = 7,
//                               p.value =
//                                   tempControler.text + Constant.tempPostFix,
//                               if (value == null || value.length == 0)
//                                 {
//                                   CustomDB.instance.addPeriodData(p),
//                                 }
//                               else
//                                 {
//                                   CustomDB.instance
//                                       .deletePeriodDataWithID(value[0].id)
//                                       .then((value) => {
//                                             CustomDB.instance.addPeriodData(p),
//                                           }),
//                                 }
//                             });
//                   } else {
//                     CustomDB.instance
//                         .getPeriodDataWithType(date, temp)
//                         .then((value) => {
//                               if (value != null || value.length > 0)
//                                 {
//                                   CustomDB.instance
//                                       .deletePeriodDataWithID(value[0].id),
//                                 }
//                             });
//                   }

//                   // Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(40.0),
//                   ),
//                   primary: Constant.new_color,
//                 ),
//                 child: Text(
//                   "OK",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // String getDay(int days) {
//   //   return DateFormat(' dd').format(chartStartDate.add(Duration(days: days)));
//   // }

//   // String getMoth(int days) {
//   //   return Constant.convertMonthToGerman(DateFormat('MMMM')
//   //           .format(chartStartDate.add(Duration(days: days)))) +
//   //       DateFormat(' yyyy').format(chartStartDate.add(Duration(days: days)));
//   // }

//   // String getDate(DateTime time) {
//   //   return DateFormat('dd MMMM yyyy').format(time);
//   // }

//   List<PeriodDay> periodDayList;

//   void loadDataDateVise(DateTime todayDateTime) {
//     investigationList.clear();
//     medikamentList.clear();
//     treatmentList.clear();

//     String todayDateInString = Constant.covertDateToString(todayDateTime);

//     CustomDB.instance
//         .getInvestigationWithDate(todayDateInString)
//         .then((value) => {
//               setState(() {
//                 investigationList.addAll(value);
//               })
//             });
//     CustomDB.instance.getAllMedikaments().then((value) => {
//           for (int i = 0; i < value.length; i++)
//             {
//               if (Constant.isSameDay(todayDateTime,
//                       Constant.convertStringToDate(value[i].startDate)) ||
//                   Constant.isSameDay(todayDateTime,
//                       Constant.convertStringToDate(value[i].endDate)))
//                 {
//                   setState(() {
//                     value[i].timeList = value[i].otherTime.split(",");
//                     medikamentList.add(value[i]);
//                   })
//                 }
//               else if (todayDateTime.isAfter(
//                       Constant.convertStringToDate(value[i].startDate)) &&
//                   todayDateTime
//                       .isBefore(Constant.convertStringToDate(value[i].endDate)))
//                 {
//                   setState(() {
//                     value[i].timeList = value[i].otherTime.split(",");
//                     medikamentList.add(value[i]);
//                   })
//                 }
//             }
//         });

//     CustomDB.instance
//         .getAllTreatmentWithDate(todayDateInString)
//         .then((value) => {
//               setState(() {
//                 treatmentList.addAll(value);
//               })
//             });
//   }

//   loadCycleDay(DateTime value) {
//     SaveValue.getCycleLength().then((cycleLength) => {
//           if (cycleLength != null)
//             {
//               SaveValue.getLastPeriodDate().then((lastPeriodDate) => {
//                     if (lastPeriodDate != null)
//                       {
//                         print(lastPeriodDate),
//                         if (value.isAfter(
//                             Constant.convertStringToDate(lastPeriodDate)))
//                           {
//                             dayOfCycle = ((value
//                                             .difference(
//                                                 Constant.convertStringToDate(
//                                                     lastPeriodDate))
//                                             .inDays %
//                                         cycleLength) +
//                                     1)
//                                 .toString(),
//                             setState(() {}),
//                           }
//                         else
//                           dayOfCycle = "",
//                       }
//                   }),
//             }
//         });
//   }

//   void loadPeriodDay() {
//     /*if (selectedDateForPeriodData != null)
//       loadCycleDay(selectedDateForPeriodData);
//     else*/
//     loadCycleDay(DateTime.now());
//     periodDayList = [];
//     //pDay.clear();

//     CustomDB.instance.getPeriodDay().then((value) => {
//           if (value != null && value.length > 0)
//             {
//               print(value[0].startDate),
//               periodDayList = value,
//               for (int j = 0; j < periodDayList.length; j++)
//                 {
//                   for (int i = 0;
//                       i <=
//                           periodDayList[j]
//                               .endDate
//                               .difference(periodDayList[j].startDate)
//                               .inDays;
//                       i++)
//                     {
//                       pDay[periodDayList[j].startDate.add(Duration(days: i))] =
//                           p,
//                     }
//                 },
//               setState(() {}),
//             }
//         });
//   }
// }
