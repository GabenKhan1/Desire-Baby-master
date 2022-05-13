import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:firebase_database/firebase_database.dart';

import '../save_value.dart';

class Restore {
  static var databaseReference = FirebaseDatabase.instance.reference();

  static start() async {

    //hendle duplication
    await getCyclePeriod();
    await getInvestigation();
    await getTreatment();
    await getMedikaments();
    print("all restore");

  }

  static getCyclePeriod() {
    SaveValue.getGoogleId().then((id) => {
          databaseReference
              .child(id)
              .child(Constant.CYCLE_PERIOD)
              .once()
              .then((DataSnapshot snapshot) {
            for (var value in snapshot.value) {
              if (value != null) {
                Map<String, dynamic> myMap =
                    new Map<String, dynamic>.from(value);
                myMap['id'] = null;
                CustomDB.instance.addCyclePeriodWithString(myMap);
              }
            }
          }),
        });
  }

  static getTreatment() {
    SaveValue.getGoogleId().then((id) => {
      databaseReference
          .child(id)
          .child(Constant.TREATMENT)
          .once()
          .then((DataSnapshot snapshot) {
        for (var value in snapshot.value) {
          if (value != null) {
            Map<String, dynamic> myMap =
            new Map<String, dynamic>.from(value);
            myMap['id'] = null;
            CustomDB.instance.addTreatmentWithString(myMap);
          }
        }
      }),
    });
  }

  static getInvestigation() {
    SaveValue.getGoogleId().then((id) => {
      databaseReference
          .child(id)
          .child(Constant.INVESTIGATION)
          .once()
          .then((DataSnapshot snapshot) {
        for (var value in snapshot.value) {
          if (value != null) {
            Map<String, dynamic> myMap =
            Map<String, dynamic>.from(value);
            myMap['id'] = null;
            CustomDB.instance.addInvestigationWithString(myMap);
          }
        }
      }),
    });
  }


  static getMedikaments() {
    SaveValue.getGoogleId().then((id) => {
      databaseReference
          .child(id)
          .child(Constant.MEDIKAMENTS)
          .once()
          .then((DataSnapshot snapshot) {
        for (var value in snapshot.value) {
          if (value != null) {
            Map<String, dynamic> myMap =
            Map<String, dynamic>.from(value);
            myMap['id'] = null;
            CustomDB.instance.addMedikamentsWithString(myMap);
          }
        }
      }),
    });
  }


}
