import 'package:custom_app/other/constant.dart';
import 'package:flutter/cupertino.dart';


class Dec extends StatelessWidget {
  final String text;

  const Dec({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: Text(
          text,
          style: TextStyle(fontSize: Constant.subHeadingTextSize, fontFamily: Constant.font_name),
        ),
      ),
    );
  }
}
