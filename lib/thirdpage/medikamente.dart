import 'package:custom_app/alaramTimeDialog/CustomDialogBox.dart';
import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/thirdpage/model/image_data.dart';
import 'package:custom_app/thirdpage/model/medikamente.dart';
import 'package:custom_app/thirdpage/model/time_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../NotificationManager.dart';

class Medikamente extends StatefulWidget {
  int cycleNumber;

  Medikamente(this.cycleNumber);

  @override
  _MedikamenteState createState() => _MedikamenteState();
}

class _MedikamenteState extends State<Medikamente> {
  TextEditingController drugController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  double imageSize = 60;

  ImageData selected;
  List<ImageData> image = [
    new ImageData("Spritze", false, AssetImage('assets/group_1.png')),
    new ImageData("Tablette", false, AssetImage('assets/group_2.png')),
    new ImageData("Spray", false, AssetImage('assets/group_3.png')),
    new ImageData("Gel", false, AssetImage('assets/group_4.png')),
    new ImageData("Infusion", false, AssetImage('assets/group_5.png')),
  ];

  bool isSwitched = false;
  String startDate = "";
  String endDate = "";

  List<String> timeList = [];

  var time = "";
  List<MedikamenteData> list = [];

  NotificationManager notificationManager;

  String medikamenteAlarmTime = "";
  String medikamenteAlarmTimeName = "";

