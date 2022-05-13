import 'package:custom_app/save_value.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../db/custom_db.dart';
import '../other/constant.dart';

class Backup {
  static var databaseReference = FirebaseDatabase.instance.reference();

  static saveCyclePeriod(AlertDialog pr, BuildContext context) {
    SaveValue.getGoogleId().then((id) => {
          print(id),

          //save diary data
          CustomDB.instance.getDiary().then((value) => {
                for (int i = 0; i < value.length; i++)
                  {
                    databaseReference
                        .child(id)
                        .child(Constant.DIARY)
                        .child(value[i].id.toString())
                        .set(value[i].toMap()),
                    print(i.toString() + ' diary save'),
                  },
                savePeriodData(id, pr, context, value.length),
              }),
        });
  }

  static savePeriodData(
      String id, AlertDialog pr, BuildContext context, int diaryLength) {
    CustomDB.instance.getCyclePeriod().then((v) async => {
          if (v.length == 0)
            {
              print('0 data'),
              Navigator.pop(context),
              showMessage(
                  context,
                  diaryLength == 0
                      ? "No data found!"
                      : "Data backup successfully")
            }
          else
            {
              for (int i = 0; i < v.length; i++)
                {
                  await databaseReference
                      .child(id)
                      .child(Constant.CYCLE_PERIOD)
                      .child(v[i].id.toString())
                      .set(v[i].toMap()),
                  await saveInvestigation(v[i].cycleNumber, id),
                  await saveTreatment(v[i].cycleNumber, id),
                  await saveMedikaments(v[i].cycleNumber, id),
                  print(i),
                },
              print('data saved'),
              Navigator.pop(context),
              showMessage(context, "Data backup successfully")
            }
        });
  }

  static saveInvestigation(int cycleNumber, String id) async {
    CustomDB.instance.getInvestigation(cycleNumber).then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              databaseReference
                  .child(id)
                  .child(Constant.INVESTIGATION)
                  .child(value[i].id.toString())
                  .set(value[i].toMap()),
            }
        });
  }

  static saveTreatment(int cycleNumber, String id) {
    CustomDB.instance.getTreatment(cycleNumber).then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              databaseReference
                  .child(id)
                  .child(Constant.TREATMENT)
                  .child(value[i].id.toString())
                  .set(value[i].toMap()),
            }
        });
  }

  static saveMedikaments(int cycleNumber, String id) {
    CustomDB.instance.getMedikaments(cycleNumber).then((value) => {
          for (int i = 0; i < value.length; i++)
            {
              databaseReference
                  .child(id)
                  .child(Constant.MEDIKAMENTS)
                  .child(value[i].id.toString())
                  .set(value[i].toMap()),
            }
        });
  }

  static saveDiary(String id) async {}

  static showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
