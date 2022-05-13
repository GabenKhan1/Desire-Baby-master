class Diary {


   int id = 0;
   String date ='';
   String text ='';
   String image ='';

  Map<String, dynamic> toJson() => {
        'date': date,
        'text': text,
        'image': image,
      };

   Map<String, dynamic> toMap() {
     return {
       'id': id,
       'date': date,
       'text': text,
       'image': image,
     };
   }

}

class DiaryField{

  static String id = 'id';
  static String date = 'date';
  static String text = 'text';
  static String image = 'image';

}
