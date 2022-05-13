import 'dart:ui';

import 'package:custom_app/alaramTimeDialog/model/alarm_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class Constant {
  static String weightPostFix = "kg";
  static String tempPostFix = "ºC";

  static String CYCLE_PERIOD = 'cycle_period';
  static String INVESTIGATION = 'investigation';
  static String TREATMENT = 'treatment';
  static String MEDIKAMENTS = 'Medikaments';
  static String DIARY = 'Diary';

  static int toolbar_color = 0xFFCBE398;
  static int toolbar_text_color = 0xFF718027;
  static String font_name = 'BalsamiqSans';

  static Color bar_color = Color(0xFFCBE398).withOpacity(0.3);
  static Color tempcolor = Color(0xFFCBE398).withBlue(1000);

  static Color bg_color = Color(0xFFCBE398).withOpacity(0.2);

  static double HeadingTextSize = 17;
  static double subHeadingTextSize = 15;

  static double calanderTextSize = 17;
  static bool isRequired = true;
  static bool isPurchased = true;

  static Future<DateTime> getDate(BuildContext context) async {
    return await showDatePicker(
        locale: const Locale("de", "FR"),
        context: context,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Color(0xFF697D3E),
                onPrimary: Colors.white,
                surface: Color(Constant.toolbar_color),
                onSurface: Colors.grey[900],
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
  }

  static Future<TimeOfDay> getTime(BuildContext context) async {
    return await showRoundedTimePicker(
        context: context,
        fontFamily: Constant.font_name,
        theme: ThemeData(
            primaryColor: Theme.of(context).primaryColor,
            accentColor: Color(0xFF697D3E),
            cardColor: Color(0xFF697D3E),
            buttonColor: Color(0xFF697D3E)),
        initialTime: TimeOfDay.now(),
        locale: Locale("de", "FR"));
  }

  static String formatTime(String s) {
    if (int.parse(s) < 10) {
      return "0" + s;
    }

    return s;
  }

  static DateTime convertStringToDate(String s) {
    return DateTime.parse(s.split(".")[2] +
        "-" +
        s.split(".")[1] +
        "-" +
        s.split(".")[0] +
        ' 00:00:00.000');
  }

  static DateTime convertDateTimeStringToDate(String date, String time) {
    return DateTime.parse(date.split(".")[2] +
        "-" +
        date.split(".")[1] +
        "-" +
        date.split(".")[0] +
        ' ' +
        time.split(":")[0] +
        ':' +
        time.split(":")[1] +
        ':00.000');
  }

  static bool isSameDay(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;

  static String covertDateToString(DateTime date) {
    return formatTime(date.day.toString()) +
        "." +
        formatTime(date.month.toString()) +
        "." +
        formatTime(date.year.toString());
  }

  static List<AlarmTime> timeList() {
    List<AlarmTime> timeList = [];
    timeList.add(AlarmTime("5 min. vorher", "5"));
    timeList.add(AlarmTime("15 min. vorher", "15"));
    timeList.add(AlarmTime("30 min. vorher", "30"));
    timeList.add(AlarmTime("45 min. vorher", "45"));
    timeList.add(AlarmTime("60 min. vorher", "60"));
    timeList.add(AlarmTime("1 Std. 30 min. vorher", "90"));
    timeList.add(AlarmTime("2 Stunde vorher", "120"));

    return timeList;
  }

  static String convertMonthToGerman(String monthName) {
    if (monthName.toLowerCase() == "January".toLowerCase().toLowerCase())
      return "Januar";
    if (monthName.toLowerCase() == "February".toLowerCase()) return "Februar";
    if (monthName.toLowerCase() == "March".toLowerCase()) return "März";
    if (monthName.toLowerCase() == "April".toLowerCase()) return "April";
    if (monthName.toLowerCase() == "May".toLowerCase()) return "Mai";
    if (monthName.toLowerCase() == "June".toLowerCase()) return "Juni";
    if (monthName.toLowerCase() == "July".toLowerCase()) return "Juli";
    if (monthName.toLowerCase() == "August".toLowerCase()) return "August";
    if (monthName.toLowerCase() == "September".toLowerCase())
      return "September";
    if (monthName.toLowerCase() == "October".toLowerCase()) return "Oktober";
    if (monthName.toLowerCase() == "November".toLowerCase()) return "November";
    if (monthName.toLowerCase() == "December".toLowerCase()) return "Dezember";
    return monthName;
  }

  static showPremierMessage(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Premium option..."),
    ));
  }
}
