import 'package:custom_app/NotificationManager.dart';
import 'package:custom_app/alaramTimeDialog/CustomDialogBox.dart';
import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:flutter/material.dart';

import 'model/investigation.dart';

class Investigations extends StatefulWidget {
  int cycleNumber;

  Investigations(this.cycleNumber);

  @override
  _InvestigationsState createState() => _InvestigationsState();
}

class _InvestigationsState extends State<Investigations> {
  String investigationDropdownValue = 'Untersuchung auswählen';
  String investigationDate = "";
  String investigationTime = "";
  TextEditingController investigationController = TextEditingController();
  bool investigationSwitch = false;

  String investigationAlarmTime = "";
  String investigationAlarmTimeName = "";

  List<String> investigationSpinnerItems = [
    'Untersuchung auswählen',
    'Ultraschall',
    'Blutabnahme',
    'Biopsie',
    'Eileiterdurchlässigkeitsprüfung',
    'Bauchspiegelung',
    'Gebärmutterspiegelung'
  ];

  List<InvestigationsData> list = [];

  _InvestigationsState();

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
          margin: EdgeInsets.only(top: 10, right: 20, left: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Untersuchungen",
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
            margin: EdgeInsets.only(top: 5, right: 20, left: 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0XFF196319), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(0))),
            child: DropdownButton<String>(
              value: investigationDropdownValue,
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
                  investigationDropdownValue = data;
                });
              },
              items: investigationSpinnerItems
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
                          investigationDate =
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
                      investigationDate == ""
                          ? 'Datum auswählen'
                          : investigationDate,
                      style: TextStyle(
                          fontFamily: Constant.font_name,
                          fontSize: Constant.subHeadingTextSize),
                    )),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/clock.png'),
              ),
              GestureDetector(
                onTap: () {
                  Constant.getTime(context).then((picked) => {
                        if (picked != null)
                          {
                            setState(() {
                              investigationTime = Constant.formatTime(
                                      picked.hour.toString()) +
                                  ":" +
                                  Constant.formatTime(picked.minute.toString());
                            })
                          }
                      });
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      investigationTime == ""
                          ? 'Zeit auswählen'
                          : investigationTime,
                      style: TextStyle(
                          fontFamily: Constant.font_name,
                          fontSize: Constant.subHeadingTextSize),
                    )),
              )
            ],
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
                      controller: investigationController,
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
                  value: investigationSwitch,
                  onChanged: (value) {
                    if (!value) {
                      investigationAlarmTimeName = "";
                      investigationAlarmTime = "";
                    }
                    setState(() {
                      investigationSwitch = value;
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
          visible: investigationSwitch,
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
                              investigationAlarmTimeName = name;
                              investigationAlarmTime = time;
                              time = time;
                              setState(() {});
                            },
                            onLimitExceed: () {
                              showMessage("wähle nur einen aus");
                            },
                          );
                        });

                    /* Constant.getTime(context).then((value) => {
                          if (value != null)
                            {
                              alarmTime = Constant.formatTime(
                                      value.hour.toString()) +
                                  ":" +
                                  Constant.formatTime(value.minute.toString()),
                              setState(() {})
                            }
                        });
                    FocusScope.of(context).unfocus();*/
                  },
                  child: Text(
                    investigationAlarmTimeName == ""
                        ? "Wählen Sie die Alarmzeit"
                        : investigationAlarmTimeName,
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
            saveInvestigation();
          },
          child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(left: 30, right: 30, top: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF196319),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                'Untersuchung speichern',
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
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(list[index].investigations,
                                style: TextStyle(
                                    fontFamily: Constant.font_name,
                                    fontSize: Constant.subHeadingTextSize))),
                        Visibility(
                          visible: list[index].text != "",
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Image(
                                    image: AssetImage('assets/tick_2.png'),
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(list[index].text,
                                      style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          fontSize:
                                              Constant.subHeadingTextSize))),
                            ],
                          ),
                        ),
                      ],
                    ),
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

  void saveInvestigation() {
    if (investigationDropdownValue == "Untersuchung auswählen") {
      showMessage("Untersuchung auswählen");
      return;
    }

    if (investigationDate.isEmpty) {
      showMessage("Datum auswählen");
      return;
    }

    if (investigationTime.isEmpty) {
      showMessage("Zeit auswählen");
      return;
    }

    if (investigationSwitch && investigationAlarmTimeName == "") {
      showMessage("Wählen Sie die Alarmzeit");
      return;
    }

    if (investigationController.text.isEmpty) {
      investigationController.text = "";
    }

    DateTime alarmDateTime = Constant.convertDateTimeStringToDate(
        investigationDate, investigationTime);
    if (investigationAlarmTime != "")
      alarmDateTime = alarmDateTime
          .subtract(Duration(minutes: int.parse(investigationAlarmTime)));

    InvestigationsData investigationsData = new InvestigationsData();

    investigationsData.investigations = investigationDropdownValue;
    investigationsData.date = investigationDate;
    investigationsData.time = investigationTime;
    investigationsData.alarmTime = alarmDateTime.toString();
    investigationsData.cycleNumber = widget.cycleNumber;
    investigationsData.text = investigationController.text;
    investigationsData.isChecked = investigationSwitch ? 1 : 0;

    // get notification id first, so that we save in db
    if (investigationsData.isChecked == 1) {
      investigationsData.notificationId = DateTime.now().millisecondsSinceEpoch;
    }

    CustomDB.instance.addInvestigation(investigationsData).then((value) => {
          list.add(investigationsData),
          investigationDate = "",
          investigationTime = "",
          investigationController.text = "",
          investigationSwitch = false,
          investigationDropdownValue = "Untersuchung auswählen",
          if (investigationsData.isChecked == 1)
            {
              notificationManager.scheduleAlarm(
                  investigationsData.notificationId,
                  investigationsData.investigations,
                  investigationsData.time,
                  alarmDateTime),
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
