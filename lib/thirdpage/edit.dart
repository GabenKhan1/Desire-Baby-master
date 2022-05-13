import 'package:custom_app/alaramTimeDialog/CustomDialogBox.dart';
import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:flutter/material.dart';

import '../NotificationManager.dart';
import 'model/Treatments.dart';
import 'model/cycle_period.dart';
import 'model/image_data.dart';
import 'model/investigation.dart';
import 'model/medikamente.dart';
import 'model/time_list.dart';

class Edit extends StatefulWidget {
  CyclePeriodData cyclePeriod;
  List<InvestigationsData> investigationList;
  List<Treatments> treatmentList;
  List<MedikamenteData> medikamentList;

  Edit(
      {Key key,
      this.cyclePeriod,
      this.investigationList,
      this.treatmentList,
      this.medikamentList})
      : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  double imageSize = 60;

  List<String> typeOfTreatmentSpinnerItems = [
    'Kinderwunschbehandlung auswählen',
    'Intrauterine Insemination ohne hormonelle Stimulation  ',
    'Intrauterine Insemination mit hormoneller Stimulation',
    'In-vitro-Fertilisation',
    'Intrazytoplasmatische Spermieninjektion',
    'Kryo-Behandlung',
    'Geschlechtsverkehr nach Plan'
  ];
  String typeOfTreatmentDropdownValue = 'Kinderwunschbehandlung auswählen';
  TextEditingController treatmentController = TextEditingController();

  String cyclePeriodStartDate = "";

  String cyclePeriodEndDate = "";

  // ===================== Start Investigation ================
  String investigationDropdownValue = 'Untersuchung auswählen';
  String investigationDate = "";
  String investigationTime = "";
  TextEditingController investigationController = TextEditingController();
  bool investigationSwitch = false;

  List<String> investigationSpinnerItems = [
    'Untersuchung auswählen',
    'Ultraschall',
    'Blutabnahme',
    'Biopsie',
    'Eileiterdurchlässigkeitsprüfung',
    'Bauchspiegelung',
    'Gebärmutterspiegelung'
  ];

  String investigationAlarmTime = "";
  String investigationAlarmTimeName = "";

  // ===================== End Investigation ================

  // ===================== Start Treatment ================
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

  // ===================== End Treatment ================

  // ===================== start medikamente ================
  TextEditingController drugController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  List<String> timeList = [];

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

  var time = "";

  int investigationEditId = -1;
  int treatmentEditId = -1;
  int medikamentEditId = -1;

  String medikamenteAlarmTime = "";
  String medikamenteAlarmTimeName = "";

  // ===================== end medikamente ================

  NotificationManager notificationManager;

  InvestigationsData selectedInvestigation;
  Treatments selectedTreatments;
  MedikamenteData selectedMedikamenteData;

