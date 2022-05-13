import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/thirdpage/investigations.dart';
import 'package:custom_app/thirdpage/medikamente.dart';
import 'package:custom_app/thirdpage/model/cycle_period.dart';
import 'package:custom_app/thirdpage/treatments.dart';
import 'package:flutter/material.dart';

class NeuerRoute extends StatefulWidget {
  final Function onChangeFunction;

  const NeuerRoute({Key key, this.onChangeFunction}) : super(key: key);

  @override
  _NeuerRouteState createState() => _NeuerRouteState();
}

class _NeuerRouteState extends State<NeuerRoute> {
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

  String cyclePeriodStartDate = "";

  String cyclePeriodEndDate = "";

  int cycleNumber = 1;

  @override
  void initState() {
    super.initState();

    CustomDB.instance.getCyclePeriod().then((value) => {
          if (value != null && value.length > 0)
            {
              cycleNumber = value[value.length - 1].cycleNumber + 1,
            },
          print(cycleNumber),
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        CustomDB.instance.deleteInvestigation(cycleNumber);
        CustomDB.instance.deleteTreatment(cycleNumber);
        CustomDB.instance.deleteMedikaments(cycleNumber);

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Image(
                  image: AssetImage('assets/tick_3.png'),
                ),
                onPressed: () {
                  if (cyclePeriodStartDate == "") {
                    showMessage("Startdatum für Zyklusperiode auswählen");
                    return;
                  }

                  if (cyclePeriodEndDate == "") {
                    showMessage("Wählen Sie das Enddatum des Zykluszeitraums");
                    return;
                  }

                  if (typeOfTreatmentDropdownValue ==
                      "Kinderwunschbehandlung auswählen") {
                    showMessage("Kinderwunschbehandlung auswählen");
                    return;
                  }

                  CyclePeriodData data = new CyclePeriodData();

                  data.startDate = cyclePeriodStartDate;
                  data.endDate = cyclePeriodEndDate;
                  data.typeOfTreatment = typeOfTreatmentDropdownValue;
                  data.cycleNumber = cycleNumber;

                  CustomDB.instance.addCyclePeriod(data).then((value) => {
                        // Navigator.pop(context, true),
                        widget.onChangeFunction(),
                      });
                },
              ),
            ],
            title: Text(
              'Neuer Zyklus',
              style: TextStyle(
                  color: Color(Constant.toolbar_text_color),
                  fontFamily: Constant.font_name),
            ),
            centerTitle: true,
            backgroundColor: Color(Constant.toolbar_color),
            iconTheme: IconThemeData(
              color:
                  Color(Constant.toolbar_text_color), //change your color here
            )),
        body: Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
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
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Constant.getDate(context).then((picked) => {
                                      setState(() {
                                        if (picked != null) {
                                          cyclePeriodStartDate =
                                              Constant.formatTime(
                                                      picked.day.toString()) +
                                                  "." +
                                                  Constant.formatTime(
                                                      picked.month.toString()) +
                                                  "." +
                                                  picked.year.toString();
                                        }
                                      })
                                    });
                                FocusScope.of(context).unfocus();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  cyclePeriodStartDate == ""
                                      ? 'TT.MM.'
                                      : cyclePeriodStartDate,
                                  style: TextStyle(
                                      fontFamily: Constant.font_name,
                                      fontSize: 16,
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
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Constant.getDate(context).then((picked) => {
                                      setState(() {
                                        cyclePeriodEndDate =
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
                                  cyclePeriodEndDate == ""
                                      ? 'TT.MM.'
                                      : cyclePeriodEndDate,
                                  style: TextStyle(
                                      fontFamily: Constant.font_name,
                                      fontSize: 16,
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
                    margin: EdgeInsets.only(top: 5, right: 10, left: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF196319), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: typeOfTreatmentDropdownValue,
                      iconSize: 0.0,
                      elevation: 16,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
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
                Investigations(cycleNumber),
                TreatmentView(cycleNumber),
                Medikamente(cycleNumber)
              ],
            ),
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
}
