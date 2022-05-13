import 'package:custom_app/calander/vertical_calendar.dart';
import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../save_value.dart';
import 'model/peroid_day.dart';

class EditPeriod extends StatefulWidget {
  final List<PeriodDay> periodDayList;

  EditPeriod(this.periodDayList);

  @override
  _EditPeriodState createState() => _EditPeriodState();
}

class _EditPeriodState extends State<EditPeriod> {
  CalendarController calendarController = CalendarController();

  List<PeriodDay> finalPeriodDayList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Periode bearbeiten',
            style: TextStyle(
                color: Color(Constant.toolbar_text_color),
                fontFamily: Constant.font_name),
          ),
          actions: <Widget>[
            IconButton(
              icon: Image(
                image: AssetImage('assets/tick_3.png'),
              ),
              onPressed: () {
                if (finalPeriodDayList != null) {
                  finalPeriodDayList.sort((a, b) {
                    return a.startDate.compareTo(b.startDate);
                  });
                  CustomDB.instance.deletePeriodDay().then((value) => {
                        for (int i = 0; i < finalPeriodDayList.length; i++)
                          {
                            if (i == 0)
                              {
                                SaveValue.saveLastPeriodDate(
                                    Constant.formatTime(finalPeriodDayList[0]
                                            .startDate
                                            .day
                                            .toString()) +
                                        "." +
                                        Constant.formatTime(
                                            finalPeriodDayList[0]
                                                .startDate
                                                .month
                                                .toString()) +
                                        "." +
                                        finalPeriodDayList[0]
                                            .startDate
                                            .year
                                            .toString()),
                              },
                            CustomDB.instance
                                .addPeriodDay(finalPeriodDayList[i]),
                          },
                        Navigator.pop(context, true),
                      });
                } else {}
              },
            ),
          ],
          centerTitle: true,
          backgroundColor: Color(Constant.toolbar_color),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: Color(0xFFD5F5D5).withOpacity(0.3),
          child: VerticalCalendar(
            minDate: DateTime(2021),
            maxDate: DateTime(2120),
            currentDate: DateTime.now(),
            periodDayList: widget.periodDayList,
            onRangeSelected: (DateTime minDate, DateTime maxDate) {},
            onDayPressed: (DateTime date) {
              setState(() {});
            },
            onPeriodSelected: (periodDayList) {
              print(periodDayList.length);
              finalPeriodDayList = periodDayList;
            },
          ),
        ));
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
