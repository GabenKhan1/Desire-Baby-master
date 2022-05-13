import 'package:custom_app/other/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Support extends StatelessWidget {
  const Support({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/support.png'),),
            Text(
              "Wenn ihr Fragen, Anregungen oder auch ein kleines Lob habt, dann schreibt mir eine Email an info@euer-wunschkind.de.",
              style: TextStyle(
                  fontFamily: Constant.font_name,
                  fontSize: Constant.HeadingTextSize),
            ),
          ],
        ));
  }
}
