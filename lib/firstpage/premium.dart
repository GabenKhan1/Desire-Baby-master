import 'package:custom_app/other/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Premium extends StatelessWidget {
  const Premium({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            "Das Herzstück der App ist der Behandlungsplan. In ihm steckt viel Liebe und Arbeit. Als Premiumnutzerin hast du folgende Funktionen zur Verfügung:\n",
            style: TextStyle(
                fontSize: 18,
                fontFamily: Constant.font_name),
          ),
          Text(
            "•\tDokumentation und Archivierung von Terminen und deren Ergebnisse\n" +
                "•\tEinstellung von Medikamenteneinnahmen (mit Erinnerungsfunktion)\n" +
                "•\tEinpflegen von vergangenen Kinderwunschbehandlungen\n" +
                "•\tNutzung des Tagebuches\n" +
                "•\tArtikel zum Thema Kinderwunschbehandlung\n",
            style: TextStyle(
                fontSize: Constant.subHeadingTextSize,
                fontFamily: Constant.font_name),
          ),
          Divider(
            thickness: 2,
            color: Colors.black.withOpacity(0.2),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Expanded(
                    child: PremiumBox(
                  text1: "3,95€",
                  text2: "Monatlich",
                )),
                Expanded(
                    child: PremiumBox(
                  text1: "9,95€",
                  text2: "Halbjährlich",
                )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                    child: PremiumBox(
                  text1: "14,95€",
                  text2: "Jährlich",
                )),
                Expanded(
                    child: PremiumBox(
                  text1: "24,95€",
                  text2: "Einmalig",
                )),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

class PremiumBox extends StatelessWidget {
  final String text1;
  final String text2;

  const PremiumBox({Key key, this.text1, this.text2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
          color: Constant.bar_color,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              text1,
              style: TextStyle(
                color: Colors.black,
                fontSize: Constant.HeadingTextSize,
                fontFamily: Constant.font_name,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              text2,
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: Constant.HeadingTextSize,
                fontFamily: Constant.font_name,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
