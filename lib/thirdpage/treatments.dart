import 'package:custom_app/alaramTimeDialog/CustomDialogBox.dart';
import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:flutter/material.dart';

import '../NotificationManager.dart';
import 'model/Treatments.dart';

// ignore: must_be_immutable
class TreatmentView extends StatefulWidget {
  int cycleNumber;

  TreatmentView(this.cycleNumber);

  @override
  _TreatmentViewState createState() => _TreatmentViewState();
}

class _TreatmentViewState extends State<TreatmentView> {
  String treatmentDropdownValue = 'Behandlung auswählen';
  List<String> treatmentSpinnerItems = [
    'Behandlung auswählen',
    'Punktion',
    'Transfer',
    'Insemination',
  ];

  String teatmentDate = "";
  String teatmentTime = "";
  bool treatmentSwitch = false;

  String treatmentAlarmTime = "";
  String treatmentAlarmTimeName = "";

  TextEditingController treatmentController = TextEditingController();

  List<Treatments> list = [];

  _TreatmentViewState();

  NotificationManager notificationManager;

  @override
  void initState() {
    super.initState();
    notificationManager = NotificationManager();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Behandlungen",
              style: TextStyle(
                color: Color(0xFF196319),
                fontSize: Constant.HeadingTextSize,
                fontFamily: Constant.font_name,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10, right: 20, left: 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0XFF196319), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(0))),
            child: DropdownButton<String>(
              value: treatmentDropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 0.0,
              elevation: 16,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
              underline: Container(
                height: 0,
                color: Colors.transparent,
              ),
              onChanged: (String data) {
                setState(() {
                  treatmentDropdownValue = data;
                });
              },
              items: treatmentSpinnerItems
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/calander.png'),
              ),
              GestureDetector(
                onTap: () {
                  Constant.getDate(context).then((picked) => {
                        setState(() {
                          teatmentDate =
                              Constant.formatTime(picked.day.toString()) +
                                  "." +
                                  Constant.formatTime(picked.month.toString()) +
                                  "." +
                                  picked.year.toString();
                        })
                      });
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      teatmentDate == "" ? 'Datum auswählen' : teatmentDate,
                      style: TextStyle(
                          fontFamily: Constant.font_name,
                          fontSize: Constant.subHeadingTextSize),
                    )),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Constant.getTime(context).then((picked) => {
                  setState(() {
                    teatmentTime = Constant.formatTime(picked.hour.toString()) +
                        ":" +
                        Constant.formatTime(picked.minute.toString());
                  })
                });
            FocusScope.of(context).unfocus();
          },
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/clock.png'),
                ),
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      teatmentTime == "" ? 'Zeit auswählen' : teatmentTime,
                      style: TextStyle(
                          fontFamily: Constant.font_name,
                          fontSize: Constant.subHeadingTextSize),
                    ))
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/tick.png'),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      style: TextStyle(
                          fontFamily: Constant.font_name,
                          fontSize: Constant.subHeadingTextSize),
                      controller: treatmentController,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                          hintText: 'Ergebnis eintragen'),
                    )),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/bell.png'),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'Erinnerung',
                        style: TextStyle(
                            fontFamily: Constant.font_name,
                            fontSize: Constant.subHeadingTextSize),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Switch(
                  value: treatmentSwitch,
                  onChanged: (value) {
                    if (!value) {
                      treatmentAlarmTime = "";
                      treatmentAlarmTimeName = "";
                    }
                    setState(() {
                      treatmentSwitch = value;
                    });
                  },
                  activeTrackColor: Color(Constant.toolbar_color),
                  activeColor: Color(Constant.toolbar_color),
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: treatmentSwitch,
          child: Container(
            margin: EdgeInsets.only(right: 20, left: 30),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  "",
                  style: TextStyle(
                      fontSize: Constant.subHeadingTextSize,
                      fontFamily: Constant.font_name),
                )),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            timeList: Constant.timeList(),
                            limit: 1,
                            onTimeSelect: (time, name) {
                              treatmentAlarmTimeName = name;
                              treatmentAlarmTime = time;
                              time = time;
                              setState(() {});
                            },
                            onLimitExceed: () {
                              showMessage("wähle nur einen aus");
                            },
                          );
                        });
                  },
                  child: Text(
                    treatmentAlarmTimeName == ""
                        ? "Wählen Sie die Alarmzeit"
                        : treatmentAlarmTimeName,
                    style: TextStyle(
                        fontSize: Constant.subHeadingTextSize,
                        fontFamily: Constant.font_name),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            saveTreatment();
          },
          child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF196319),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                'Behandlung speichern',
                style: TextStyle(
                  fontFamily: Constant.font_name,
                  color: Colors.white,
                  fontSize: Constant.HeadingTextSize,
                ),
                textAlign: TextAlign.center,
              )),
        ),
        ListView.builder(
          itemCount: list == null ? 0 : list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 10, right: 20, left: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              list[index].date,
                              style: TextStyle(
                                  fontFamily: Constant.font_name,
                                  fontSize: Constant.subHeadingTextSize),
                            )),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(list[index].time,
                                style: TextStyle(
                                    fontFamily: Constant.font_name,
                                    fontSize: Constant.subHeadingTextSize))),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(list[index].text,
                            style: TextStyle(
                                fontFamily: Constant.font_name,
                                fontSize: Constant.subHeadingTextSize))),
                  ),
                ],
              ),
            );
          },
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Divider(
            thickness: 2,
            color: Colors.black.withOpacity(0.2),
          ),
        ),
      ],
    );
  }

  void saveTreatment() {
    if (treatmentDropdownValue == "Behandlung auswählen") {
      showMessage("Behandlung auswählen");
      return;
    }

    if (teatmentDate.isEmpty) {
      showMessage("Behandlungsdatum auswählen");
      return;
    }

    if (teatmentTime.isEmpty) {
      showMessage("Behandlungszeit auswählen");
      return;
    }

    if (treatmentSwitch && treatmentAlarmTimeName == "") {
      showMessage("Wählen Sie die Alarmzeit");
      return;
    }

    DateTime alarmDateTime =
        Constant.convertDateTimeStringToDate(teatmentDate, teatmentTime);

    if (treatmentAlarmTime != "")
      alarmDateTime = alarmDateTime
          .subtract(Duration(minutes: int.parse(treatmentAlarmTime)));

    Treatments treatments = new Treatments();
    treatments.text = treatmentDropdownValue;
    treatments.date = teatmentDate;
    treatments.time = teatmentTime;
    treatments.alarmTime = alarmDateTime.toString();
    treatments.cycleNumber = widget.cycleNumber;
    treatments.treatment = treatmentController.text;
    treatments.isChecked = treatmentSwitch ? 1 : 0;

    if (treatments.isChecked == 1) {
      treatments.notificationId = DateTime.now().millisecondsSinceEpoch;
    }

    CustomDB.instance.addTreatment(treatments).then((value) => {
          list.add(treatments),
          teatmentDate = "",
          teatmentTime = "",
          treatmentSwitch = false,
          treatmentController.text = "",
          treatmentDropdownValue = 'Behandlung auswählen',
          if (treatments.isChecked == 1)
            {
              notificationManager.scheduleAlarm(treatments.notificationId,
                  treatments.text, treatments.time, alarmDateTime),
            },
          setState(() {}),
        });
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
