import 'package:custom_app/firstpage/customWigit/dec.dart';
import 'package:custom_app/firstpage/customWigit/heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Impressum extends StatelessWidget {
  String liability =
      '''Als Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene Inhalte auf diesen Seiten nach den allgemeinen Gesetzen verantwortlich. Nach §§ 8 bis 10 TMG sind wir als Diensteanbieter jedoch nicht verpflichtet, übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach Umständen zuforschen, die auf eine rechtswidrige Tätigkeit hinweisen.Verpflichtungen zur Entfernung oder Sperrung der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt. Eine diesbezügliche Haftung ist jedoch erst ab dem Zeitpunkt der Kenntnis einer konkreten Rechtsverletzung möglich. Bei Bekanntwerden von entsprechenden Rechtsverletzungen werden wir diese Inhalte umgehend entfernen.''';
  String copyright =
      '''Die durch die Seitenbetreiber erstellten Inhalte und Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers. Downloads und Kopien dieser Seite sind nur für den privaten, nicht kommerziellen Gebrauch gestattet. Soweit die Inhalte auf dieser Seite nicht vom Betreiber erstellt wurden, werden die Urheberrechte Dritter beachtet. Insbesondere werden Inhalte Dritter als solche gekennzeichnet. Sollten Sie trotzdem auf eineUrheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Inhalte umgehend entfernen.''';
  String dateProtection = '''JAHN Rechtsanwälte
Sandeldamm 24A
63450 Hanau
''';
  String photoCredit = '''https://pixabay.com/de/
https://www.pexels.com/de-de''';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Heading(text: "Angaben gemäß § 5 TMG"),
          Dec(
            text: '''Euer Wunschkind
Anja Albert
Hadrianstraße 33
61130 Nidderau
Mobil: 0170/4391716
E-Mail: info@euer-wunschkind.de
Homepage: www.euer-wunschkind.de
''',
          ),
          Heading(text: "Verantwortlich für den Inhalt nach § 55 Abs. 2 RStV"),
          Dec(
            text: '''Anja Albert
Hadrianstraße 33
61130 Nidderau
''',
          ),
          Heading(
            text: "Haftung für Inhalte",
          ),
          Dec(
            text: liability,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Heading(
              text: "Urheberrecht",
            ),
          ),
          Dec(
            text: copyright,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Heading(
              text: "Datenschutzerklärung",
            ),
          ),
          Dec(
            text: dateProtection,
          ),
          Heading(
            text: "Bildnachweis",
          ),
          Dec(
            text: photoCredit,
          ),
        ],
      ),
    );
  }
}
