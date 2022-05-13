import 'package:custom_app/calander/date_model.dart';
import 'package:custom_app/calander/date_utils.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/secondpage/model/peroid_day.dart';
import 'package:custom_app/thirdpage/model/Treatments.dart';
import 'package:custom_app/thirdpage/model/investigation.dart';
import 'package:custom_app/thirdpage/model/medikamente.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// ignore: must_be_immutable
class VerticalCalendar extends StatefulWidget {
  final DateTime minDate;
  final DateTime maxDate;

  final DateTime currentDate;
  final MonthBuilder monthBuilder;
  final DayBuilder dayBuilder;
  final ValueChanged<DateTime> onDayPressed;
  final OnRangeSelected onRangeSelected;
  final OnPeriodSelected onPeriodSelected;

  final EdgeInsetsGeometry listPadding;
  bool isFirstTime = false;

  final List<Treatments> allTreamentList;
  final List<MedikamenteData> allMedikaments;
  final List<InvestigationsData> allInvestigations;
  final List<PeriodDay> periodDayList;
  String ovulationDay;

  VerticalCalendar(
      {this.minDate,
      this.maxDate,
      this.currentDate,
      this.monthBuilder,
      this.onRangeSelected,
      this.onPeriodSelected,
      this.dayBuilder,
      this.onDayPressed,
      this.allTreamentList,
      this.allInvestigations,
      this.allMedikaments,
      this.periodDayList,
      this.ovulationDay,
      this.listPadding})
      : assert(minDate != null),
        assert(maxDate != null),
        assert(minDate.isBefore(maxDate));

  @override
  _VerticalCalendarState createState() => _VerticalCalendarState();
}

class _VerticalCalendarState extends State<VerticalCalendar> {
  DateTime _minDate;
  DateTime _maxDate;
  DateTime _currentDate;
  List<Month> _months;

  DateTime rangeMinDate;
  DateTime rangeMaxDate;

  DateTime _periodStartDate;
  DateTime _periodEndDate;
  DateTime _ovulationDay;

  int scrollPosition = 0;
  List<PeriodDay> _periodDayList = [];

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  int i = 0;

  @override
  void initState() {
    super.initState();
    _months = MyDateUtils.extractWeeks(widget.minDate, widget.maxDate);
    _minDate = widget.minDate.removeTime();
    _maxDate = widget.maxDate.removeTime();
    _currentDate = widget.currentDate.removeTime();
    if (widget.periodDayList != null)
      _periodDayList.addAll(widget.periodDayList);

    if (widget.ovulationDay != null) {
      _ovulationDay = DateTime.parse(widget.ovulationDay);
    }

    scrollPosition = _currentDate.difference(_minDate).inDays ~/ 30;

    WidgetsBinding.instance.addPostFrameCallback((_) => {
          if (!widget.isFirstTime)
            {
              widget.isFirstTime = true,
              itemScrollController.jumpTo(index: scrollPosition)
            }
        });
  }

