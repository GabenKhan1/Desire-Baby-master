import 'dart:ui';

import 'package:custom_app/alaramTimeDialog/model/alarm_time.dart';
import 'package:custom_app/other/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final List<AlarmTime> timeList;
  final int limit;
  final void Function(String time, String name) onTimeSelect;
  final void Function() onLimitExceed;

  const CustomDialogBox({
    Key key,
    this.timeList,
    this.limit,
    this.onTimeSelect,
    this.onLimitExceed,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  List<AlarmTime> filterUser;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  @override
  void initState() {
    super.initState();
    filterUser = widget.timeList;
  }

  contentBox(context) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.only(right: 10),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text("Wählen Sie Maximum ${widget.limit}"))),
            Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: filterUser.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CheckboxListTile(
                          title: Text(
                            filterUser[index].name,
                            style: TextStyle(
                                fontFamily: Constant.font_name,
                                fontSize: Constant.subHeadingTextSize),
                          ),
                          value: filterUser[index].isChecked,
                          activeColor: Colors.blueGrey[200],
                          checkColor: const Color(0xff00363A),
                          onChanged: (val) {
                            setState(
                              () {
                                filterUser[index].isChecked = val;
                              },
                            );
                          },
                        ),
                      ],
                    );
                  }),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  String time = "";
                  String name = "";
                  int selectedUser = 0;
                  for (int i = 0; i < filterUser.length; i++) {
                    if (filterUser[i].isChecked) {
                      time = filterUser[i].time;
                      name = filterUser[i].name;
                      ++selectedUser;
                    }
                  }

                  if (selectedUser > widget.limit) {
                    widget.onLimitExceed();
                    return;
                  }
                  widget.onTimeSelect(time, name);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 20, bottom: 20, top: 10),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Speichern",
                        style: TextStyle(
                            fontSize: 18, color: Color(Constant.toolbar_color)),
                        textAlign: TextAlign.end,
                      )),
                ),
              ),
            ),
          ],
        ));
  }

// Future<List<LeaveTypeId>> changeUserData(List<LeaveTypeId> userSearchList) async {
//   return userSearchList;
// }
}