  @override
  void initState() {
    super.initState();
    notificationManager = NotificationManager();

    if (widget.cyclePeriod == null) {
      CustomDB.instance.getCyclePeriod().then((value) => {
            setState(() {
              if (value != null && value.length > 0) {
                widget.cyclePeriod = value[value.length - 1];

                cyclePeriodEndDate = widget.cyclePeriod.startDate;
                cyclePeriodStartDate = widget.cyclePeriod.startDate;
                typeOfTreatmentDropdownValue =
                    widget.cyclePeriod.typeOfTreatment;

                CustomDB.instance
                    .getInvestigation(widget.cyclePeriod.cycleNumber)
                    .then((value) => {
                          setState(() {
                            widget.investigationList = value;
                          })
                        });

                CustomDB.instance
                    .getTreatment(widget.cyclePeriod.cycleNumber)
                    .then((value) => {
                          if (value.length > 0)
                            {
                              setState(() {
                                widget.treatmentList = value;
                              })
                            }
                        });

                CustomDB.instance
                    .getMedikaments(widget.cyclePeriod.cycleNumber)
                    .then((value) => {
                          if (value.length > 0)
                            {
                              setState(() {
                                widget.medikamentList = value;
                              })
                            }
                        });
              }
            })
          });
    } else {
      cyclePeriodEndDate = widget.cyclePeriod.startDate;
      cyclePeriodStartDate = widget.cyclePeriod.startDate;
      typeOfTreatmentDropdownValue = widget.cyclePeriod.typeOfTreatment;
    }

    selected = image[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Zyklus bearbeiten",
            style: TextStyle(color: Color(Constant.toolbar_text_color)),
          ),
          actions: <Widget>[
            IconButton(
              icon: Image(
                image: AssetImage('assets/tick_3.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          backgroundColor: Color(Constant.toolbar_color),
          iconTheme: IconThemeData(
            color: Color(Constant.toolbar_text_color), //change your color here
          )),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Zykluszeitraum",
                    style: TextStyle(
                      color: Color(0xFF196319),
                      fontSize: 18,
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
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Constant.getDate(context).then((picked) => {
                                    setState(() {
                                      cyclePeriodStartDate =
                                          Constant.formatTime(
                                                  picked.day.toString()) +
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
                                cyclePeriodStartDate == ""
                                    ? 'TT.MM.:'
                                    : cyclePeriodStartDate,
                                style: TextStyle(
                                    fontFamily: Constant.font_name,
                                    fontSize: 16,
                                    color: Colors.black),
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
                                fontSize: 16,
                                color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Constant.getDate(context).then((picked) => {
                                    setState(() {
                                      cyclePeriodEndDate = Constant.formatTime(
                                              picked.day.toString()) +
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
                                cyclePeriodEndDate == ""
                                    ? 'TT.MM.:'
                                    : cyclePeriodEndDate,
                                style: TextStyle(
                                    fontFamily: Constant.font_name,
                                    fontSize: 16,
                                    color: Colors.black),
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
                margin: EdgeInsets.only(top: 15),
                child: Divider(
                  thickness: 2,
                  color: Colors.black.withOpacity(0.2),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 15, right: 20, left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Art der Behandlung",
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
                    value: typeOfTreatmentDropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 0.0,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 13),
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (String data) {
                      setState(() {
                        typeOfTreatmentDropdownValue = data;
                      });
                    },
                    items: typeOfTreatmentSpinnerItems
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
                margin: EdgeInsets.only(top: 15),
                child: Divider(
                  thickness: 2,
                  color: Colors.black.withOpacity(0.2),
                ),
              ),

              //======== start investigation ================

              Column(
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
                          border:
                              Border.all(color: Color(0XFF196319), width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      child: DropdownButton<String>(
                        value: investigationDropdownValue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 0.0,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 13),
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
                                    investigationDate = Constant.formatTime(
                                            picked.day.toString()) +
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
                                            Constant.formatTime(
                                                picked.minute.toString());
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
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 2),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                ],
              ),
              ListView.builder(
                itemCount: widget.investigationList == null
                    ? 0
                    : widget.investigationList.length,
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
                                    widget.investigationList[index].date,
                                    style: TextStyle(
                                        fontFamily: Constant.font_name,
                                        fontSize: Constant.subHeadingTextSize),
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      widget.investigationList[index].time,
                                      style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          fontSize:
                                              Constant.subHeadingTextSize))),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      widget.investigationList[index]
                                          .investigations,
                                      style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          fontSize:
                                              Constant.subHeadingTextSize))),
                              Visibility(
                                visible:
                                    widget.investigationList[index].text != "",
                                child: Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Image(
                                          image:
                                              AssetImage('assets/tick_2.png'),
                                        )),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            widget
                                                .investigationList[index].text,
                                            style: TextStyle(
                                                fontFamily: Constant.font_name,
                                                fontSize: Constant
                                                    .subHeadingTextSize))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            investigationSwitch =
                                widget.investigationList[index].isChecked == 1
                                    ? true
                                    : false;
                            investigationTime =
                                widget.investigationList[index].time;
                            investigationDate =
                                widget.investigationList[index].date;
                            investigationDropdownValue =
                                widget.investigationList[index].investigations;
                            investigationController.text =
                                widget.investigationList[index].text;
                            investigationEditId =
                                widget.investigationList[index].id;
                            selectedInvestigation =
                                widget.investigationList[index];
                            widget.investigationList.removeAt(index);
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            child: Image(
                              image: AssetImage('assets/edit_1.png'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            CustomDB.instance
                                .deleteInvestigations(
                                    widget.investigationList[index].id)
                                .then((value) => {
                                      CustomDB.instance
                                          .getInvestigation(
                                              widget.cyclePeriod.cycleNumber)
                                          .then((value) => {
                                                widget.investigationList =
                                                    value,
                                                setState(() {})
                                              }),
                                    });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Image(
                              image: AssetImage('assets/delete_1.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              // End Investigation'

              // ==== start Treatment

              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Divider(
                      thickness: 2,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
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
                          border:
                              Border.all(color: Color(0XFF196319), width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      child: DropdownButton<String>(
                        value: treatmentDropdownValue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 0.0,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 13),
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
                                    teatmentDate = Constant.formatTime(
                                            picked.day.toString()) +
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
                              margin: EdgeInsets.only(left: 20),
                              child: Text(
                                teatmentDate == ""
                                    ? 'Datum auswählen'
                                    : teatmentDate,
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
                              teatmentTime = Constant.formatTime(
                                      picked.hour.toString()) +
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
                                teatmentTime == ""
                                    ? 'Zeit auswählen'
                                    : teatmentTime,
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
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 2),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          'Behandlung speichern',
                          style: TextStyle(
                            fontFamily: Constant.font_name,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  ListView.builder(
                    itemCount: widget.treatmentList == null
                        ? 0
                        : widget.treatmentList.length,
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
                                        widget.treatmentList[index].date,
                                        style: TextStyle(
                                            fontFamily: Constant.font_name,
                                            fontSize:
                                                Constant.subHeadingTextSize),
                                      )),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          widget.treatmentList[index].time,
                                          style: TextStyle(
                                              fontFamily: Constant.font_name,
                                              fontSize: Constant
                                                  .subHeadingTextSize))),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(widget.treatmentList[index].text,
                                      style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          fontSize:
                                              Constant.subHeadingTextSize))),
                            ),
                            GestureDetector(
                              onTap: () {
                                treatmentDropdownValue =
                                    widget.treatmentList[index].text;
                                treatmentSwitch =
                                    widget.treatmentList[index].isChecked == 1
                                        ? true
                                        : false;
                                teatmentTime = widget.treatmentList[index].time;
                                teatmentDate = widget.treatmentList[index].date;
                                treatmentController.text =
                                    widget.treatmentList[index].treatment;
                                treatmentEditId =
                                    widget.treatmentList[index].id;
                                selectedTreatments =
                                    widget.treatmentList[index];

                                widget.treatmentList.removeAt(index);

                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Image(
                                  image: AssetImage('assets/edit_1.png'),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                CustomDB.instance
                                    .deleteTreatments(
                                        widget.treatmentList[index].id)
                                    .then((value) => {
                                          CustomDB.instance
                                              .getTreatment(widget
                                                  .cyclePeriod.cycleNumber)
                                              .then((value) => {
                                                    widget.treatmentList =
                                                        value,
                                                    setState(() {})
                                                  }),
                                        });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Image(
                                  image: AssetImage('assets/delete_1.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),

              // ==== end Treatment

              Container(
                margin: EdgeInsets.only(top: 15),
                child: Divider(
                  thickness: 2,
                  color: Colors.black.withOpacity(0.2),
                ),
              ),

              Column(
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
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
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
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 2),
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
                          fontSize: Constant.subHeadingTextSize,
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
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    width: 3,
                                                    color: image[index]
                                                            .isChecked
                                                        ? Color(0xFF196319)
                                                        : Colors.transparent)),
                                            child: Container(
                                              width: imageSize,
                                              height: imageSize,
                                              decoration: new BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              40.0)),
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
                                            fontSize: 15,
                                            fontFamily: Constant.font_name),
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
                          fontSize: Constant.subHeadingTextSize,
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
                                          startDate = Constant.formatTime(
                                                  picked.day.toString()) +
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
                                    startDate == "" ? 'TT.MM.:' : startDate,
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
                                        if (picked != null)
                                          {
                                            setState(() {
                                              endDate = Constant.formatTime(
                                                      picked.day.toString()) +
                                                  "." +
                                                  Constant.formatTime(
                                                      picked.month.toString()) +
                                                  "." +
                                                  picked.year.toString();
                                            })
                                          }
                                      });
                                  FocusScope.of(context).unfocus();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    endDate == "" ? 'TT.MM.:' : endDate,
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
                          fontSize: Constant.subHeadingTextSize,
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
                                    time = Constant.formatTime(
                                            picked.hour.toString()) +
                                        ":" +
                                        Constant.formatTime(
                                            picked.minute.toString());
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
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text(
                                    timeList[index],
                                    style: TextStyle(
                                        fontFamily: Constant.font_name),
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                Constant.getTime(context).then((picked) => {
                                      timeList[index] = Constant.formatTime(
                                              picked.hour.toString()) +
                                          ":" +
                                          Constant.formatTime(
                                              picked.minute.toString()),
                                      setState(() {}),
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Image(
                                  image: AssetImage('assets/edit_1.png'),
                                  width: 15,
                                  height: 15,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  timeList.removeAt(index);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Image(
                                  image: AssetImage('assets/delete_1.png'),
                                  width: 15,
                                  height: 15,
                                ),
                              ),
                            ),
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
                                        Constant.formatTime(
                                            picked.minute.toString()));
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                    itemCount: widget.medikamentList == null
                        ? 0
                        : widget.medikamentList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(top: 10, right: 20, left: 20),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.medikamentList[index].startDate +
                                        " - " +
                                        widget.medikamentList[index].endDate,
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
                                              widget.medikamentList[index].time,
                                              style: TextStyle(
                                                  fontFamily:
                                                      Constant.font_name,
                                                  fontSize: Constant
                                                      .subHeadingTextSize),
                                            ),
                                          ),
                                          ListView.builder(
                                            itemCount: widget
                                                        .medikamentList[index]
                                                        .timeList ==
                                                    null
                                                ? 0
                                                : widget.medikamentList[index]
                                                    .timeList.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, timeIndex) {
                                              return Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  widget.medikamentList[index]
                                                      .timeList[timeIndex],
                                                  style: TextStyle(
                                                      fontFamily:
                                                          Constant.font_name),
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
                                                    image: AssetImage(widget
                                                        .medikamentList[index]
                                                        .typeOfExpenditureImage),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 5),
                                                  child: Text(
                                                    widget.medikamentList[index]
                                                        .drugController,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            Constant.font_name,
                                                        fontSize: Constant
                                                            .subHeadingTextSize),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 5),
                                                  child: Text(
                                                    widget.medikamentList[index]
                                                        .dosageController,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            Constant.font_name,
                                                        fontSize: Constant
                                                            .subHeadingTextSize),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    GestureDetector(
                                      onTap: () {
                                        isSwitched = widget
                                                    .medikamentList[index]
                                                    .isChecked ==
                                                1
                                            ? true
                                            : false;
                                        time =
                                            widget.medikamentList[index].time;
                                        endDate = widget
                                            .medikamentList[index].endDate;
                                        startDate = widget
                                            .medikamentList[index].startDate;
                                        for (int i = 0; i < image.length; i++) {
                                          if (image[i].name ==
                                              widget.medikamentList[index]
                                                  .typeOfExpenditureText) {
                                            image[i].isChecked = true;
                                          } else {
                                            image[i].isChecked = false;
                                          }
                                        }

                                        if (widget.medikamentList[index]
                                                .otherTime !=
                                            "") {
                                          timeList = widget
                                              .medikamentList[index].otherTime
                                              .split(",");
                                        }

                                        selectedMedikamenteData =
                                            widget.medikamentList[index];
                                        dosageController.text = widget
                                            .medikamentList[index]
                                            .dosageController;
                                        drugController.text = widget
                                            .medikamentList[index]
                                            .drugController;
                                        medikamentEditId =
                                            widget.medikamentList[index].id;
                                        widget.medikamentList.removeAt(index);

                                        setState(() {});
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: Image(
                                          image:
                                              AssetImage('assets/edit_1.png'),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        CustomDB.instance
                                            .deleteMedikament(
                                                widget.medikamentList[index].id)
                                            .then((value) => {
                                                  CustomDB.instance
                                                      .getMedikaments(widget
                                                          .cyclePeriod
                                                          .cycleNumber)
                                                      .then((value) => {
                                                            widget.medikamentList =
                                                                value,
                                                            setState(() {})
                                                          }),
                                                });

                                        CustomDB.instance
                                            .getTimeList(
                                                widget.medikamentList[index].id)
                                            .then((value) => {
                                                  if (value != null)
                                                    {
                                                      for (int i = 0;
                                                          i < value.length;
                                                          i++)
                                                        {
                                                          CustomDB.instance
                                                              .deleteOtherTime(
                                                                  value[i].id)
                                                        }
                                                    }
                                                });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Image(
                                          image:
                                              AssetImage('assets/delete_1.png'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ));
                    },
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  // ================ start investigation =============

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
    investigationsData.text = investigationController.text;
    investigationsData.isChecked = investigationSwitch ? 1 : 0;
    investigationsData.cycleNumber = widget.cyclePeriod.cycleNumber;

    if (widget.investigationList == null) {
      widget.investigationList = [];
    }

    if (investigationEditId != -1) {
      //investigation id is  - 1 then update case of investigation

      investigationsData.id = investigationEditId;

      if (investigationsData.isChecked == 0 &&
          selectedInvestigation.notificationId != -1) {
        //if already notification is scheduled,then remove it
        notificationManager
            .removeReminder(selectedInvestigation.notificationId);
      }

      if (investigationsData.isChecked == 1) {
        if (selectedInvestigation.notificationId == -1) {
          investigationsData.notificationId = DateTime.now().millisecond;
        } else {
          investigationsData.notificationId =
              selectedInvestigation.notificationId;
        }
        //schedule notification
        notificationManager.scheduleAlarm(
            investigationsData.notificationId,
            investigationsData.investigations,
            investigationsData.time,
            alarmDateTime);
      }

      CustomDB.instance
          .updateInvestigation(investigationsData)
          .then((value) => {
                investigationDate = "",
                investigationTime = "",
                investigationController.text = "",
                investigationSwitch = false,
                investigationDropdownValue = "Untersuchung auswählen",
                investigationEditId = -1,
                CustomDB.instance
                    .getInvestigation(widget.cyclePeriod.cycleNumber)
                    .then((value) =>
                        {widget.investigationList = value, setState(() {})})
              });

      return;
    }

    // add a new investigation
    if (investigationsData.isChecked == 1) {
      // get notification id first, so that we save in db
      investigationsData.notificationId = DateTime.now().millisecond;
    }

    CustomDB.instance.addInvestigation(investigationsData).then((value) => {
          investigationDate = "",
          investigationTime = "",
          investigationController.text = "",
          investigationSwitch = false,
          investigationDropdownValue = "Untersuchung auswählen",
          investigationsData.id = value,
          widget.investigationList.add(investigationsData),
          if (investigationsData.isChecked == 1)
            {
              notificationManager.scheduleAlarm(
                  investigationsData.notificationId,
                  investigationsData.investigations,
                  investigationsData.time,
                  alarmDateTime),
            },
          setState(() {})
        });
  }

// ================ end investigation =============

// ================ start treatment =============

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
    treatments.treatment = treatmentController.text;
    treatments.isChecked = treatmentSwitch ? 1 : 0;
    treatments.cycleNumber = widget.cyclePeriod.cycleNumber;

    if (widget.treatmentList == null) {
      widget.treatmentList = [];
    }

    if (treatmentEditId != -1) {
      treatments.id = treatmentEditId;

      if (treatments.isChecked == 0 &&
          selectedTreatments.notificationId != -1) {
        //if already notification is scheduled,then remove it
        notificationManager.removeReminder(selectedTreatments.notificationId);
      }
      if (treatments.isChecked == 1) {
        if (selectedTreatments.notificationId == -1) {
          treatments.notificationId = DateTime.now().millisecond;
        } else {
          treatments.notificationId = selectedTreatments.notificationId;
        }
        //schedule notification
        notificationManager.scheduleAlarm(treatments.notificationId,
            treatments.text, treatments.time, alarmDateTime);
      } else {
        treatments.notificationId = -1;
      }

      CustomDB.instance.updateTreatment(treatments).then((value) => {
            treatmentEditId = -1,
            teatmentDate = "",
            teatmentTime = "",
            treatmentController.text = "",
            treatmentSwitch = false,
            treatmentDropdownValue = 'Behandlung auswählen',
            CustomDB.instance
                .getTreatment(widget.cyclePeriod.cycleNumber)
                .then((value) => {
                      widget.treatmentList = value,
                      setState(() {}),
                    }),
          });

      return;
    }

    if (treatments.isChecked == 1) {
      treatments.notificationId = DateTime.now().millisecond;
    }

    CustomDB.instance.addTreatment(treatments).then((value) => {
          treatments.id = value,
          widget.treatmentList.add(treatments),
          teatmentDate = "",
          teatmentTime = "",
          treatmentController.text = "",
          treatmentSwitch = false,
          treatmentDropdownValue = 'Behandlung auswählen',
          if (treatments.isChecked == 1)
            {
              notificationManager.scheduleAlarm(treatments.notificationId,
                  treatments.text, treatments.time, alarmDateTime),
            },
          setState(() {}),
        });
  }

// ================ end treatment =============

// ================ start medikamente =============
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
    data.cycleNumber = widget.cyclePeriod.cycleNumber;
    data.isChecked = isSwitched ? 1 : 0;

    if (widget.medikamentList == null) {
      widget.medikamentList = [];
    }

    // if user edit the detail
    if (medikamentEditId != -1) {
      data.id = medikamentEditId;

      if (data.isChecked == 0 && selectedMedikamenteData.notificationId != -1) {
        //if already notification is scheduled,then remove it
        notificationManager
            .removeReminder(selectedMedikamenteData.notificationId);

        //if already(other time) notification is scheduled,then remove it
        CustomDB.instance.getTimeList(medikamentEditId).then((value) => {
              if (value != null)
                {
                  for (int i = 0; i < value.length; i++)
                    {
                      notificationManager
                          .removeReminder(value[i].notificationId)
                    }
                }
            });
      }

      //add new notification
      if (data.isChecked == 1) {
        if (selectedMedikamenteData.notificationId == -1) {
          data.notificationId = DateTime.now().millisecondsSinceEpoch;
        } else {
          data.notificationId = selectedMedikamenteData.notificationId;
        }
        //schedule notification
        notificationManager.scheduleAlarm(
            data.notificationId, data.drugController, data.time, alarmDateTime);

        //re schedule other time alarm

        DateTime otherAlarmTime;
        CustomDB.instance.getTimeList(medikamentEditId).then((value) => {
              if (value != null)
                {
                  for (int i = 0; i < value.length; i++)
                    {
                      if (value[i].notificationId == -1)
                        {
                          value[i].notificationId =
                              DateTime.now().millisecondsSinceEpoch
                        },
                      otherAlarmTime = Constant.convertDateTimeStringToDate(
                          startDate, value[i].time),
                      if (medikamenteAlarmTime != "")
                        {
                          otherAlarmTime = alarmDateTime.subtract(Duration(
                              minutes: int.parse(medikamenteAlarmTime))),
                        },
                      notificationManager.scheduleAlarm(value[i].notificationId,
                          data.drugController, value[i].time, otherAlarmTime),
                      CustomDB.instance.updateOtherTime(value[i]),
                    }
                }
            });
      } else {
        data.notificationId = -1;

        CustomDB.instance.getTimeList(medikamentEditId).then((value) => {
              if (value != null)
                {
                  for (int i = 0; i < value.length; i++)
                    {
                      value[i].notificationId = -1,
                      CustomDB.instance.updateOtherTime(value[i]),
                    }
                }
            });
      }

      CustomDB.instance.updateMedikamente(data).then((value) => {
            drugController.text = "",
            dosageController.text = "",
            startDate = "",
            endDate = "",
            time = "",
            timeList.clear(),
            isSwitched = false,
            CustomDB.instance
                .getMedikaments(widget.cyclePeriod.cycleNumber)
                .then((data) => {
                      for (int i = 0; i < data.length; i++)
                        {
                          data[i].timeList = data[i].otherTime.split(","),
                        },
                      widget.medikamentList = data,
                      setState(() {}),
                    }),
          });

      return;
    }

    // add a new medikaments
    CustomDB.instance.addMedikaments(data).then((id) => {
          data.id = id,
          data.timeList = data.otherTime.split(","),
          widget.medikamentList.add(data),
          drugController.text = "",
          dosageController.text = "",
          startDate = "",
          endDate = "",
          time = "",
          timeList.clear(),
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

  setOtherAlarm(MedikamenteData data) {
    for (int i = 0; i < data.timeList.length; i++) {
      TimeData timeData = TimeData();
      timeData.time = data.timeList[i];
      timeData.notificationId = DateTime.now().millisecondsSinceEpoch;
      timeData.medikamentsId = data.id;

      CustomDB.instance.addTimeData(timeData);

      DateTime alarmDateTime =
          Constant.convertDateTimeStringToDate(startDate, timeData.time);

      notificationManager.scheduleAlarm(timeData.notificationId,
          data.drugController, timeData.time, alarmDateTime);
    }
  }
}
