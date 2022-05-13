class Treatments{

   int id ;
   String text ;
   String date ;
   String time ;
   String alarmTime ;
   String treatment ;
   int isChecked  ;
   int cycleNumber ;
   int notificationId =-1 ;

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'time': time,
        'alarmTime': alarmTime,
        'text': text,
        'isChecked': isChecked,
        'treatment': treatment,
        'cycleNumber': cycleNumber,
        'notificationId': notificationId,
      };
}

class TreatmentsField{

  static String id= 'id';
  static String date = 'date';
  static String time = 'time';
  static String alarmTime = 'alarmTime';
  static String text = 'text';
  static String isChecked = 'isChecked';
  static String treatment = 'treatment';
  static String cycleNumber = 'cycleNumber';
  static String notificationId = 'notificationId';

}
