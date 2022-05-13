class CyclePeriodData {
  int id;
  int cycleNumber;
  String startDate;
  String endDate;
  String typeOfTreatment;

  Map<String, dynamic> toMap() => {
        'startDate': startDate,
        'id': id,
        'cycleNumber': cycleNumber,
        'endDate': endDate,
        'typeOfTreatment': typeOfTreatment,
      };
}

class CyclePeriodField {
  static String id = 'id';
  static String startDate = 'startDate';
  static String endDate = 'endDate';
  static String typeOfTreatment = 'typeOfTreatment';
  static String cycleNumber = 'cycleNumber';
}
