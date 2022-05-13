class MedikamenteData {

  int id;
  String drugController;
  String dosageController;
  String typeOfExpenditureText;
  String typeOfExpenditureImage;
  String startDate;
  String endDate;
  String otherTime;
  String time;
  String alarmTime;
  int isChecked;
  int cycleNumber;
  int notificationId=-1;
  List<String> timeList = [];


  Map<String, dynamic> toMap() => {
        'drugController': drugController,
        'dosageController': dosageController,
        'typeOfExpenditureText': typeOfExpenditureText,
        'typeOfExpenditureImage': typeOfExpenditureImage,
        'startDate': startDate,
        'endDate': endDate,
        'time': time,
        'alarmTime': alarmTime,
        'otherTime': otherTime,
        'isChecked': isChecked,
        'cycleNumber': cycleNumber,
        'notificationId': notificationId,
      };
}

class MedikamenteDataField {
  static String id = 'id';
  static String drugController = 'drugController';
  static String dosageController = 'dosageController';
  static String typeOfExpenditureText = 'typeOfExpenditureText';
  static String typeOfExpenditureImage = 'typeOfExpenditureImage';
  static String startDate = 'startDate';
  static String endDate = 'endDate';
  static String time = 'time';
  static String alarmTime = 'alarmTime';
  static String otherTime = 'otherTime';
  static String isChecked = 'isChecked';
  static String cycleNumber = 'cycleNumber';
  static String notificationId = 'notificationId';
}
