import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/firstpage/customWigit/MenuHeadingText.dart';
import 'package:custom_app/firstpage/desire_child.dart';
import 'package:custom_app/firstpage/everything%20_important.dart';
import 'package:custom_app/firstpage/premium.dart';
import 'package:custom_app/firstpage/privacy_policy.dart';
import 'package:custom_app/firstpage/support.dart';
import 'package:custom_app/firstpage/terms_of_use.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/save_value.dart';
import 'package:custom_app/secondpage/customchart/TempChart.dart';
import 'package:custom_app/secondpage/model/peroid_data.dart';
import 'package:custom_app/secondpage/model/peroid_day.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../backup/backup.dart';
import 'impressum.dart';

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key key}) : super(key: key);

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  final databaseReference = FirebaseDatabase.instance.reference();
  String toolbarText = "Menü";
  int index = -1;
  TextEditingController saveCodeControler = TextEditingController();

  int cycleValue = 21;
  List<String> cycleSpinnerItems = [];
  int durationValue = 1;
  List<String> durationSpinnerItems = [];

  double height = 60;
  double topMargin = 10;

  String tage = " Tage";

  String date = "";

  bool switch1 = false;
  bool isLockOn = false;

  bool isLogin = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  List<PeriodData> tempDataList = [];

  @override
  void initState() {
    super.initState();

    for (int i = 21; i <= 100; i++) {
      cycleSpinnerItems.add(i.toString() + tage);
    }

    for (int i = 1; i <= 12; i++) {
      durationSpinnerItems.add(i.toString() + tage);
    }

    SaveValue.getCycleLength().then((value) => {
          print(value),
          if (value != null)
            {
              cycleValue = value,
            }
        });

    SaveValue.getPeriodDuration().then((value) => {
          print(value),
          if (value != null)
            {
              durationValue = value,
            }
        });
    SaveValue.getLastPeriodDate().then((value) => {
          print(value),
          if (value != null)
            {
              date = value,
            }
        });
    SaveValue.isShowFertileWindow().then((value) => {
          print(value),
          if (value != null)
            {
              switch1 = value,
            }
        });

    SaveValue.isLoginWithGoogle().then((value) => {
          if (value != null)
            {
              isLogin = value,
            }
        });

    SaveValue.getCode().then((value) => {
          saveCodeControler.text = value,
        });

    SaveValue.isLockOn().then((value) => {
          if (value != null)
            {
              isLockOn = value,
            }
        });

    CustomDB.instance.getDataForChart(7).then((value) => {
          if (value != null)
            {
              tempDataList.addAll(value),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (index == -1) {
          return Future.value(true);
        }
        toolbarText = "Menü";
        setState(() {
          index = -1;
        });
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                toolbarText,
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
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  child: Visibility(
                    visible: index == -1,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            toolbarText = "Mein Profil";
                            setState(() {
                              index = 0;
                            });
                          },
                          child: MenuHeadingText(text: "Mein Profil"),
                        ),
                        GestureDetector(
                          onTap: () {
                            toolbarText = "Alles Wichtige";
                            setState(() {
                              index = 1;
                            });
                          },
                          child: MenuHeadingText(
                              text: "Alles Wichtige über die App"),
                        ),
                        GestureDetector(
                            onTap: () {
                              toolbarText = "Euer Wunschkind";
                              setState(() {
                                index = 2;
                              });
                            },
                            child:
                                MenuHeadingText(text: "Über Euer Wunschkind")),
                        Visibility(
                          visible: false,
                          child: GestureDetector(
                              onTap: () {
                                toolbarText = "Premium";
                                setState(() {
                                  index = 3;
                                });
                              },
                              child: MenuHeadingText(text: "Premium")),
                        ),
                        GestureDetector(
                          onTap: () {
                            toolbarText = "Support";
                            setState(() {
                              index = 4;
                            });
                          },
                          child: MenuHeadingText(text: "Support"),
                        ),
                        GestureDetector(
                          onTap: () {
                            toolbarText = "Nutzungsbedingungen";
                            setState(() {
                              index = 5;
                            });
                          },
                          child: MenuHeadingText(text: "Nutzungsbedingungen"),
                        ),
                        GestureDetector(
                          onTap: () {
                            toolbarText = "Datenschutzerklärung";
                            setState(() {
                              index = 6;
                            });
                          },
                          child: MenuHeadingText(text: "Datenschutzerklärung"),
                        ),
                        GestureDetector(
                          onTap: () {
                            toolbarText = "Impressum";
                            setState(() {
                              index = 7;
                            });
                          },
                          child: MenuHeadingText(text: "Impressum"),
                        ),
                      ],
                    ),
                  ),
                ),
                // My profile
                Visibility(
                  visible: index == 0,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Zyklus",
                              style: TextStyle(
                                color: Color(0xFF196319),
                                fontSize: Constant.HeadingTextSize,
                                fontFamily: Constant.font_name,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: 20, left: 20, top: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Zykluslänge",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Constant.HeadingTextSize,
                                      fontFamily: Constant.font_name,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    top: 5, right: 10, left: 10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0XFF196319), width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: cycleValue.toString() + tage,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Constant.HeadingTextSize),
                                    underline: Container(
                                      height: 0,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String data) {
                                      setState(() {
                                        cycleValue = int.parse(
                                            data.replaceAll(tage, ""));
                                        SaveValue.saveCycleLength(cycleValue);

                                        calculatePeriod();
                                      });
                                    },
                                    items: cycleSpinnerItems
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: 20, left: 20, top: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Dauer der Periode",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Constant.HeadingTextSize,
                                      fontFamily: Constant.font_name,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(
                                    top: 5, right: 10, left: 10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0XFF196319), width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0))),
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: durationValue.toString() + tage,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Constant.HeadingTextSize),
                                    underline: Container(
                                      height: 0,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String data) {
                                      setState(() {
                                        durationValue = int.parse(
                                            data.replaceAll(tage, ""));
                                        SaveValue.savePeriodDuration(
                                            durationValue);

                                        calculatePeriod();
                                      });
                                    },
                                    items: durationSpinnerItems
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              right: 20, left: 20, top: 20, bottom: 10),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "1. Tag der letzten Periode",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Constant.HeadingTextSize,
                                    fontFamily: Constant.font_name,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Constant.getDate(context).then((picked) => {
                                          if (picked != null)
                                            {
                                              setState(() {
                                                date = Constant.formatTime(
                                                        picked.day.toString()) +
                                                    "." +
                                                    Constant.formatTime(picked
                                                        .month
                                                        .toString()) +
                                                    "." +
                                                    picked.year.toString();
                                                SaveValue.saveLastPeriodDate(
                                                    date);
                                              }),
                                              calculatePeriod(),
                                            }
                                        });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        date == "" ? "TT.MM" : date,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: Constant.font_name,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Image(
                                          image:
                                              AssetImage('assets/calander.png'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: false,
                          child: Container(
                            margin:
                                EdgeInsets.only(right: 20, left: 20, top: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Eisprung und fruchtbares Fenster im Kalender anzeigen",
                                    maxLines: 4,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Constant.HeadingTextSize,
                                      fontFamily: Constant.font_name,
                                    ),
                                  ),
                                ),
                                Switch(
                                  value: switch1,
                                  onChanged: (value) {
                                    // setFertileWindow(switch1);

                                    setState(() {
                                      switch1 = value;
                                    });
                                  },
                                  activeTrackColor:
                                      Color(Constant.toolbar_color),
                                  activeColor: Color(Constant.toolbar_color),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Diagramm",
                              style: TextStyle(
                                color: Color(0xFF196319),
                                fontSize: Constant.HeadingTextSize,
                                fontFamily: Constant.font_name,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    right: 20,
                                    left: 20,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Basaltemperatur",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Constant.HeadingTextSize,
                                        fontFamily: Constant.font_name,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TempChart(
                                                    tempDataList: tempDataList,
                                                  )));
                                    },
                                    child: Image(
                                      image:
                                          AssetImage('assets/temperature.png'),
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Sicherer Zugang",
                              style: TextStyle(
                                color: Color(0xFF196319),
                                fontSize: Constant.HeadingTextSize,
                                fontFamily: Constant.font_name,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Wenn der sichere Zugang aktiviert ist, kannst du die App nur mit deinem Zugangscode öffnen.",
                                  maxLines: 4,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Constant.subHeadingTextSize,
                                    fontFamily: Constant.font_name,
                                  ),
                                ),
                              ),
                              Switch(
                                value: isLockOn,
                                onChanged: (value) {
                                  SaveValue.setLockOn(value);
                                  if (!value) {
                                    saveCodeControler.text = "";
                                    SaveValue.saveCode("");
                                  }

                                  setState(() {
                                    isLockOn = value;
                                  });
                                },
                                activeTrackColor: Color(Constant.toolbar_color),
                                activeColor: Color(Constant.toolbar_color),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: isLockOn,
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 20, left: 20, top: 7, bottom: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Sicherheitscode",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Constant.HeadingTextSize,
                                      fontFamily: Constant.font_name,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      if (value.length == 6) {
                                        SaveValue.saveCode(value);
                                        showMessage(
                                            "Sicherheitscode eingestellt");
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    maxLength: 6,
                                    obscureText: true,
                                    obscuringCharacter: "*",
                                    style: TextStyle(
                                        fontFamily: Constant.font_name),
                                    controller: saveCodeControler,
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
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Datensicherung",
                              style: TextStyle(
                                color: Color(0xFF196319),
                                fontSize: Constant.HeadingTextSize,
                                fontFamily: Constant.font_name,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 20, top: 8),
                          child: Text(
                            "Sichere deine Daten mit Google-Drive auf deinem Google-Konto. Diese so gesicherten Daten lassen sich dann bei Bedarf auf dem ursprünglichen Gerät oder anderen Android-Geräten wieder herstellen.",
                            maxLines: 6,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Constant.subHeadingTextSize,
                              fontFamily: Constant.font_name,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (isLogin) {
                                      isLogin = false;
                                      SaveValue.setLoginWithGoogle(false);
                                      _googleSignIn.signOut();
                                      setState(() {});
                                    } else {
                                      loginWithGoogle();
                                    }
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(12),
                                      margin: EdgeInsets.only(
                                        right: 4,
                                      ),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF196319),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(
                                        isLogin ? 'Logout' : 'Google Login',
                                        style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          color: Colors.white,
                                          fontSize: Constant.HeadingTextSize,
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _googleSignIn
                                        .isSignedIn()
                                        .then((value) async => {
                                              if (value)
                                                {
                                                  showLoaderDialog(context),
                                                  Backup.saveCyclePeriod(
                                                      alert, context),
                                                }
                                              else
                                                {
                                                  showMessage(
                                                      "Login with google first!")
                                                }
                                            });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                        left: 4,
                                      ),
                                      padding: EdgeInsets.all(12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF196319),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(
                                        'Jetzt Sichern',
                                        style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          color: Colors.white,
                                          fontSize: Constant.HeadingTextSize,
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Everything  important
                Visibility(visible: index == 1, child: EverythingImportant()),

                Visibility(visible: index == 2, child: DesireChild()),

                Visibility(visible: index == 3, child: Premium()),
                Visibility(visible: index == 4, child: Support()),
                Visibility(visible: index == 5, child: TermsOfUse()),
                Visibility(visible: index == 6, child: PrivacyPolicy()),
                Visibility(visible: index == 7, child: Impressum()),
              ],
            ),
          )),
    );
  }

  Future<void> loginWithGoogle() async {
    try {
      await _googleSignIn.signIn();
      _googleSignIn.isSignedIn().then((value) => {
            if (value)
              {
                setState(() {
                  SaveValue.setLoginWithGoogle(true);
                  isLogin = true;
                  SaveValue.setGoogleId(_googleSignIn.currentUser.id);
                }),
              }
          });
    } catch (error) {
      print(error);
    }
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  AlertDialog alert;

  showLoaderDialog(BuildContext context) {
    alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  calculatePeriod() {
    /*CustomDB.instance.getPeriodDay().then((value) => {
          if (value == null || value.length == 0)
            {
            }
        });*/

    SaveValue.getCycleLength().then((cycleLength) => {
          if (cycleLength != null)
            {
              SaveValue.getPeriodDuration().then((periodDuration) => {
                    if (periodDuration != null)
                      {
                        SaveValue.getLastPeriodDate().then((lastPeriodDate) => {
                              if (lastPeriodDate != null)
                                {
                                  if (DateTime.now().isAfter(
                                      Constant.convertStringToDate(
                                          lastPeriodDate)))
                                    {
                                      setState(() {}),

                                      // delete previous period data
                                      CustomDB.instance
                                          .deletePeriodDay()
                                          .then((value) => {
                                                //inset new period data
                                                insetDataToDB(
                                                    cycleLength,
                                                    lastPeriodDate,
                                                    periodDuration),
                                              }),
                                    }
                                }
                            }),
                      }
                  }),
            }
        });
  }

  PeriodDay lastP;

  insetDataToDB(int cycleLength, String lastPeriodDate, int periodDuration) {
    for (int i = 0; i < 9; i++) {
      PeriodDay p = new PeriodDay();
      if (i == 0) {
        p.startDate = Constant.convertStringToDate(lastPeriodDate);
        p.endDate = p.startDate.add(Duration(days: periodDuration - 1));
      } else {
        p.startDate = lastP.startDate.add(Duration(days: cycleLength));
        p.endDate = p.startDate.add(Duration(days: periodDuration - 1));
      }

      CustomDB.instance.addPeriodDay(p);
      print(p.startDate.toString() + " = " + p.endDate.toString());
      lastP = p;
    }
  }
}