  @override
  void didUpdateWidget(VerticalCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.minDate != widget.minDate ||
        oldWidget.maxDate != widget.maxDate) {
      _months = MyDateUtils.extractWeeks(widget.minDate, widget.maxDate);
      _minDate = widget.minDate.removeTime();
      _maxDate = widget.maxDate.removeTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ScrollablePositionedList.builder(
              /*cacheExtent:
                  (MediaQuery.of(context).size.width / DateTime.daysPerWeek) *
                      6,*/
              padding: widget.listPadding ?? EdgeInsets.zero,
              itemCount: _months.length,
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              itemBuilder: (BuildContext context, int position) {
                return _MonthView(
                  month: _months[position],
                  minDate: _minDate,
                  maxDate: _maxDate,
                  monthBuilder: widget.monthBuilder,
                  dayBuilder: widget.dayBuilder,
                  rangeMinDate: rangeMinDate,
                  rangeMaxDate: rangeMaxDate,
                  currentDate: _currentDate,
                  periodStartDate: _periodStartDate,
                  periodEndDate: _periodEndDate,
                  allTreamentList: widget.allTreamentList,
                  allInvestigations: widget.allInvestigations,
                  allMedikaments: widget.allMedikaments,
                  ovulationDay: _ovulationDay,
                  periodDayList: _periodDayList,
                  onDayPressed: (DateTime date) {
                    if (widget.onRangeSelected != null) {
                      //check the user tap on existing red day.
                      bool isRemove = false;

                      for (int i = 0; i < _periodDayList.length; i++) {
                        if (date.isSameDayOrAfter(
                                _periodDayList[i].startDate) &&
                            date.isSameDayOrBefore(_periodDayList[i].endDate)) {
                          // remove these day from list
                          _periodDayList.remove(_periodDayList[i]);
                          isRemove = true;
                          break;
                        }
                      }
                      if (!isRemove) {
                        if (rangeMinDate == null || rangeMaxDate != null) {
                          setState(() {
                            rangeMinDate = date;
                            rangeMaxDate = null;
                          });
                        } else if (date.isBefore(rangeMinDate)) {
                          setState(() {
                            rangeMaxDate = rangeMinDate;
                            rangeMinDate = date;
                          });
                        } else if (date.isAfter(rangeMinDate)) {
                          rangeMaxDate = date;

                          PeriodDay p = new PeriodDay();
                          p.startDate = rangeMinDate;
                          p.endDate = rangeMaxDate;
                          _periodDayList.add(p);

                          rangeMaxDate = null;
                          rangeMinDate = null;

                          setState(() {});
                        }
                      }

                      if (widget.onPeriodSelected != null) {
                        widget.onPeriodSelected(_periodDayList);
                      }
                      widget.onRangeSelected(rangeMinDate, rangeMaxDate);
                    }

                    if (widget.onDayPressed != null) {
                      widget.onDayPressed(date);
                    }
                  },
                );
              }),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class _MonthView extends StatelessWidget {
  final Month month;
  final DateTime minDate;
  final DateTime maxDate;
  final MonthBuilder monthBuilder;
  final DayBuilder dayBuilder;
  final ValueChanged<DateTime> onDayPressed;
  final DateTime rangeMinDate;
  final DateTime rangeMaxDate;
  final DateTime currentDate;
  DateTime periodStartDate;
  DateTime periodEndDate;
  DateTime ovulationDay;

  final List<Treatments> allTreamentList;
  final List<MedikamenteData> allMedikaments;
  final List<InvestigationsData> allInvestigations;
  final List<PeriodDay> periodDayList;

  bool isAvailableMedikament = false;
  bool isOvulationDay = false;

  _MonthView(
      {this.month,
      this.minDate,
      this.maxDate,
      this.monthBuilder,
      this.dayBuilder,
      this.rangeMinDate,
      this.rangeMaxDate,
      this.onDayPressed,
      this.currentDate,
      this.periodStartDate,
      this.periodEndDate,
      this.allTreamentList,
      this.allInvestigations,
      this.allMedikaments,
      this.periodDayList,
      this.ovulationDay,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Week> singleWeek = [];

    singleWeek.add(month.weeks[0]);

    return Column(
      children: <Widget>[
        monthBuilder != null
            ? monthBuilder(context, month.month, month.year)
            : _DefaultMonthView(month: month.month, year: month.year),
        Table(
          children: singleWeek
              .map((Week week) => _generateWeek(context, week))
              .toList(growable: false),
        ),
        Table(
          children: month.weeks
              .map((Week week) => _generateFor(context, week))
              .toList(growable: false),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Divider(
            thickness: 1,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  TableRow _generateFor(BuildContext context, Week week) {
    DateTime firstDay = week.firstDay;
    bool rangeFeatureEnabled = rangeMinDate != null;
    bool isCurrentDay = false;

    return TableRow(
        children: List<Widget>.generate(DateTime.daysPerWeek, (int position) {
      DateTime day = DateTime(week.firstDay.year, week.firstDay.month,
          firstDay.day + (position - (firstDay.weekday - 1)));

      if ((position + 1) < week.firstDay.weekday ||
          (position + 1) > week.lastDay.weekday ||
          day.isBefore(minDate) ||
          day.isAfter(maxDate)) {
        return AspectRatio(
            aspectRatio: 1.0,
            child: _DefaultDayView(
                date: day,
                isDisable: true,
                isOvulationDay: false,
                periodDay: false,
                isAvailableMedikament: isAvailableMedikament,
                isCurrentDay: isCurrentDay,
                isSelected: false));
      } else {
        isCurrentDay = day.isSameDay(currentDate);
        bool isSelected = false;
        bool periodDay = false;
        Treatments treatments;
        InvestigationsData investigationsData;
        //MedikamenteData medikamenteData;

        // check user selected range
        if (rangeFeatureEnabled) {
          if (rangeMinDate != null && rangeMaxDate != null) {
            isSelected = day.isSameDayOrAfter(rangeMinDate) &&
                day.isSameDayOrBefore(rangeMaxDate);
          } else {
            isSelected = day.isAtSameMomentAs(rangeMinDate);
          }
        }

        //check period day
        if (periodDayList != null && periodDayList.length > 0)
          for (int i = 0; i < periodDayList.length; i++) {
            periodDay = day.isSameDayOrAfter(periodDayList[i].startDate) &&
                day.isSameDayOrBefore(periodDayList[i].endDate);
            if (periodDay) {
              break;
            }
          }

        if (allTreamentList != null && allTreamentList.length > 0) {
          for (int i = 0; i < allTreamentList.length; i++) {
            if (day.isSameDay(
                Constant.convertStringToDate(allTreamentList[i].date))) {
              treatments = allTreamentList[i];
              break;
            } else {
              treatments = null;
            }
          }
        }

        if (allInvestigations != null && allInvestigations.length > 0) {
          for (int i = 0; i < allInvestigations.length; i++) {
            if (day.isSameDay(
                Constant.convertStringToDate(allInvestigations[i].date))) {
              investigationsData = allInvestigations[i];
              break;
            } else {
              investigationsData = null;
            }
          }
        }

        if (allMedikaments != null && allMedikaments.length > 0) {
          for (int i = 0; i < allMedikaments.length; i++) {
            if (day.isSameDayOrAfter(Constant.convertStringToDate(
                    allMedikaments[i].startDate)) &&
                day.isSameDayOrBefore(
                    Constant.convertStringToDate(allMedikaments[i].endDate))) {
              isAvailableMedikament = true;
              break;
            } else {
              isAvailableMedikament = false;
            }
          }
        }

        if (ovulationDay != null) {
          isOvulationDay = day.isSameDay(ovulationDay);
        }

        return AspectRatio(
            aspectRatio: 1.0,
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onDayPressed != null
                    ? () {
                        if (onDayPressed != null) {
                          onDayPressed(day);
                        }
                      }
                    : null,
                child: _DefaultDayView(
                    date: day,
                    isDisable: false,
                    periodDay: periodDay,
                    treatments: treatments,
                    isAvailableMedikament: isAvailableMedikament,
                    isOvulationDay: isOvulationDay,
                    investigationsData: investigationsData,
                    isCurrentDay: isCurrentDay,
                    isSelected: isSelected)));
      }
    }, growable: false));
  }

  TableRow _generateWeek(BuildContext context, Week week) {
    DateTime firstDay = week.firstDay;

    return TableRow(
        children: List<Widget>.generate(DateTime.daysPerWeek, (int position) {
      DateTime day = DateTime(week.firstDay.year, week.firstDay.month,
          firstDay.day + (position - (firstDay.weekday - 1)));
      return AspectRatio(aspectRatio: 1.0, child: _DefaultWeekView(date: day));
    }, growable: false));
  }
}

class _DefaultMonthView extends StatelessWidget {
  final int month;
  final int year;

  _DefaultMonthView({this.month, this.year});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              Constant.convertMonthToGerman(
                  DateFormat('MMMM').format(DateTime(year, month))),
              style: TextStyle(
                fontFamily: Constant.font_name,
                fontSize: 22,
              ),
            ),
            Text(
              DateFormat(' yyyy').format(DateTime(year, month)),
              style: TextStyle(
                fontFamily: Constant.font_name,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: missing_return
String convertWeekToGerman(String monthName) {
  if (monthName.toLowerCase() == "Monday".toLowerCase()) return "Montag";
  if (monthName.toLowerCase() == "Tuesday".toLowerCase()) return "Dienstag";
  if (monthName.toLowerCase() == "Wednesday".toLowerCase()) return "Mittwoch";
  if (monthName.toLowerCase() == "Thursday".toLowerCase()) return "Donnerstag";
  if (monthName.toLowerCase() == "Friday".toLowerCase()) return "Freitag";
  if (monthName.toLowerCase() == "Saturday".toLowerCase()) return "Samstag";
  if (monthName.toLowerCase() == "Sunday".toLowerCase()) return "Sonntag";
  //return monthName;
}

class _DefaultDayView extends StatelessWidget {
  final DateTime date;
  final bool isDisable;
  final bool isSelected;
  final isCurrentDay;
  final periodDay;
  final Treatments treatments;
  final InvestigationsData investigationsData;
  final bool isAvailableMedikament;
  final bool isOvulationDay;

  _DefaultDayView(
      {this.date,
      this.isSelected,
      this.isCurrentDay,
      this.periodDay,
      this.treatments,
      this.isAvailableMedikament,
      this.investigationsData,
      this.isOvulationDay,
      this.isDisable});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              border: isOvulationDay
                  ? Border.all(color: Color(0xFF196319), width: 1)
                  : null,
              color: isCurrentDay ? Color(0xFF196319) : Colors.transparent,
              shape: BoxShape.circle),
          child: Text(
            Constant.formatTime(DateFormat('d').format(date)),
            style: TextStyle(
                color: isSelected || periodDay
                    ? Color(0xFFFF0C3E)
                    : isDisable
                        ? Colors.grey
                        : isCurrentDay
                            ? Colors.white
                            : Colors.black,
                fontFamily: Constant.font_name,
                fontSize: Constant.calanderTextSize),
          ),
        ),
        Visibility(
          visible: treatments != null ||
              investigationsData != null ||
              isAvailableMedikament,
          child: Image(
            image: AssetImage('assets/pencile.png'),
          ),
        ),
      ],
    );
  }
}

class _DefaultWeekView extends StatelessWidget {
  final DateTime date;

  _DefaultWeekView({this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        convertWeekToGerman(DateFormat('EEEE').format(date)).substring(0, 2),
        style: TextStyle(
            locale: const Locale("de", "FR"),
            fontFamily: Constant.font_name,
            fontSize: Constant.calanderTextSize),
      ),
    );
  }
}

typedef MonthBuilder = Widget Function(
    BuildContext context, int month, int year);
typedef DayBuilder = Widget Function(BuildContext context, DateTime date,
    {bool isSelected});
typedef OnRangeSelected = void Function(DateTime minDate, DateTime maxDate);

typedef OnPeriodSelected = void Function(List<PeriodDay> periodList);
