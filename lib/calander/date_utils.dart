import 'package:custom_app/calander/date_model.dart';

class MyDateUtils {
  static List<Month> extractWeeks(DateTime minDate, DateTime maxDate) {
    DateTime weekMinDate = _findDayOfWeekInMonth(minDate, DateTime.monday);
    DateTime weekMaxDate = _findDayOfWeekInMonth(maxDate, DateTime.sunday);

    DateTime firstDayOfWeek = weekMinDate;
    DateTime lastDayOfWeek = _lastDayOfWeek(weekMinDate);

    if (!lastDayOfWeek.isBefore(weekMaxDate)) {
      return <Month>[
        Month(<Week>[Week(firstDayOfWeek, lastDayOfWeek)])
      ];
    } else {
      List<Month> months = [];
      List<Week> weeks = [];

      while (lastDayOfWeek.isBefore(weekMaxDate)) {
        Week week = Week(firstDayOfWeek, lastDayOfWeek);
        weeks.add(week);

        if (week.isLastWeekOfMonth) {
          if (lastDayOfWeek.isSameDayOrAfter(minDate)) {
            months.add(Month(weeks));
          }

          weeks = [];

          firstDayOfWeek = firstDayOfWeek.toFirstDayOfNextMonth();
          lastDayOfWeek = _lastDayOfWeek(firstDayOfWeek);

          weeks.add(Week(firstDayOfWeek, lastDayOfWeek));
        }

        firstDayOfWeek = lastDayOfWeek.nextDay;
        lastDayOfWeek = _lastDayOfWeek(firstDayOfWeek);
      }

      if (!lastDayOfWeek.isBefore(weekMaxDate)) {
        weeks.add(Week(firstDayOfWeek, lastDayOfWeek));
      }

      months.add(Month(weeks));

      return months;
    }
  }

  static DateTime _lastDayOfWeek(DateTime firstDayOfWeek) {
    int daysInMonth = firstDayOfWeek.daysInMonth;

    if (firstDayOfWeek.day + 6 > daysInMonth) {
      return DateTime(firstDayOfWeek.year, firstDayOfWeek.month, daysInMonth);
    } else {
      return firstDayOfWeek
          .add(Duration(days: DateTime.sunday - firstDayOfWeek.weekday));
    }
  }

  static DateTime _findDayOfWeekInMonth(DateTime date, int dayOfWeek) {
    date = DateTime(date.year, date.month, date.day);

    if (date.weekday == DateTime.monday) {
      return date;
    } else {
      return date.subtract(Duration(days: date.weekday - dayOfWeek));
    }
  }

  static List<int> daysPerMonth(int year) => <int>[
        31,
        isLeapYear(year) ? 29 : 28,
        31,
        30,
        31,
        30,
        31,
        31,
        30,
        31,
        30,
        31,
      ];

  static int getMonth(DateTime then, DateTime now) {
    int years = now.year - then.year;
    int months = now.month - then.month;
    int days = now.day - then.day;
    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += (days < 0 ? 11 : 12);
    }
    if (days < 0) {
      final monthAgo = DateTime(now.year, now.month - 1, then.day);
      days = now.difference(monthAgo).inDays + 1;
    }
    print(years);
    return months;

    // print('$years years $months months $days days');
  }

  static bool isLeapYear(int year) {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true) {
      return false;
    } else if (year % 4 == 0) {
      return true;
    }

    return leapYear;
  }
}

extension DateUtilsExtensions on DateTime {
  bool get isLeapYear {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true) {
      return false;
    } else if (year % 4 == 0) {
      return true;
    }

    return leapYear;
  }

  int get daysInMonth => MyDateUtils.daysPerMonth(year)[month - 1];

  DateTime toFirstDayOfNextMonth() => DateTime(
        year,
        month + 1,
      );

  DateTime get nextDay => DateTime(year, month, day + 1);

  bool isSameDayOrAfter(DateTime other) => isAfter(other) || isSameDay(other);

  bool isSameDayOrBefore(DateTime other) => isBefore(other) || isSameDay(other);

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  DateTime removeTime() => DateTime(year, month, day);
}
