class InvestigationsData {
  int id;
  int cycleNumber;
  String investigations;
  String date;
  String time;
  String alarmTime="";
  String text;
  int isChecked;
  int notificationId = -1;

  Map<String, dynamic> toMap() => {
        'investigations': investigations,
        'date': date,
        'time': time,
        'alarmTime': alarmTime,
        'text': text,
        'isChecked': isChecked,
        'id': id,
        'cycleNumber': cycleNumber,
        'notificationId': notificationId,
      };
}

class InvestigationsField {
  static String id = 'id';
  static String investigations = 'investigations';
  static String date = 'date';
  static String time = 'time';
  static String alarmTime = 'alarmTime';
  static String text = 'text';
  static String isChecked = 'isChecked';
  static String cycleNumber = 'cycleNumber';
  static String notificationId = 'notificationId';
}
