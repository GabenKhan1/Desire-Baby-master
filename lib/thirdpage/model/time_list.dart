class TimeData {
  int id;
  String time;
  int notificationId = -1;
  int medikamentsId = -1;

  Map<String, dynamic> toMap() => {
        'id': id,
        'time': time,
        'notificationId': notificationId,
        'medikamentsId': medikamentsId,
      };
}

class TimeDataField {
  static String id = 'id';
  static String time = 'time';
  static String notificationId = 'notificationId';
  static String medikamentsId = 'medikamentsId';
}
