import 'package:custom_app/other/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DesireChild extends StatelessWidget {
  const DesireChild({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child:
                    Image(image: AssetImage('assets/desire_child_banner.jpg'))),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "Ich heiße Anja und bin die Gründerin von Euer Wunschkind. Ich arbeite als Therapeutin und bin privat mit dem Thema Kinderwunschbehandlung in Kontakt gekommen.\n" +
                  "Nach einem Jahr natürlicher Familienplanung ohne Schwangerschaft wandten sich mein Freund und ich an eine Kinderwunschklinik. Dort sammelte ich erste Erfahrungen im Bereich Kinderwunschbehandlung. In dieser Zeit war ich auch in einigen Socialmedia-Gruppen, die auf dieses Thema ausgelegt waren, aktiv und war überrascht, wieviele Paare die gleichen Probleme hatten. Als dann unsere Behandlung begann, suchte ich eine spezielle App, wo man seine Behandlungen dokumentieren könnte. Leider war die Auswahl im App-Store nicht sehr groß. So entstand die Idee für die App von Euer Wunschkind. Durch eigene Erfahrungen und von mir erstellten Umfragen entwickelte sich langsam ein Konzept und mittels fachmännischer Unterstützung bezüglich Design und Programmierung konnte aus einer Idee eine Kinderwunsch-App werden.\n" +
                  "\n" +
                  "Ich hoffe, dass viele Frauen ihre Freude an dieser App haben und sie für ihren Weg zum Wunschkind nutzen können.\n",
              style: TextStyle(
                  fontFamily: Constant.font_name,
                  fontSize: Constant.subHeadingTextSize,
                  color: Colors.black),
            ),
          ),
          Text(
          "\"Die Herausforderung besteht darin, niemals die Hoffnung zu verlieren.\"",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: Constant.font_name,
                fontSize: Constant.subHeadingTextSize,
                color: Colors.black),
          )
        ],
      ),
    );
  }
}
