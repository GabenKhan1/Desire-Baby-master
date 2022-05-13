class PeriodDay {
  int id;
  DateTime startDate;
  DateTime endDate;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
    };
  }
}

class PeriodDayField {
  static String id = 'id';
  static String endDate = 'endDate';
  static String startDate = 'startDate';
}
