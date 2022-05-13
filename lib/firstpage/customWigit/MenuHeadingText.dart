import 'package:custom_app/other/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuHeadingText extends StatefulWidget {
  final String text;

  const MenuHeadingText({Key key, this.text}) : super(key: key);

  @override
  _MenuHeadingTextState createState() => _MenuHeadingTextState(text);
}

class _MenuHeadingTextState extends State<MenuHeadingText> {
  double topMargin = 10;
  double height = 60;

  final String text;

  _MenuHeadingTextState(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: topMargin, right: 20, left: 20),
      height: height,
      decoration: BoxDecoration(
          color: Constant.bar_color,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: Constant.HeadingTextSize,
            fontFamily: Constant.font_name,
          ),
        ),
      ),
    );
  }
}
