import 'package:custom_app/calander/vertical_calendar.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/save_value.dart';
import 'package:custom_app/secondpage/model/peroid_day.dart';
import 'package:custom_app/thirdpage/model/Treatments.dart';
import 'package:custom_app/thirdpage/model/investigation.dart';
import 'package:custom_app/thirdpage/model/medikamente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyMonth extends StatefulWidget {
  final ValueChanged<DateTime> onDayPressed;

  final List<Treatments> allTreamentList;
  final List<MedikamenteData> allMedikaments;
  final List<InvestigationsData> allInvestigations;
  final List<PeriodDay> periodDayList;
  String ovulationDay;

  MyMonth({
    this.allTreamentList,
    this.allInvestigations,
    this.allMedikaments,
    this.periodDayList,
    this.ovulationDay,
    this.onDayPressed,
  });

  @override
  _MyMonthState createState() => _MyMonthState();
}

class _MyMonthState extends State<MyMonth> {
  DateTime pDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meine Monate',
          style: TextStyle(
              color: Color(Constant.toolbar_text_color),
              fontFamily: Constant.font_name),
        ),
        centerTitle: true,
        backgroundColor: Color(Constant.toolbar_color),
        automaticallyImplyLeading: false,
      ),
      body: VerticalCalendar(
          minDate: DateTime(2021),
          maxDate: DateTime(2120),
          currentDate: DateTime.now(),
          allTreamentList: widget.allTreamentList,
          allInvestigations: widget.allInvestigations,
          allMedikaments: widget.allMedikaments,
          ovulationDay: widget.ovulationDay,
          onDayPressed: (day) {
            // Navigator.pop(context,day);

            widget.onDayPressed(day);
          },
          periodDayList: widget.periodDayList),
    );
  }

  @override
  void initState() {
    super.initState();

    SaveValue.getPeriodDuration().then((duration) => {
          SaveValue.getLastPeriodDate().then((date) => {
                if (date != null)
                  {
                    pDateTime = DateTime(
                        int.parse(date.split(".")[2]),
                        int.parse(date.split(".")[1]),
                        int.parse(date.split(".")[0])),
                    setState(() {})
                  }
              })
        });
  }
}
