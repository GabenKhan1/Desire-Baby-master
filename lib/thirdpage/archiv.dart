import 'package:custom_app/db/custom_db.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/thirdpage/model/cycle_period.dart';
import 'package:flutter/material.dart';

import 'aktueller.dart';

class ArchiRoute extends StatefulWidget {
  const ArchiRoute({
    Key key,
  }) : super(key: key);

  @override
  _ArchiRouteState createState() => _ArchiRouteState();
}

class _ArchiRouteState extends State<ArchiRoute> {
  List<CyclePeriodData> list;
  int selectedCycleNumber = -1;
  String toolbarText = "Archiv";

  @override
  void initState() {
    super.initState();

    CustomDB.instance.getCyclePeriod().then((value) => {
          value.sort((a, b) {
            DateTime aDate = DateTime.parse(a.startDate.split(".")[2] +
                "-" +
                a.startDate.split(".")[1] +
                "-" +
                a.startDate.split(".")[0] +
                ' 00:00:00.000');
            DateTime bDate = DateTime.parse(b.startDate.split(".")[2] +
                "-" +
                b.startDate.split(".")[1] +
                "-" +
                b.startDate.split(".")[0] +
                ' 00:00:00.000');

            // return aDate.compareTo(bDate);
            return bDate.compareTo(aDate);
          }),
          setState(() {
            list = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: selectedCycleNumber == -1
            ? AppBar(
                title: Text(
                  toolbarText,
                  style: TextStyle(
                      color: Color(Constant.toolbar_text_color),
                      fontFamily: Constant.font_name),
                ),
                centerTitle: true,
                backgroundColor: Color(Constant.toolbar_color),
                automaticallyImplyLeading: false,
              )
            : null,
        body: selectedCycleNumber == -1
            ? ListView.builder(
                itemCount: list == null ? 0 : list.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AktuellerRoute(list[index].cycleNumber)))
                .then((value) => {
                      CustomDB.instance.getCyclePeriod().then((value) => {
                            setState(() {
                              list = value;
                            })
                          })
                    });*/

                      setState(() {
                        selectedCycleNumber = list[index].cycleNumber;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10, right: 20, left: 20),
                      decoration: BoxDecoration(
                          color: Constant.bar_color,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              list[index].typeOfTreatment,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Constant.HeadingTextSize,
                                fontFamily: Constant.font_name,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              list[index].startDate +
                                  " - " +
                                  list[index].endDate,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: Constant.subHeadingTextSize,
                                fontFamily: Constant.font_name,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : AktuellerRoute(selectedCycleNumber, () {})
        /*AktuellerRoute(cycleNumber:selectedCycleNumber , onChangeFunction: () {

        })*/
        );
  }
}
