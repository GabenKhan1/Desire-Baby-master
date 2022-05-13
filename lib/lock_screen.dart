import 'package:custom_app/save_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';
import 'other/constant.dart';

class LockScreen extends StatefulWidget {
  final bool isGoToMain;

  LockScreen({Key key, this.isGoToMain}) : super(key: key);

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  TextEditingController saveCodeControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sicherheitscode",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: Constant.font_name,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 8,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        obscureText: true,
                        obscuringCharacter: "*",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: Constant.font_name, fontSize: 14),
                        controller: saveCodeControler,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 2),
                            hintText: ''),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (saveCodeControler.text.isEmpty) {
                    showMessage("geben sie ihr sicherheitscode");
                    return;
                  }

                  SaveValue.getCode().then((value) => {
                        if (saveCodeControler.text == value)
                          {
                            Navigator.pop(context),
                            if (widget.isGoToMain)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen())),
                          }
                        else
                          {
                            showMessage("falsch sicherheitscode"),
                          }
                      });
                },
                child: Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 30, right: 30),
                    decoration: BoxDecoration(
                        color: Color(0xFF196319),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      'überprüfen',
                      style: TextStyle(
                        fontFamily: Constant.font_name,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
