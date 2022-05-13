import 'package:custom_app/firstpage/customWigit/dec.dart';
import 'package:custom_app/firstpage/customWigit/heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TermsOfUse extends StatelessWidget {
  String uber =
      '''Die App von Euer Wunschkind wurde für Frauen/Paare entwickelt, die in einer Kinderwunschbehandlung sind. Sie ist vordergründig eine Dokumentationsapp. Die Nutzerin kann ihren Behandlungsplan von der Kinderwunschklinik/-praxis eigenständig in die App übertragen. Medikamenteneinnahmen und Termine, die zum Behandlungsbeginn feststehen, können eingetragen werden. Die Nutzerin kann auch während der Behandlung Ergebnisse und weitere Termine dokumentieren. Termine und Medikamente können mit einer Erinnerungsfunktion eingestellt werden. Nach Beenden des erfolgreichen/erfolglosen Behandlungszyklus kann die Nutzerin die gesamte Behandlung im Archiv abspeichern, später einsehen und auch ergänzen. Die Nutzerin kann auch vergangene Behandlungen einpflegen, sodass sie alle Informationen an einem Ort gespeichert hat. Es werden ICSI, IVF, IUI, GvnP und Kryo-Versuche unterstützt. Im Tagebuch kann die Nutzerin ihre Gedanken festhalten und auch Bilder einfügen. Außerdem kann die Nutzerin verschiedene Artikel rum um die Themen Weiblicher Zyklus und Kinderwunschbehandlung lesen.
Alle Eingaben werden automatisch auf dem Telefon der Nutzerin gespeichert. Damit im Falle der Löschung der App oder dem Verlust des Telefons nicht alle Daten unwiederbringlich verloren gehen, kann man sie zusätzlich über Goggle Drive abspeichern. Weitere Informationen sind in der Datenschutzerklärung zu finden.
Die Nutzung der App von Euer Wunschkind kann einen Arztbesuch nicht ersetzen. Alle Angaben sind ohne Gewähr. Für die Eingaben in der App ist ausschließlich die Nutzerin verantwortlich. Euer Wunschkind kann nicht für fehlerhafte Eingaben der Nutzerin oder fehlerhaft durchgeführte Behandlungen verantwortlich gemacht werden. Die Nutzerin ist jeder Zeit selbst dafür zuständig, ihre Behandlung im Blick zu behalten und ihre Einnahmen gewissenhaft zu organisieren.
''';
  String rules =
      '''Die Nutzung der App von Euer Wunschkind erfolgt auf eigene Verantwortung der Nutzerin. Euer Wunschkind haftet nicht für bestimmte Zwecke oder Ziele, die die Nutzerin mit der App erreichen will. Ich verspreche nicht, dass die Nutzerin mit dem Einsatz der App von Euer Wunschkind eine Schwangerschaft erzielen kann. Ich hafte auch nicht für fehlerhafte Eingaben bei der Erstellung eines Behandlungsplans. Die Nutzerin ist alleinig für die Einnahmen ihrer Medikamente und das Einhalten ihrer Termine verantwortlich. Die App von Euer Wunschkind sollte nicht genutzt werden, wenn man hiermit nicht einverstanden ist. Mein Produkt dient dem Ziel, die Behandlung zu koordinieren und zu dokumentieren. Jedoch nur durch die manuellen Einträge der Nutzerin und nicht automatisch. Es sollte genau darauf geachtet werden, dass alle Eingaben, die vor oder während der Behandlung getätigt werden, richtig sind und immer doppelt überprüft werden. Sollte eine Behandlung allgemein negativ verlaufen, kann Euer Wunschkind nicht dafür verantwortlich gemacht werden. Es kann immer zu technischen Ausfällen kommen. Allgemein ersetzt die App von Euer Wunschkind keine ärztliche Beratung und Behandlung.
Alle Inhalte auf der Website und in der App sind voller Sorgfalt zusammengestellt. Dennoch kann es aus technischen oder anderen Gründen passieren, dass die Informationen und Angaben nicht (mehr) vollständig, aktuell oder zutreffend sind. Euer Wunschkind übernimmt keine Gewähr (weder ausdrücklich noch stillschweigend) für die minutengenaue Richtigkeit, Vollständigkeit, Verlässlichkeit oder Aktualität der in der App veröffentlichten Inhalte.''';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Dec(
            text:
                "Durch das Herunterladen und die Benutzung der App stimmen Sie den Nutzungsbedingungen und den Datenschutzrichtlinien zu. Wenn Sie nicht mit allen Bestimmungen dieser Nutzungsbedingungen oder den Datenschutzrichtlinien einverstanden sind, sollten Sie die App nicht benutzen.\n",
          ),
          Heading(
            text: "Über die App",
          ),
          Dec(
            text: uber,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Heading(
              text:
                  "Regeln zur Haftung für die Nutzung der App von Euer Wunschkind",
            ),
          ),
          Dec(text: rules)
        ],
      ),
    );
  }
}
