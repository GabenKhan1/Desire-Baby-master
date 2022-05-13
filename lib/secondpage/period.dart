// ignore_for_file: non_constant_identifier_names

import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/secondpage/customchart/TempChart.dart';
import 'package:custom_app/secondpage/customchart/WeightChart.dart';
import 'package:custom_app/secondpage/edit_period.dart';
import 'package:custom_app/thirdpage/model/image_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/peroid_data.dart';
import 'model/peroid_day.dart';

class Period extends StatefulWidget {
  final Function() refreshList;
  List<PeriodDay> periodDayList;
  final OnPeriodSelected onPeriodSelected;
  List<PeriodData> list;
  bool isShowOvulationText;
  final DateTime selectedDate;

  Period(
      {Key key,
      this.onPeriodSelected,
      this.list,
      this.isShowOvulationText,
      this.refreshList,
      this.selectedDate})
      : super(key: key);

  @override
  _PeriodState createState() => _PeriodState();
}

class _PeriodState extends State<Period> {
  static int PERIOD = 1;
  int SEX = 2;
  int DISCHARGE = 3;
  int MOOD = 4;
  int PREGNANCY = 5;
  int WEIGHT = 6;
  int TEMP = 7;
  int SYMPTOMS = 8;
  int OVULATION = 9;

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  TextEditingController weightControler = TextEditingController();
  TextEditingController tempControler = TextEditingController();

  int ovulationSelectedIndex = -1;

  //type 1
  List<ImageData> periodList = [
    new ImageData("Leicht", false, AssetImage('assets/p_1.png')),
    new ImageData("Mittel", false, AssetImage('assets/p_2.png')),
    new ImageData("Stark", false, AssetImage('assets/p_3.png')),
  ];

  //type 2
  List<ImageData> sexList = [
    new ImageData("Geschützt", false, AssetImage('assets/s_1.png')),
    new ImageData("Ungeschützt", false, AssetImage('assets/s_2.png')),
  ];

  //type 3
  List<ImageData> dischargeList = [
    new ImageData("Schmier-\nblutung", false, AssetImage('assets/d_1.png')),
    new ImageData("Klebrig", false, AssetImage('assets/d_2.png')),
    new ImageData("Cremig", false, AssetImage('assets/d_3.png')),
    new ImageData("Eiweißartig", false, AssetImage('assets/d_4.png')),
    new ImageData("Wässrig", false, AssetImage('assets/d_5.png')),
  ];

  //type 4
  List<ImageData> moodList = [
    new ImageData("Glücklich", false, AssetImage('assets/m_4.png')),
    new ImageData("Deprimiert", false, AssetImage('assets/m_1.png')),
    new ImageData("Entspannt", false, AssetImage('assets/m_2.png')),
    new ImageData("Gereizt", false, AssetImage('assets/m_3.png')),
    new ImageData("Traurig", false, AssetImage('assets/m_6.png')),
    new ImageData(
        "Stimmungs-\nschwankungen", false, AssetImage('assets/m_5.png')),
  ];

  //type 8
  List<ImageData> symptoms = [
    new ImageData("Empfindliche\nBrüste", false, AssetImage('assets/sy_1.png')),
    new ImageData(
        "Unterleibs-\nschmerzen", false, AssetImage('assets/sy_4.png')),
    new ImageData("Kopfschmerzen", false, AssetImage('assets/sy_3.png')),
    new ImageData("Rücken-\nschmerzen", false, AssetImage('assets/sy_2.png')),
    new ImageData("Heißhunger", false, AssetImage('assets/sy_5.png')),
    new ImageData("Übelkeit", false, AssetImage('assets/sy_6.png')),
    new ImageData("Erbrechen", false, AssetImage('assets/sy_7.png')),
    new ImageData("Hautunrein-\nheiten", false, AssetImage('assets/sy_8.png')),
    new ImageData("Müdigkeit", false, AssetImage('assets/sy_9.png')),
    new ImageData("Schlaflosigkeit", false, AssetImage('assets/sy_10.png')),
    new ImageData("Verstopfung", false, AssetImage('assets/sy_11.png')),
    new ImageData("Durchfall", false, AssetImage('assets/sy_12.png')),
    new ImageData("Blähungen", false, AssetImage('assets/sy_13.png')),
  ];

  // type 9
  List<ImageData> ovulationList = [
    new ImageData("Positiv", false, AssetImage('assets/o_1.png')),
    new ImageData("Negativ", false, AssetImage('assets/o_2.png')),
    new ImageData("Eigene\nMethode", false, AssetImage('assets/o_3.png')),
  ];

