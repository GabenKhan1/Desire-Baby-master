import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/thirdpage/model/Treatments.dart';
import 'package:custom_app/thirdpage/model/cycle_period.dart';
import 'package:custom_app/thirdpage/model/investigation.dart';
import 'package:custom_app/thirdpage/model/medikamente.dart';
import 'package:flutter/material.dart';

import 'edit.dart';

class AktuellerRoute extends StatefulWidget {
  int cycleNumber;
  final Function onChangeFunction;

  AktuellerRoute(this.cycleNumber, this.onChangeFunction);

  @override
  _AktuellerRouteState createState() => _AktuellerRouteState();
}

class _AktuellerRouteState extends State<AktuellerRoute> {
  double topMargin = 10;

  CyclePeriodData cyclePeriod;
  List<InvestigationsData> investigationList;
  List<Treatments> treatmentList;
  List<MedikamenteData> medikamentList;

  // List<String> timeList = [];

  // bool isEdit = false;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              widget.cycleNumber == -1 ? "Aktueller Zyklus" : "Archiv",
              style: TextStyle(color: Color(Constant.toolbar_text_color)),
            ),
            actions: <Widget>[
              Visibility(
                visible: cyclePeriod != null,
                child: IconButton(
                  icon: Image(
                    image: AssetImage('assets/edit.png'),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit(
                                  cyclePeriod: cyclePeriod,
                                  investigationList: investigationList,
                                  treatmentList: treatmentList,
                                  medikamentList: medikamentList,
                                ))).then((value) => {loadData()});
                  },
                ),
              ),
              Visibility(
                visible: cyclePeriod != null,
                child: IconButton(
                  icon: Image(
                    image: AssetImage('assets/delete.png'),
                  ),
                  onPressed: () {
                    if (cyclePeriod != null) showAlertDialog(context);
                  },
                ),
              ),
            ],
            backgroundColor: Color(Constant.toolbar_color),
            iconTheme: IconThemeData(
              color:
                  Color(Constant.toolbar_text_color), //change your color here
            )),
        body: Stack(
          children: [
            (cyclePeriod == null)
                ? Center(
                    child: Text(
                    "Fügen Sie zuerst einen neuen Zyklus hinzu",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 25, fontFamily: Constant.font_name),
                  ))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              right: 20, left: 20, top: topMargin),
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
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        cyclePeriod.startDate,
                                        style: TextStyle(
                                            fontFamily: Constant.font_name,
                                            fontSize: 16,
                                            color: Colors.black),
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
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        cyclePeriod.endDate,
                                        style: TextStyle(
                                            fontFamily: Constant.font_name,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: topMargin),
                          child: Divider(
                            thickness: 2,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 20, left: 20, top: topMargin),
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
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              cyclePeriod.typeOfTreatment,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Constant.subHeadingTextSize,
                                fontFamily: Constant.font_name,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: topMargin),
                          child: Divider(
                            thickness: 2,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: topMargin, right: 20, left: 20),
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
                        ListView.builder(
                          itemCount: investigationList == null
                              ? 0
                              : investigationList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  top: topMargin, right: 20, left: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              investigationList[index].date,
                                              style: TextStyle(
                                                  fontFamily:
                                                      Constant.font_name,
                                                  fontSize: Constant
                                                      .subHeadingTextSize),
                                            )),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                investigationList[index].time,
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constant.font_name,
                                                    fontSize: Constant
                                                        .subHeadingTextSize))),
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
                                                investigationList[index]
                                                    .investigations,
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constant.font_name,
                                                    fontSize: Constant
                                                        .subHeadingTextSize))),
                                        Visibility(
                                          visible:
                                              investigationList[index].text !=
                                                  "",
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  child: Image(
                                                    image: AssetImage(
                                                        'assets/tick_2.png'),
                                                  )),
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      investigationList[index]
                                                          .text,
                                                      style: TextStyle(
                                                          fontFamily: Constant
                                                              .font_name,
                                                          fontSize: Constant
                                                              .subHeadingTextSize))),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: topMargin),
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
                        ListView.builder(
                          itemCount:
                              treatmentList == null ? 0 : treatmentList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  top: topMargin, right: 20, left: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              treatmentList[index].date,
                                              style: TextStyle(
                                                  fontFamily:
                                                      Constant.font_name,
                                                  fontSize: Constant
                                                      .subHeadingTextSize),
                                            )),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                treatmentList[index].time,
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constant.font_name,
                                                    fontSize: Constant
                                                        .subHeadingTextSize))),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(treatmentList[index].text,
                                            style: TextStyle(
                                                fontFamily: Constant.font_name,
                                                fontSize: Constant
                                                    .subHeadingTextSize))),
                                  ),
                                  /* Expanded(
                                    flex: 2,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(treatmentList[index].treatment,
                                            style: TextStyle(
                                                fontFamily:
                                                    Constant.font_name,
                                                fontSize: Constant
                                                    .subHeadingTextSize))),
                                  ),*/
                                ],
                              ),
                            );
                          },
                        ),
                        Container(
                          margin: EdgeInsets.only(top: topMargin),
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
                              "Medikamente",
                              style: TextStyle(
                                color: Color(0xFF196319),
                                fontSize: Constant.HeadingTextSize,
                                fontFamily: Constant.font_name,
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: medikamentList == null
                              ? 0
                              : medikamentList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.only(
                                    top: topMargin, right: 20, left: 20),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          medikamentList[index].startDate +
                                              " - " +
                                              medikamentList[index].endDate,
                                          style: TextStyle(
                                              fontFamily: Constant.font_name,
                                              fontSize:
                                                  Constant.subHeadingTextSize),
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
                                                    medikamentList[index].time,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            Constant.font_name,
                                                        fontSize: Constant
                                                            .subHeadingTextSize),
                                                  ),
                                                ),
                                                ListView.builder(
                                                  itemCount: medikamentList[
                                                                  index]
                                                              .timeList ==
                                                          null
                                                      ? 0
                                                      : medikamentList[index]
                                                          .timeList
                                                          .length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, timeIndex) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        medikamentList[index]
                                                                .timeList[
                                                            timeIndex],
                                                        style: TextStyle(
                                                            fontFamily: Constant
                                                                .font_name),
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
                                                          image: AssetImage(
                                                              medikamentList[
                                                                      index]
                                                                  .typeOfExpenditureImage),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5),
                                                        child: Text(
                                                          medikamentList[index]
                                                              .drugController,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  Constant
                                                                      .font_name,
                                                              fontSize: Constant
                                                                  .subHeadingTextSize),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5),
                                                        child: Text(
                                                          medikamentList[index]
                                                              .dosageController,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  Constant
                                                                      .font_name,
                                                              fontSize: Constant
                                                                  .subHeadingTextSize),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                        ),
                      ],
                    ),
                  ),
          ],
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("Löschen"),
      onPressed: () {
        CustomDB.instance.deleteCyclePeriod(cyclePeriod.cycleNumber);
        CustomDB.instance.deleteInvestigation(cyclePeriod.cycleNumber);
        CustomDB.instance.deleteTreatment(cyclePeriod.cycleNumber);
        CustomDB.instance.deleteMedikaments(cyclePeriod.cycleNumber);

        cyclePeriod = null;
        investigationList = [];
        treatmentList = [];
        medikamentList = [];
        Navigator.pop(context);
        if (widget.cycleNumber != -1) {
          Navigator.pop(context);
        } else {
          setState(() {});
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Löschen"),
      content:
          Text("Sind Sie sicher, dass Sie die Zyklusperiode löschen möchten??"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  void loadData() {
    if (widget.cycleNumber == -1) {
      CustomDB.instance.getCyclePeriod().then((value) => {
            setState(() {
              if (value != null && value.length > 0) {
                cyclePeriod = value[value.length - 1];

                CustomDB.instance
                    .getInvestigation(cyclePeriod.cycleNumber)
                    .then((value) => {
                          setState(() {
                            investigationList = value;
                          })
                        });

                CustomDB.instance
                    .getTreatment(cyclePeriod.cycleNumber)
                    .then((value) => {
                          if (value.length > 0)
                            {
                              setState(() {
                                treatmentList = value;
                              })
                            }
                        });

                CustomDB.instance
                    .getMedikaments(cyclePeriod.cycleNumber)
                    .then((value) => {
                          if (value.length > 0)
                            {
                              medikamentList = value,
                              for (int i = 0; i < medikamentList.length; i++)
                                {
                                  medikamentList[i].timeList =
                                      medikamentList[i].otherTime.split(","),
                                },
                              setState(() {})
                            }
                        });
              }
            })
          });
    } else {
      CustomDB.instance.getSingleCyclePeriod(widget.cycleNumber).then((value) =>
          {
            setState(() {
              if (value != null && value.length > 0) {
                cyclePeriod = value[value.length - 1];

                print(cyclePeriod.cycleNumber);

                CustomDB.instance
                    .getInvestigation(widget.cycleNumber)
                    .then((value) => {
                          setState(() {
                            investigationList = value;
                          })
                        });

                CustomDB.instance
                    .getTreatment(widget.cycleNumber)
                    .then((value) => {
                          if (value.length > 0)
                            {
                              setState(() {
                                treatmentList = value;
                              })
                            }
                        });

                CustomDB.instance
                    .getMedikaments(widget.cycleNumber)
                    .then((value) => {
                          if (value.length > 0)
                            {
                              medikamentList = value,
                              for (int i = 0; i < medikamentList.length; i++)
                                {
                                  medikamentList[i].timeList =
                                      medikamentList[i].otherTime.split(","),
                                },
                              setState(() {})
                            }
                        });
              }
            })
          });
    }
  }
}
