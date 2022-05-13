import 'package:custom_app/main_screen.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/save_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Constant.bg_color,
        padding: EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Text(
              "Herzlich Willkommen bei",
              style: TextStyle(
                  fontSize: 28,
                  fontFamily: Constant.font_name,
                  color: Colors.orangeAccent),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image(
                  image: AssetImage('assets/app_logo.png'),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Center(
                child: Text(
                  "Mit der Nutzung der App akzeptierst du die" +
                      "\nNutzungsbedingungen und die" +
                      "\nDatenschutzrichtlinien von Euer Wunschkind.",
                  style: TextStyle(
                      fontSize: Constant.HeadingTextSize,
                      fontFamily: Constant.font_name,
                      color: Colors.black),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                goToMain();
              },
              child: Container(
                  padding: EdgeInsets.all(12),
                  margin:
                      EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFE8A62F),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text(
                    "App starten",
                    style: TextStyle(
                      fontFamily: Constant.font_name,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  bool showLockScreen = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    SaveValue.getGoogleId().then((value) => {
          if (value != null)
            {
              // Restore.start(),
            }
        });
  }

  goToMain() {
    SaveValue.setFirstTime(false);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }
}