  //type 5
  List<ImageData> pregnancyList = [
    new ImageData("Positiv", false, AssetImage('assets/pt_1.png')),
    new ImageData("Negativ", false, AssetImage('assets/pt_2.png')),
    new ImageData("Blasse Linie", false, AssetImage('assets/pt_3.png')),
  ];

  double imageSize = 60;

  @override
  void initState() {
    super.initState();

    CustomDB.instance.getPeriodDay().then((value) => {
          widget.periodDayList = (value),
        });

    if (widget.list != null) {
      for (int i = 0; i < widget.list.length; i++) {
        if (widget.list[i].type == PERIOD)
          findIndex(periodList, widget.list[i].text);
        if (widget.list[i].type == SEX) findIndex(sexList, widget.list[i].text);
        if (widget.list[i].type == DISCHARGE)
          findIndex(dischargeList, widget.list[i].text);
        if (widget.list[i].type == MOOD)
          findIndex(moodList, widget.list[i].text);
        if (widget.list[i].type == SYMPTOMS)
          findIndex(symptoms, widget.list[i].text);
        if (widget.list[i].type == PREGNANCY)
          findIndex(pregnancyList, widget.list[i].text);
        if (widget.list[i].type == OVULATION)
          findIndex(ovulationList, widget.list[i].text);

        if (widget.list[i].type == WEIGHT) {
          weightControler.text =
              widget.list[i].value.replaceAll(Constant.weightPostFix, "");
        }

        if (widget.list[i].type == TEMP) {
          tempControler.text =
              widget.list[i].value.replaceAll(Constant.tempPostFix, "");
        }
      }
    }

    prepareListForChart();
  }

