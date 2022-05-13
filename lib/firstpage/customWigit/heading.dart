import 'package:custom_app/other/constant.dart';
import 'package:flutter/cupertino.dart';

class Heading extends StatelessWidget {
  final String text;

  const Heading({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            fontSize: 17,
            fontFamily: Constant.font_name,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