  @override
  void initState() {
    super.initState();
    selected = image[1];

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
              "Medikamente",
              style: TextStyle(
                color: Color(0xFF196319),
                fontSize: Constant.HeadingTextSize,
                fontFamily: Constant.font_name,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8, right: 25, left: 20),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Medikament',
                  style: TextStyle(
                      fontFamily: Constant.font_name,
                      fontSize: Constant.subHeadingTextSize,
                      color: Colors.black),
                ),
              ),
              Expanded(
                flex: 4,
                child: TextFormField(
                  style: TextStyle(
                      fontFamily: Constant.font_name,
                      fontSize: Constant.subHeadingTextSize),
                  controller: drugController,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                      hintText: ''),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, right: 25, left: 20),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Dosierung',
                  style: TextStyle(
                      fontFamily: Constant.font_name,
                      fontSize: Constant.subHeadingTextSize,
                      color: Colors.black),
                ),
              ),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: dosageController,
                  style: TextStyle(
                      fontSize: Constant.subHeadingTextSize,
                      fontFamily: Constant.font_name),
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                      hintText: ''),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 25),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Art der Einnahme",
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
            margin: EdgeInsets.only(top: 10, right: 20, left: 20),
            height: 85,
            child: ListView.builder(
              itemCount: image.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (image[index].isChecked) {
                      image[index].isChecked = false;
                    } else {
                      for (int i = 0; i < image.length; i++) {
                        image[i].isChecked = false;
                      }
                      image[index].isChecked = true;
                    }

                    setState(() {
                      selected = image[index];
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Column(
                      children: [
                        SizedBox(
                            width: imageSize,
                            height: imageSize,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          width: 3,
                                          color: image[index].isChecked
                                              ? Color(0xFF196319)
                                              : Colors.transparent)),
                                  child: Container(
                                    width: imageSize,
                                    height: imageSize,
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                        border: Border.all(
                                            color: Color(0xFFCBE398)
                                                .withOpacity(0.7),
                                            width: 2)),
                                    child: Image(
                                      image: image[index].image,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              image[index].name,
                              style: TextStyle(
                                  fontSize: 15, fontFamily: Constant.font_name),
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 25),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Beginn und Ende der Einnahme",
              style: TextStyle(
                color: Color(0xFF196319),
                fontSize: Constant.HeadingTextSize,
                fontFamily: Constant.font_name,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8, right: 20, left: 20),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Beginn:',
                      style: TextStyle(
                          fontFamily: Constant.font_name,
                          fontSize: Constant.subHeadingTextSize,
                          color: Colors.black.withOpacity(0.6)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Constant.getDate(context).then((picked) => {
                              setState(() {
                                startDate =
                                    Constant.formatTime(picked.day.toString()) +
                                        "." +
                                        Constant.formatTime(
                                            picked.month.toString()) +
                                        "." +
                                        picked.year.toString();
                              })
                            });

                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          startDate == "" ? 'TT.MM.' : startDate,
                          style: TextStyle(
                              fontFamily: Constant.font_name,
                              fontSize: Constant.subHeadingTextSize,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Ende:',
                      style: TextStyle(
                          fontFamily: Constant.font_name,
                          fontSize: Constant.subHeadingTextSize,
                          color: Colors.black.withOpacity(0.6)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Constant.getDate(context).then((picked) => {
                              setState(() {
                                endDate =
                                    Constant.formatTime(picked.day.toString()) +
                                        "." +
                                        Constant.formatTime(
                                            picked.month.toString()) +
                                        "." +
                                        picked.year.toString();
                              })
                            });

                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          endDate == "" ? 'TT.MM.' : endDate,
                          style: TextStyle(
                              fontFamily: Constant.font_name,
                              fontSize: Constant.subHeadingTextSize,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 25),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Uhrzeit der Einnahme",
              style: TextStyle(
                color: Color(0xFF196319),
                fontSize: Constant.HeadingTextSize,
                fontFamily: Constant.font_name,
              ),
            ),
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
                        setState(() {
                          time = Constant.formatTime(picked.hour.toString()) +
                              ":" +
                              Constant.formatTime(picked.minute.toString());
                        })
                      });
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      time == '' ? "Zeit auswählen" : time,
                      style: TextStyle(
                          fontFamily: Constant.font_name,
                          fontSize: Constant.subHeadingTextSize),
                    )),
              )
            ],
          ),
        ),
        ListView.builder(
          itemCount: timeList == null ? 0 : timeList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('assets/clock.png'),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        timeList[index],
                        style: TextStyle(
                            fontFamily: Constant.font_name,
                            fontSize: Constant.subHeadingTextSize),
                      ))
                ],
              ),
            );
          },
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Row(
            children: [
              Image(
                image: AssetImage('assets/add.png'),
              ),
              GestureDetector(
                onTap: () {
                  Constant.getTime(context).then((picked) => {
                        setState(() {
                          timeList.add(Constant.formatTime(
                                  picked.hour.toString()) +
                              ":" +
                              Constant.formatTime(picked.minute.toString()));
                        })
                      });
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Weitere Uhrzeit',
                      style: TextStyle(
                          fontFamily: Constant.font_name,
                          fontSize: Constant.subHeadingTextSize),
                    )),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 20, right: 20),
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
                  value: isSwitched,
                  onChanged: (value) {
                    if (!value) {
                      medikamenteAlarmTimeName = "";
                      medikamenteAlarmTime = "";
                    }
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
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
          visible: isSwitched,
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
                              medikamenteAlarmTimeName = name;
                              medikamenteAlarmTime = time;
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
                    medikamenteAlarmTimeName == ""
                        ? "Wählen Sie die Alarmzeit"
                        : medikamenteAlarmTimeName,
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
            save();
          },
          child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(left: 30, right: 30, top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF196319),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                'Medikament speichern',
                style: TextStyle(
                  fontFamily: Constant.font_name,
                  color: Colors.white,
                  fontSize: 18,
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
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          list[index].startDate + " - " + list[index].endDate,
                          style: TextStyle(
                              fontFamily: Constant.font_name,
                              fontSize: Constant.subHeadingTextSize),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    list[index].time,
                                    style: TextStyle(
                                        fontFamily: Constant.font_name,
                                        fontSize: Constant.subHeadingTextSize),
                                  ),
                                ),
                                ListView.builder(
                                  itemCount: list[index].timeList == null
                                      ? 0
                                      : list[index].timeList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, timeIndex) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        list[index].timeList[timeIndex],
                                        style: TextStyle(
                                            fontSize:
                                                Constant.subHeadingTextSize,
                                            fontFamily: Constant.font_name),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: Image(
                                          image: AssetImage(list[index]
                                              .typeOfExpenditureImage),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          list[index].drugController,
                                          style: TextStyle(
                                              fontFamily: Constant.font_name,
                                              fontSize:
                                                  Constant.subHeadingTextSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          list[index].dosageController,
                                          style: TextStyle(
                                              fontFamily: Constant.font_name,
                                              fontSize:
                                                  Constant.subHeadingTextSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ));
          },
        ),
      ],
    );
  }

  void save() {
    if (startDate == "") {
      showMessage("Startdatum auswählen");
      return;
    }
    if (endDate == "") {
      showMessage("Enddatum auswählen");
      return;
    }
    if (time == "") {
      showMessage("Zeit auswählen");
      return;
    }

    if (isSwitched && medikamenteAlarmTimeName == "") {
      showMessage("Wählen Sie die Alarmzeit");
      return;
    }

    DateTime alarmDateTime =
        Constant.convertDateTimeStringToDate(startDate, time);
    if (medikamenteAlarmTime != "")
      alarmDateTime = alarmDateTime
          .subtract(Duration(minutes: int.parse(medikamenteAlarmTime)));

    String s = "";
    for (int i = 0; i < timeList.length; i++) {
      if (i == timeList.length - 1) {
        s = s + timeList[i];
      } else {
        s = s + timeList[i] + ",";
      }
      if (isSwitched) {}
    }

    MedikamenteData data = new MedikamenteData();
    data.drugController = drugController.text;
    data.dosageController = dosageController.text;
    data.typeOfExpenditureText = selected.name;
    data.typeOfExpenditureImage = selected.image.assetName;
    data.startDate = startDate;
    data.endDate = endDate;
    data.time = time;
    data.alarmTime = alarmDateTime.toString();

    data.otherTime = s;
    data.cycleNumber = widget.cycleNumber;
    data.isChecked = isSwitched ? 1 : 0;
    if (data.isChecked == 1) {
      data.notificationId = DateTime.now().millisecondsSinceEpoch;
    }

    CustomDB.instance.addMedikaments(data).then((value) => {
          data.id = value,
          data.timeList = data.otherTime.split(","),
          list.add(data),
          drugController.text = "",
          dosageController.text = "",
          startDate = "",
          endDate = "",
          timeList.clear(),
          time = "",
          isSwitched = false,
          if (data.isChecked == 1)
            {
              notificationManager.scheduleAlarm(data.notificationId,
                  data.drugController, data.time, alarmDateTime),
              setOtherAlarm(data),
            },
          for (int i = 0; i < image.length; i++)
            {
              image[i].isChecked = false,
            },
          setState(() {})
        });
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  setOtherAlarm(MedikamenteData data) {
    for (int i = 0; i < data.timeList.length; i++) {
      TimeData timeData = TimeData();
      timeData.time = data.timeList[i];
      timeData.notificationId = DateTime.now().millisecondsSinceEpoch;
      timeData.medikamentsId = data.id;

      CustomDB.instance.addTimeData(timeData);

      DateTime alarmDateTime =
      Constant.convertDateTimeStringToDate(startDate, timeData.time);

      notificationManager.scheduleAlarm(timeData.notificationId, data.drugController, timeData.time, alarmDateTime);
    }
  }
}
