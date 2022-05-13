import 'package:custom_app/other/constant.dart';
import 'package:custom_app/thirdpage/edit.dart';
import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart';

import 'aktueller.dart';
import 'archiv.dart';
import 'neuer.dart';

class ThirdRoute extends StatefulWidget {
  const ThirdRoute({Key key}) : super(key: key);

  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> with WidgetsBindingObserver {
  int index = 0;
  Future<String> permissionStatusFuture;
  String toolbarText = "Behandlungsplan";

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        permissionStatusFuture = getCheckNotificationPermStatus();
      });
    }
  }

  @override
  void initState() {
    permissionStatusFuture = getCheckNotificationPermStatus();
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (index != 0) {
          index = 0;
          toolbarText = "Behandlungsplan";
          setState(() {});
          return Future.value(false);
        }

        return Future.value(true);
      },
      child: Scaffold(
          appBar: index == 0
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
          body: Stack(
            children: [
              index == 0
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (!Constant.isPurchased) {
                                Constant.showPremierMessage(context);
                                return;
                              }
                              /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AktuellerRoute(-1)));*/
                              setState(() {
                                toolbarText = "Aktueller Zyklus";
                                index = 4;
                              });
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 20, right: 20, left: 20),
                              decoration: BoxDecoration(
                                  color: Constant.bar_color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Aktueller Kinderwunschzyklus",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Constant.HeadingTextSize,
                                            fontFamily: Constant.font_name,
                                          ),
                                        )),
                                    Text(
                                      "Hier kannst du deine Einträge zu deinem aktuellen Kinderwunschzyklus einsehen und bearbeiten.",
                                      style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NeuerRoute()))
                            .then((value) => {
                                  if (value != null && value)
                                    {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AktuellerRoute(-1)))
                                    }
                                });*/

                              if (!Constant.isPurchased) {
                                Constant.showPremierMessage(context);
                                return;
                              }
                              index = 5;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 20, left: 20, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Constant.bar_color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Neuer Kinderwunschzyklus",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Constant.HeadingTextSize,
                                            fontFamily: Constant.font_name,
                                          ),
                                        )),
                                    Text(
                                      "Hier kannst du einen neuen Kinderwunschzyklus anlegen.",
                                      style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                index = 3;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 20, left: 20),
                              decoration: BoxDecoration(
                                  color: Constant.bar_color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Archiv",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: Constant.HeadingTextSize,
                                            fontFamily: Constant.font_name,
                                          ),
                                        )),
                                    Text(
                                      "Hier kannst du vergangene Kinderwunschzyklen einsehen.",
                                      style: TextStyle(
                                          fontFamily: Constant.font_name,
                                          fontSize: 14,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              index == 3 ? ArchiRoute() : Container(),
              index == 4
                  ? AktuellerRoute(-1, () {
                      setState(() {
                        index = 6;
                      });
                    })
                  : Container(),
              index == 5
                  ? NeuerRoute(
                      onChangeFunction: () {
                        setState(() {
                          index = 4;
                        });
                      },
                    )
                  : Container(),
              index == 6 ? Edit() : Container()
            ],
          )),
    );
  }

  Future<String> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus()
        .then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return permDenied;
        case PermissionStatus.granted:
          return permGranted;
        case PermissionStatus.unknown:
          return permUnknown;
        case PermissionStatus.provisional:
          return permProvisional;
        default:
          return null;
      }
    });
  }
}