  findIndex(List<ImageData> list, String text) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].name == text) {
        list[i].isChecked = true;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constant.bg_color,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Periode",
                          style: TextStyle(
                              fontFamily: Constant.font_name,
                              fontSize: 17,
                              color: Color(0xFF196319)),
                        )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditPeriod(widget
                                        .periodDayList))).then((value) => {
                                  if (value != null && value)
                                    widget.refreshList(),
                                  CustomDB.instance
                                      .getPeriodDay()
                                      .then((value) => {
                                            if (widget.periodDayList == null)
                                              {
                                                widget.periodDayList = [],
                                              }
                                            else
                                              {
                                                widget.periodDayList.clear(),
                                              },
                                            widget.periodDayList.addAll(value),
                                          })
                                });
                          },
                          child: Text(
                            "Bearbeiten",
                            style: TextStyle(
                                fontFamily: Constant.font_name,
                                fontSize: 17,
                                color: Color(0xFF196319)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: imageSize + 50,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: ListView.builder(
                        itemCount: periodList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (periodList[index].isChecked) {
                                periodList[index].isChecked = false;
                              } else {
                                for (int i = 0; i < periodList.length; i++) {
                                  periodList[i].isChecked = false;
                                }
                                periodList[index].isChecked = true;
                              }

                              setState(() {});
                            },
                            child: SingleItem(
                                imageData: periodList[index],
                                isShowCircle: true),
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  HeadingText("Sex"),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: imageSize + 50,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: ListView.builder(
                        itemCount: sexList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (sexList[index].isChecked) {
                                  sexList[index].isChecked = false;
                                } else {
                                  for (int i = 0; i < sexList.length; i++) {
                                    sexList[i].isChecked = false;
                                  }
                                  sexList[index].isChecked = true;
                                }

                                setState(() {});
                              },
                              child: SingleItem(
                                  imageData: sexList[index],
                                  isShowCircle: true));
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  HeadingText("Scheidenausfluss"),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: imageSize + 62,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: ListView.builder(
                        itemCount: dischargeList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (dischargeList[index].isChecked) {
                                  dischargeList[index].isChecked = false;
                                } else {
                                  for (int i = 0;
                                      i < dischargeList.length;
                                      i++) {
                                    dischargeList[i].isChecked = false;
                                  }
                                  dischargeList[index].isChecked = true;
                                }

                                setState(() {});
                              },
                              child: SingleItem(
                                  imageData: dischargeList[index],
                                  isShowCircle: true));
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  HeadingText("Stimmung"),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: imageSize + 62,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: ListView.builder(
                        itemCount: moodList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (moodList[index].isChecked) {
                                  moodList[index].isChecked = false;
                                } else {
                                  for (int i = 0; i < moodList.length; i++) {
                                    moodList[i].isChecked = false;
                                  }
                                  moodList[index].isChecked = true;
                                }

                                setState(() {});
                              },
                              child: SingleItem(
                                imageData: moodList[index],
                                isShowCircle: false,
                              ));
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  HeadingText("Symptome"),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: imageSize + 63,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: ListView.builder(
                        itemCount: symptoms.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (symptoms[index].isChecked) {
                                  symptoms[index].isChecked = false;
                                } else {
                                  for (int i = 0; i < symptoms.length; i++) {
                                    symptoms[i].isChecked = false;
                                  }
                                  symptoms[index].isChecked = true;
                                }

                                setState(() {});
                              },
                              child: SingleItem(
                                imageData: symptoms[index],
                                isShowCircle: false,
                              ));
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  HeadingText("Eisprung"),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: imageSize + 63,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: ListView.builder(
                        itemCount: ovulationList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (ovulationList[index].isChecked) {
                                  ovulationList[index].isChecked = false;
                                  ovulationSelectedIndex = -1;
                                } else {
                                  for (int i = 0;
                                      i < ovulationList.length;
                                      i++) {
                                    ovulationList[i].isChecked = false;
                                  }
                                  ovulationList[index].isChecked = true;
                                  ovulationSelectedIndex = index;
                                }

                                setState(() {});
                              },
                              child: SingleItem(
                                  imageData: ovulationList[index],
                                  isShowCircle: true));
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  HeadingText("Schwangerschaftstest"),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: imageSize + 50,
                      margin: EdgeInsets.only(right: 10, left: 10),
                      child: ListView.builder(
                        itemCount: pregnancyList.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                if (pregnancyList[index].isChecked) {
                                  pregnancyList[index].isChecked = false;
                                } else {
                                  for (int i = 0;
                                      i < pregnancyList.length;
                                      i++) {
                                    pregnancyList[i].isChecked = false;
                                  }
                                  pregnancyList[index].isChecked = true;
                                }

                                ovulationSelectedIndex = index;

                                setState(() {});
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10, top: 15),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: imageSize,
                                        height: imageSize,
                                        child: Container(
                                            width: imageSize,
                                            height: imageSize,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    width: 3,
                                                    color: pregnancyList[index]
                                                            .isChecked
                                                        ? Color(0xFF196319)
                                                        : Colors.transparent)),
                                            child: Center(
                                              child: Image(
                                                width: imageSize,
                                                height: imageSize,
                                                image:
                                                    pregnancyList[index].image,
                                              ),
                                            ))),
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          pregnancyList[index].name,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: Constant.font_name,
                                              color:
                                                  pregnancyList[index].isChecked
                                                      ? Color(0xFF196319)
                                                      : Colors.black),
                                        ))
                                  ],
                                ),
                              ));
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.black.withOpacity(0.2),
                  ),
                  Visibility(visible: false, child: HeadingText("Gewicht")),
                  Visibility(
                    visible: false,
                    child: Container(
                      margin: EdgeInsets.only(left: 15, top: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TimeChart(getDataForChart(weightDataList),"Weight")));*/

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WeightChart(
                                            weightDataList: weightDataList,
                                          )));
                            },
                            child: Image(
                              image: AssetImage('assets/weight.png'),
                              width: imageSize,
                              height: imageSize,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style:
                                    TextStyle(fontFamily: Constant.font_name),
                                controller: weightControler,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 2),
                                    hintText: ''),
                              ),
                            ),
                          ),
                          Text(
                            Constant.weightPostFix,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: Constant.font_name,
                                fontSize: 15),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  /*Divider(
                    thickness: 2,
                    color: Colors.black.withOpacity(0.2),
                  ),*/
                  HeadingText("Basaltemperatur"),
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TempChart(
                                          tempDataList: tempDataList,
                                        )));
                          },
                          child: Image(
                            image: AssetImage('assets/temperature.png'),
                            width: imageSize,
                            height: imageSize,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontFamily: Constant.font_name),
                              controller: tempControler,
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 2),
                                  hintText: ''),
                            ),
                          ),
                        ),
                        Text(
                          Constant.tempPostFix,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: Constant.font_name,
                              fontSize: 15),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // DateTime selectedDate = DateTime.now();
              String date = Constant.covertDateToString(widget.selectedDate);

              save(periodList, date, PERIOD, widget.list);
              save(sexList, date, SEX, widget.list);
              save(dischargeList, date, DISCHARGE, widget.list);
              save(moodList, date, MOOD, widget.list);
              save(pregnancyList, date, PREGNANCY, widget.list);
              save(symptoms, date, SYMPTOMS, widget.list);
              save(
                  ovulationList,
                  Constant.covertDateToString(
                      widget.selectedDate.add(Duration(days: 1))),
                  OVULATION,
                  widget.list);

              //save weight into db
              if (weightControler.text != "") {
                PeriodData p = new PeriodData();

                CustomDB.instance
                    .getPeriodDataWithType(date, WEIGHT)
                    .then((value) => {
                          if (value == null || value.length == 0)
                            {
                              p.text = 'weight',
                              p.imageName =
                                  AssetImage('assets/weight.png').assetName,
                              p.date = date,
                              p.type = WEIGHT,
                              p.value = weightControler.text + " kg",
                              CustomDB.instance.addPeriodData(p),
                            }
                        });
              }

              //save temp into db
              if (tempControler.text != "") {
                PeriodData p = new PeriodData();

                CustomDB.instance
                    .getPeriodDataWithType(date, TEMP)
                    .then((value) => {
                          p.text = 'temprature',
                          p.imageName =
                              AssetImage('assets/temperature.png').assetName,
                          p.date = date,
                          p.type = 7,
                          p.value = tempControler.text + Constant.tempPostFix,
                          if (value == null || value.length == 0)
                            {
                              CustomDB.instance.addPeriodData(p),
                            }
                          else
                            {
                              CustomDB.instance
                                  .deletePeriodDataWithID(value[0].id)
                                  .then((value) => {
                                        CustomDB.instance.addPeriodData(p),
                                      }),
                            }
                        });
              } else {
                CustomDB.instance
                    .getPeriodDataWithType(date, TEMP)
                    .then((value) => {
                          if (value != null || value.length > 0)
                            {
                              CustomDB.instance
                                  .deletePeriodDataWithID(value[0].id),
                            }
                        });
              }

              reset(periodList);
              reset(sexList);
              reset(dischargeList);
              reset(moodList);
              reset(ovulationList);
              reset(pregnancyList);
              reset(symptoms);

              new Future.delayed(Duration(seconds: 1), () {
                if (widget.onPeriodSelected != null) {
                  widget.onPeriodSelected(null);
                }
              });
            },
            child: Container(
                padding: EdgeInsets.all(12),
                margin:
                    EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xFF196319),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  'Speichern',
                  style: TextStyle(
                    fontFamily: Constant.font_name,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
        ],
      ),
    );
  }

  void deleteIfUserUnSelect(List<ImageData> list) {
    for (int i = 0; i < list.length; i++) {}
  }

  List<PeriodData> tempDataList = [];
  List<PeriodData> weightDataList = [];

  prepareListForChart() {
    CustomDB.instance.getDataForChart(WEIGHT).then((value) => {
          if (value != null)
            {
              weightDataList.addAll(value),
            }
        });

    CustomDB.instance.getDataForChart(TEMP).then((value) => {
          if (value != null)
            {
              tempDataList.addAll(value),
            }
        });
  }
}

