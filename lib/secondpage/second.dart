import 'package:app_settings/app_settings.dart';
import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/secondpage/my_month.dart';
import 'package:custom_app/secondpage/period.dart';
import 'package:custom_app/thirdpage/model/Treatments.dart';
import 'package:custom_app/thirdpage/model/investigation.dart';
import 'package:custom_app/thirdpage/model/medikamente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:table_calendar/table_calendar.dart';

import '../save_value.dart';
import 'model/peroid_data.dart';
import 'model/peroid_day.dart';

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key key}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  double imageSize = 60;

  CalendarController calendarController = CalendarController();
  List<InvestigationsData> investigationList;
  List<MedikamenteData> medikamentList;
  List<Treatments> treatmentList;

  String dayOfCycle = "";
  DateTime initialSelectedDay;

  Map<DateTime, List<dynamic>> pDay;
  List<dynamic> p;
  bool isShowOvulationText = false;

  String ovulationDay;
  DateTime todayDateTime;
  DateTime selectedDateForPeriodData;

  @override
  void initState() {
    super.initState();

    medikamentList = [];
    treatmentList = [];
    investigationList = [];

    pDay = {};
    p = [];
    list = [];

    todayDateTime = DateTime.now();
    selectedDateForPeriodData = DateTime.now();

    loadCycleDay(todayDateTime);
    // loadOvulationDay(todayDateTime);
    loadPeriodData(todayDateTime);
    loadDataDateVise(todayDateTime);
    loadDataForMyMonth();
    // initAutoStart();

    NotificationPermissions.getNotificationPermissionStatus().then((value) => {
          if (value != PermissionStatus.granted)
            {AppSettings.openNotificationSettings()}
        });

    initAutoStart();
  }

  Future<void> initAutoStart() async {
    try {
      var test = await isAutoStartAvailable;

      print(test);
      if (test) await getAutoStartPermission();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (index != 0) {
          setState(() {
            index = 0;
          });

          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: index == 0
            ? AppBar(
                title: Text(
                  'Mein Tag',
                  style: TextStyle(
                      color: Color(Constant.toolbar_text_color),
                      fontFamily: Constant.font_name),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Image(
                      image: AssetImage('assets/calander.png'),
                    ),
                    onPressed: () {
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyMonth(
                                    allTreamentList: allTreamentList,
                                    allInvestigations: allInvestigations,
                                    allMedikaments: allMedikaments,
                                    periodDayList: periodDayList,
                                    ovulationDay: ovulationDay,
                                  ))).then((value) => {
                            if (value != null)
                              {
                                loadDataDateVise(value),
                                loadPeriodData(
                                    Constant.covertDateToString(value)),
                                loadCycleDay(value),
                                calendarController.setSelectedDay(value,
                                    animate: true),
                              }
                          });
*/
                      setState(() {
                        index = 2;
                      });
                    },
                  ),
                ],
                centerTitle: true,
                backgroundColor: Color(Constant.toolbar_color),
                automaticallyImplyLeading: false,
              )
            : null,
        body: index == 0
            ? Container(
                color: Constant.bg_color,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TableCalendar(
                                initialSelectedDay: initialSelectedDay,
                                holidays: pDay,
                                // events: events,
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                startDay: DateTime.utc(2020),
                                endDay: DateTime.utc(2050),
                                calendarController: calendarController,
                                locale: 'de',
                                weekendDays: [],
                                onDaySelected:
                                    (DateTime day, List events, List holidays) {
                                  loadDataDateVise(day);
                                  loadPeriodData(day);
                                  loadCycleDay(day);
                                  selectedDateForPeriodData = day;
                                },
                                initialCalendarFormat: CalendarFormat.week,
                                builders: CalendarBuilders(),
                                daysOfWeekStyle: DaysOfWeekStyle(
                                    weekdayStyle: TextStyle(
                                        fontFamily: Constant.font_name,
                                        fontSize: Constant.HeadingTextSize)),
                                calendarStyle: CalendarStyle(
                                    canEventMarkersOverflow: true,
                                    eventDayStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF196319),
                                        fontFamily: Constant.font_name,
                                        fontSize: Constant.HeadingTextSize),
                                    weekdayStyle: TextStyle(
                                        fontFamily: Constant.font_name,
                                        fontSize: Constant.HeadingTextSize),
                                    holidayStyle: TextStyle(
                                        color: Colors.red[600],
                                        fontFamily: Constant.font_name,
                                        fontSize: Constant.HeadingTextSize),
                                    outsideHolidayStyle: TextStyle(
                                        color: Colors.red[600],
                                        fontFamily: Constant.font_name,
                                        fontSize: Constant.HeadingTextSize),
                                    selectedColor: Color(0xFF196319),
                                    todayColor: Colors.grey

                                    /*todayStyle: TextStyle(
                                color:  events == null || events.length == 0 ? Colors.black :Colors.black
                              ),
                              selectedColor: events == null || events.length == 0 ? Color(0xFF196319) :Colors.transparent,
*/

                                    ),
                                headerStyle: HeaderStyle(
                                  titleTextStyle: TextStyle(
                                      fontFamily: Constant.font_name,
                                      fontSize: 20),
                                  formatButtonVisible: false,
                                  centerHeaderTitle: true,
                                )),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 20, right: 20, left: 20),
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF96AA41)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                dayOfCycle == ""
                                                    ? "---"
                                                    : "Zyklustag " + dayOfCycle,
                                                style: TextStyle(
                                                  color: Color(0xFF196319),
                                                  fontSize: 20,
                                                  fontFamily:
                                                      Constant.font_name,
                                                ),
                                              ),
                                              Visibility(
                                                visible: isShowOvulationText,
                                                child: Text(
                                                  "Tag des Eisprungs",
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize: Constant
                                                        .HeadingTextSize,
                                                    fontFamily:
                                                        Constant.font_name,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: ListView.builder(
                                itemCount: investigationList == null
                                    ? 0
                                    : investigationList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: 10, right: 20, left: 20),
                                    child: Row(
                                      children: [
                                        Text(investigationList[index].time,
                                            style: TextStyle(
                                                fontSize:
                                                    Constant.HeadingTextSize,
                                                fontFamily:
                                                    Constant.font_name)),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Expanded(
                                            flex: 7,
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 25),
                                                child: Text(
                                                  investigationList[index]
                                                      .investigations,
                                                  style: TextStyle(
                                                      fontSize: Constant
                                                          .HeadingTextSize,
                                                      fontFamily:
                                                          Constant.font_name),
                                                ))),
                                        Container(
                                          margin: EdgeInsets.only(right: 15),
                                          child: Image(
                                            image: investigationList[index]
                                                        .isChecked ==
                                                    1
                                                ? AssetImage(
                                                    'assets/bell_2.png')
                                                : AssetImage(
                                                    'assets/bell_1.png'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
                                        top: 10, right: 20, left: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        medikamentList[index]
                                                            .time,
                                                        style: TextStyle(
                                                          fontFamily: Constant
                                                              .font_name,
                                                          fontSize: Constant
                                                              .HeadingTextSize,
                                                        ),
                                                      ),
                                                    ),
                                                    ListView.builder(
                                                      itemCount: medikamentList[
                                                                      index]
                                                                  .timeList ==
                                                              null
                                                          ? 0
                                                          : medikamentList[
                                                                  index]
                                                              .timeList
                                                              .length,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, timeIndex) {
                                                        return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            medikamentList[
                                                                        index]
                                                                    .timeList[
                                                                timeIndex],
                                                            style: TextStyle(
                                                                fontSize: Constant
                                                                    .HeadingTextSize,
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
                                                  flex: 4,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 30,
                                                            height: 30,
                                                            child: Image(
                                                              image: AssetImage(
                                                                  medikamentList[
                                                                          index]
                                                                      .typeOfExpenditureImage),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            child: Text(
                                                              medikamentList[
                                                                      index]
                                                                  .drugController,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    Constant
                                                                        .font_name,
                                                                fontSize: Constant
                                                                    .HeadingTextSize,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 37),
                                                            child: Text(
                                                              medikamentList[
                                                                      index]
                                                                  .dosageController,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    Constant
                                                                        .font_name,
                                                                fontSize: Constant
                                                                    .HeadingTextSize,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                                child: Image(
                                                  image: medikamentList[index]
                                                              .isChecked ==
                                                          1
                                                      ? AssetImage(
                                                          'assets/bell_2.png')
                                                      : AssetImage(
                                                          'assets/bell_1.png'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                              },
                            ),
                            ListView.builder(
                              itemCount: treatmentList == null
                                  ? 0
                                  : treatmentList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: 10, right: 20, left: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                treatmentList[index].time,
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constant.font_name,
                                                    fontSize: Constant
                                                        .HeadingTextSize))),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                treatmentList[index].text,
                                                style: TextStyle(
                                                    fontFamily:
                                                        Constant.font_name,
                                                    fontSize: Constant
                                                        .HeadingTextSize))),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: Image(
                                          image: treatmentList[index]
                                                      .isChecked ==
                                                  1
                                              ? AssetImage('assets/bell_2.png')
                                              : AssetImage('assets/bell_1.png'),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    /* Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        height: imageSize + 20,
                        child: ListView.builder(
                          itemCount: list != null ? list.length : 0,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [

                                SizedBox(
                                    width: imageSize,
                                    height: imageSize,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Image(
                                            width: imageSize,
                                            height: imageSize,
                                            image: AssetImage(list[index].imageName),
                                          ),
                                        ),
                                      ],
                                    )),
                                Visibility(
                                  visible: list[index].value != '',
                                  child: Text(
                                    list[index].value,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: Constant.font_name),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),*/

                    Container(
                      margin: EdgeInsets.only(left: 10, right: 100),
                      child: GridView.builder(
                        shrinkWrap: true,
                        //itemCount: images.length,
                        itemCount: list != null ? list.length : 0,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              SizedBox(
                                  width: imageSize,
                                  height: imageSize,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image(
                                          width: imageSize,
                                          height: imageSize,
                                          image:
                                              AssetImage(list[index].imageName),
                                        ),
                                      ),
                                    ],
                                  )),
                              Visibility(
                                visible: list[index].value != '',
                                child: Text(
                                  list[index].value,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: Constant.font_name),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : index == 1
                ? Period(
                    refreshList: () {
                      loadPeriodDay();
                    },
                    selectedDate: selectedDateForPeriodData,
                    list: list,
                    isShowOvulationText: isShowOvulationText,
                    onPeriodSelected: (periodDayList) {
                      index = 0;
                      loadPeriodData(DateTime.now());
                    },
                  )
                : index == 2
                    ? MyMonth(
                        allTreamentList: allTreamentList,
                        allInvestigations: allInvestigations,
                        allMedikaments: allMedikaments,
                        periodDayList: periodDayList,
                        ovulationDay: ovulationDay,
                        onDayPressed: (value) {
                          if (value != null) {
                            initialSelectedDay = value;

                            loadDataDateVise(value);
                            loadPeriodData(value);
                            loadCycleDay(value);
                            setState(() {
                              index = 0;
                            });
                          }
                        })
                    : Container(),
        floatingActionButton: Visibility(
          visible: index == 0,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                index = 1;
              });
            },
            child: Image(
              image: AssetImage(
                'assets/add_white.png',
              ),
            ),
            backgroundColor: Color(0xFF196319),
          ),
        ),
      ),
    );
  }

  int index = 0;

  List<PeriodData> list;

  void loadDataDateVise(DateTime todayDateTime) {
    investigationList.clear();
    medikamentList.clear();
    treatmentList.clear();
    String todayDateInString = Constant.covertDateToString(todayDateTime);

    CustomDB.instance
        .getInvestigationWithDate(todayDateInString)
        .then((value) => {
              setState(() {
                investigationList.addAll(value);
              })
            });
    CustomDB.instance.getAllMedikaments().then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              if (Constant.isSameDay(todayDateTime,
                      Constant.convertStringToDate(value[i].startDate)) ||
                  Constant.isSameDay(todayDateTime,
                      Constant.convertStringToDate(value[i].endDate)))
                {
                  setState(() {
                    value[i].timeList = value[i].otherTime.split(",");
                    medikamentList.add(value[i]);
                  })
                }
              else if (todayDateTime.isAfter(
                      Constant.convertStringToDate(value[i].startDate)) &&
                  todayDateTime
                      .isBefore(Constant.convertStringToDate(value[i].endDate)))
                {
                  setState(() {
                    value[i].timeList = value[i].otherTime.split(",");
                    medikamentList.add(value[i]);
                  })
                }
            }
        });

    CustomDB.instance
        .getAllTreatmentWithDate(todayDateInString)
        .then((value) => {
              setState(() {
                treatmentList.addAll(value);
              })
            });
  }

  List<Treatments> allTreamentList;
  List<MedikamenteData> allMedikaments;
  List<InvestigationsData> allInvestigations;
  List<PeriodDay> periodDayList;

  void loadDataForMyMonth() {
    allTreamentList = [];
    allMedikaments = [];
    allInvestigations = [];

    // CustomDB.instance.deletePeriodDay();
    CustomDB.instance
        .getAllTreatment()
        .then((value) => {allTreamentList.addAll(value)});

    CustomDB.instance.getAllMedikaments().then((value) => {
          allMedikaments.addAll(value),
        });

    CustomDB.instance.getAllInvestigation().then((value) => {
          allInvestigations.addAll(value),
        });

    loadPeriodDay();
  }

  void loadPeriodData(DateTime date) {
    list.clear();
    setState(() {
      isShowOvulationText = false;
    });

    CustomDB.instance
        .getPeriodData(Constant.covertDateToString(date))
        .then((value) => {
              list.addAll(value),
              for (int i = 0; i < list.length; i++)
                {
                  if (list[i].type == 9 && !isShowOvulationText)
                    {
                      list.removeAt(i),
                      isShowOvulationText = true,
                    }
                },
              setState(() {})
            });
    CustomDB.instance
        .getPeriodDataWithType(
            Constant.covertDateToString(date.add(Duration(days: 1))), 9)
        .then((value) => {
              if (value != null) {list.addAll(value), setState(() {})}
            });
  }

  loadCycleDay(DateTime value) {
    SaveValue.getCycleLength().then((cycleLength) => {
          if (cycleLength != null)
            {
              SaveValue.getLastPeriodDate().then((lastPeriodDate) => {
                    if (lastPeriodDate != null)
                      {
                        print(lastPeriodDate),
                        if (value.isAfter(
                            Constant.convertStringToDate(lastPeriodDate)))
                          {
                            dayOfCycle = ((value
                                            .difference(
                                                Constant.convertStringToDate(
                                                    lastPeriodDate))
                                            .inDays %
                                        cycleLength) +
                                    1)
                                .toString(),
                            setState(() {}),
                          }
                        else
                          dayOfCycle = "",
                      }
                  }),
            }
        });
  }

  void loadPeriodDay() {
    /*if (selectedDateForPeriodData != null)
      loadCycleDay(selectedDateForPeriodData);
    else*/
    loadCycleDay(DateTime.now());
    periodDayList = [];
    pDay.clear();

    CustomDB.instance.getPeriodDay().then((value) => {
          if (value != null && value.length > 0)
            {
              print(value[0].startDate),
              periodDayList = value,
              for (int j = 0; j < periodDayList.length; j++)
                {
                  for (int i = 0;
                      i <=
                          periodDayList[j]
                              .endDate
                              .difference(periodDayList[j].startDate)
                              .inDays;
                      i++)
                    {
                      pDay[periodDayList[j].startDate.add(Duration(days: i))] =
                          p,
                    }
                },
              setState(() {}),
            }
        });
  }
}
