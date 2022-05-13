class PeriodData {
  int id;
  String text;
  String imageName;
  String date;
  String value='';
  int type;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'imageName': imageName,
      'date': date,
      'type': type,
      'value': value,
    };
  }
}

class PeriodDataField {
  static String id = 'id';
  static String text = 'text';
  static String imageName = 'imageName';
  static String date = 'date';
  static String type = 'type';
  static String value = 'value';
}