reset(List<ImageData> list) {
  for (int i = 0; i < list.length; i++) {
    list[i].isChecked = false;
  }
}

save(List<ImageData> list, String date, int type, List<PeriodData> pData) {
  //delete already selected data if user un select it
  if (pData != null) {
    for (int j = 0; j < pData.length; j++) {
      if (pData[j].type == type) {
        for (int i = 0; i < list.length; i++) {
          if (pData[j].text == list[i].name) {
            if (!list[i].isChecked) {
              CustomDB.instance.deletePeriodDataWithID(pData[j].id);
              break;
            }
          }
        }
      }
    }
  }

  for (int i = 0; i < list.length; i++) {
    if (list[i].isChecked) {
      // list[i].name
      PeriodData p = new PeriodData();
      CustomDB.instance.getPeriodDataWithType(date, type).then((value) => {
            if (value == null || value.length == 0)
              {
                p.text = list[i].name,
                p.imageName = list[i].image.assetName,
                p.date = date,
                p.type = type,
                CustomDB.instance.addPeriodData(p),
              }
          });

      break;
    }
  }
}

class HeadingText extends StatelessWidget {
  final String text;

  HeadingText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
              fontFamily: Constant.font_name,
              fontSize: 19,
              color: Color(0xFF196319)),
        ),
      ),
    );
  }
}

class SingleItem extends StatelessWidget {
  final ImageData imageData;

  double imageSize = 65;
  bool isShowCircle = true;

  SingleItem({Key key, this.imageData, this.isShowCircle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 15),
      child: Column(
        children: [
          SizedBox(
              width: imageSize,
              height: imageSize,
              child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 3,
                          color: imageData.isChecked
                              ? Color(0xFF196319)
                              : Colors.transparent)),
                  child: Stack(
                    children: [
                      Center(
                        child: Image(
                          image: imageData.image,
                        ),
                      ),
                    ],
                  ))),
          Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                imageData.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: Constant.font_name,
                    color:
                        imageData.isChecked ? Color(0xFF196319) : Colors.black),
              ))
        ],
      ),
    );
  }
}

typedef OnPeriodSelected = void Function(List<PeriodDay> periodList);
