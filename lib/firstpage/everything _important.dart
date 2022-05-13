import 'package:custom_app/other/StringConstant.dart';
import 'package:custom_app/other/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EverythingImportant extends StatelessWidget {
  const EverythingImportant({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: Text(
              "Die App wurde für Frauen/Paare mit Kinderwunsch entwickelt.",
              style: TextStyle(
                  fontSize: Constant.HeadingTextSize, fontFamily: Constant.font_name),
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.black.withOpacity(0.2),
          ),
          Container(
            margin: EdgeInsets.only(right: 15, left: 15, top: 10),
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/icon_1.png'),
                ),
                HeadingText(
                  text: "Kalender",
                ),
              ],
            ),
          ),
          DecText(
            text: StringConstant.Kalender,
          ),
          Container(
            margin: EdgeInsets.only(right: 15, left: 15, top: 10),
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/icon_2.png'),
                ),
                HeadingText(
                  text: "Behandlungsplan",
                ),
              ],
            ),
          ),
          DecText(
            text: StringConstant.Behandlungsplan,
          ),
          Container(
            margin: EdgeInsets.only(right: 15, left: 15, top: 10),
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/icon_3.png'),
                ),
                HeadingText(
                  text: "Tagebuch",
                ),
              ],
            ),
          ),
          DecText(
            text: StringConstant.Tagebuch,
          ),
          Container(
            margin: EdgeInsets.only(right: 15, left: 15, top: 10),
            child: Row(
              children: [
                Image(
                  image: AssetImage('assets/icon_4.png'),
                ),
                HeadingText(
                  text: "Artikel",
                ),
              ],
            ),
          ),
          DecText(
            text: StringConstant.Artikel,
          ),
        ],
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: Constant.font_name, fontSize: Constant.HeadingTextSize, color: Colors.black),
      ),
    );
  }
}

class DecText extends StatelessWidget {
  final String text;

  const DecText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: Constant.font_name, fontSize: Constant.subHeadingTextSize, color: Colors.black),
      ),
    );
  }
}