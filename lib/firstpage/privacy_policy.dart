import 'package:custom_app/firstpage/customWigit/heading.dart';
import 'package:custom_app/firstpage/customWigit/dec.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class PrivacyPolicy extends StatelessWidget {
  String vorwort =
      '''Ich, Anja Albert von Euer Wunschkind, Hadrianstraße 33, 61130 Nidderau, nehme den Schutz Ihrer personenbezogenen Daten ernst und möchte Sie an dieser Stelle über den Datenschutz in meinem Unternehmen informieren.
  Mir sind im Rahmen meiner datenschutzrechtlichen Verantwortlichkeit durch das Inkrafttreten der EU-Datenschutz-Grundverordnung (Verordnung (EU) 2016/679; nachfolgend: "DS-GVO") zusätzliche Pflichten auferlegt worden, um den Schutz personenbezogener Daten der von einer Verarbeitung betroffenen Person (ich spreche Sie als betroffene Person nachfolgend auch mit "Kunde", "Nutzer", "Sie", "Ihnen" oder "Betroffener" an) sicherzustellen.
  Soweit ich entweder alleine oder gemeinsam mit Anderen über die Zwecke und Mittel der Datenverarbeitung entscheide, umfasst dies vor allem die Pflicht, Sie transparent über Art, Umfang, Zweck, Dauer und Rechtsgrundlage der Verarbeitung zu informieren (vgl. Art. 13 und Art. 14 DSGVO). Mit dieser Erklärung (nachfolgend: "Datenschutzhinweise") informiere ich Sie darüber, in welcher Weise Ihre personenbezogenen Daten von mir verarbeitet werden.
  Sie können diese Datenschutzerklärung jederzeit unter dem Menüeintrag „Datenschutz“ innerhalb der App aufrufen.
  ''';

  String allgemeines = '''
  1.	Begriffsbestimmungen
Nach dem Vorbild des Art. 4 DS-GVO liegen dieser Datenschutzhinweise folgende Begriffsbestimmungen zugrunde:
• "Personenbezogene Daten" (Art. 4 Nr. 1 DS-GVO) sind alle Informationen, die sich auf eine identifizierte oder identifizierbare natürliche Person ("Betroffener") beziehen. Identifizierbar ist eine Person, wenn sie direkt oder indirekt, insbesondere mittels Zuordnung zu einer Kennung wie einem Namen, einer Kennnummer, einer Online-Kennung, Standortdaten oder mithilfe von Informationen zu ihren physischen, physiologischen, genetischen, psychischen, wirtschaftlichen, kulturellen oder sozialen Identitätsmerkmalen identifiziert werden kann. Die Identifizierbarkeit kann auch mittels einer Verknüpfung von derartigen Informationen oder anderem Zusatzwissen gegeben sein. Auf das Zustandekommen, die Form oder die Verkörperung der Informationen kommt es nicht an (auch Fotos, Video- oder Tonaufnahmen können personenbezogene Daten enthalten).
• "Verarbeiten" (Art. 4 Nr. 2 DS-GVO) ist jeder Vorgang, bei dem mit personenbezogenen Daten umgegangen wird, gleich ob mit oder ohne Hilfe automatisierter (dh technikgestützter) Verfahren. Dies umfasst insbesondere das Erheben (dh die Beschaffung), das Erfassen, die Organisation, das Ordnen, die Speicherung, die Anpassung oder Veränderung, das Auslesen, das Abfragen, die Verwendung, die Offenlegung durch Übermittlung, die Verbreitung oder sonstige Bereitstellung, den Abgleich, die Verknüpfung, die Einschränkung, das Löschen oder die Vernichtung von personenbezogenen Daten sowie die Änderung einer Ziel- oder Zweckbestimmung, die einer Datenverarbeitung ursprünglich zugrunde gelegt wurde.
• "Verantwortlicher" (Art. 4 Nr. 7 DS-GVO) ist die natürliche oder juristische Person, Behörde, Einrichtung oder andere Stelle, die allein oder gemeinsam mit anderen über die Zwecke und Mittel der Verarbeitung von personenbezogenen Daten entscheidet.
• "Dritter" (Art. 4 Nr. 10 DS-GVO) ist jede natürliche oder juristische Person, Behörde, Einrichtung oder andere Stelle außer dem Betroffenen, dem Verantwortlichen, dem Auftragsverarbeiter und den Personen, die unter der unmittelbaren Verantwortung des Verantwortlichen oder Auftragsverarbeiters befugt sind, die personenbezogenen Daten zu verarbeiten; dazu gehören auch andere konzernangehörige juristische Personen.
• "Auftragsverarbeiter" (Art. 4 Nr. 8 DS-GVO) ist eine natürliche oder juristische Person, Behörde, Einrichtung oder andere Stelle, die personenbezogene Daten im Auftrag des Verantwortlichen, insbesondere gemäß dessen Weisungen, verarbeitet (z. B. ITDienstleister). Im datenschutzrechtlichen Sinne ist ein Auftragsverarbeiter insbesondere kein Dritter.
• "Einwilligung" (Art. 4 Nr. 11 DS-GVO) der betroffenen Person bezeichnet jede freiwillig für den bestimmten Fall, in informierter Weise und unmissverständlich abgegebene Willensbekundung in Form einer Erklärung oder einer sonstigen eindeutigen bestätigenden Handlung, mit der die betroffene Person zu verstehen gibt, dass sie mit der Verarbeitung der sie betreffenden personenbezogenen Daten einverstanden ist.

2. Änderung der Datenschutzhinweise
(1) Im Rahmen der Fortentwicklung des Datenschutzrechts sowie technologischer oder organisatorischer Veränderungen werden meine Datenschutzhinweise regelmäßig auf Anpassungsoder Ergänzungsbedarf hin überprüft.
(2) Diese Datenschutzhinweise haben den Stand vom 15.04.2021.
(3) Keine Verpflichtung zur Bereitstellung personenbezogener Daten:
Ich mache den Abschluss von Verträgen mit mir nicht davon abhängig, dass Sie mir zuvor personenbezogene Daten bereitstellen. Für Sie als Kunde besteht grundsätzlich auch keine gesetzliche oder vertragliche Verpflichtung, mir Ihre personenbezogenen Daten zur Verfügung zu stellen; es kann jedoch sein, dass ich bestimmte Angebote nur eingeschränkt oder gar nicht erbringen kann, wenn Sie die dafür erforderlichen Daten nicht bereitstellen. Sofern dies im Rahmen der nachfolgend vorgestellten, von mir angebotenen Produkte ausnahmsweise der Fall sein sollte, werden Sie gesondert darauf hingewiesen.
 ''';

  String informationen =
      '''1.	Die Erhebung Sie betreffender personenbezogener Daten
(1) Bei der Nutzung meiner App werden von mir personenbezogene Daten über Sie erhoben.
(2) Personenbezogene Daten sind alle Daten, die sich auf Ihre Person beziehen (siehe oben unter Allgemeines). Beispielsweise handelt es sich bei Ihrem Namen, Ihrer Standortdaten, Ihre IP-Adresse, die Gerätekennung, die SIM-Kartennummer, Ihrer Adresse sowie E-Mail-Adresse um personenbezogene Daten, Ihr Fingerabdruck, Bilder, Filme, Audioaufnahmen, aber auch Ihr Nutzerverhalten fällt in diese Kategorie.

2.	Rechtsgrundlagen der Datenverarbeitung
(1) Von Gesetzes wegen ist im Grundsatz jede Verarbeitung personenbezogener Daten verboten und nur dann erlaubt, wenn die Datenverarbeitung unter einen der folgenden Rechtfertigungstatbestände fällt:
• Art. 6 Abs. 1 S. 1 lit. a DS-GVO ("Einwilligung"): Wenn der Betroffene freiwillig, in informierter Weise und unmissverständlich durch eine Erklärung oder eine sonstige eindeutige bestätigende Handlung zu verstehen gegeben hat, dass er mit der Verarbeitung der ihn betreffenden personenbezogenen Daten für einen oder mehrere bestimmte Zwecke einverstanden ist.
• Art. 6 Abs. 1 S. 1 lit. b DS-GVO: Wenn die Verarbeitung zur Erfüllung eines Vertrags, dessen Vertragspartei der Betroffene ist, oder zur Durchführung vorvertraglicher Maßnahmen erforderlich ist, die auf die Anfrage des Betroffenen erfolgen.
• Art. 6 Abs. 1 S. 1 lit. c DS-GVO: Wenn die Verarbeitung zur Erfüllung einer rechtlichen Verpflichtung erforderlich ist, der der Verantwortliche unterliegt (zB eine gesetzliche Aufbewahrungspflicht).
• Art. 5 Abs. 1 S. 1 lit. d DS-GVO: Wenn die Verarbeitung erforderlich ist, um lebenswichtige Interessen des Betroffenen oder einer anderen natürlichen Person zu schützen.
• Art. 6 Abs. 1 S. 1 lit. e DS-GVO: Wenn die Verarbeitung für die Wahrnehmung einer Aufgabe erforderlich ist, die im öffentlichen Interesse liegt oder in Ausübung öffentlicher Gewalt erfolgt, die dem Verantwortlichen übertragen wurde oder
• Art. 6 Abs. 1 S. 1 lit. f DS-GVO ("Berechtigte Interessen"): Wenn die Verarbeitung zur Wahrung berechtigter (insbesondere rechtlicher oder wirtschaftlicher) Interessen des Verantwortlichen oder eines Dritten erforderlich ist, sofern nicht die gegenläufigen Interessen oder Rechte des Betroffenen überwiegen (insbesondere dann, wenn es sich dabei um einen Minderjährigen handelt).
(2) Für die von uns vorgenommenen Verarbeitungsvorgänge geben wir im Folgenden jeweils die anwendbare Rechtsgrundlage an. Eine Verarbeitung kann auch auf mehreren Rechtsgrundlagen beruhen.

3.	Erforderliche Berechtigungen
Damit die App ordnungsgemäß funktionieren kann, ist es notwendig, dass Sie den Zugriff auf bestimmte Smartphone-Funktionen und personenbezogene Daten gewähren, die auf dem Gerät gespeichert werden. So werden Sie einmalig zu Beginn oder auch erst bei Nutzung der jeweiligen Funktion aufgefordert, die entsprechende Zugriffsberechtigung zu erteilen.
(1) Kamera
Um in dem Bereich Tagebuch Bilder hinzufügen zu können wird der Zugriff auf Ihre systemseitige Kamera und Galerie benötigt.
(2) Kalender
Im Bereich Kalender kann man Termine mit Erinnerungsfunktion einstellen (Push-Up-Nachrichten).

4.	Die beim Download erhobenen Daten
(1) Beim Download dieser App werden bestimmte dafür erforderlichen Daten zu Ihrer Person an den entsprechenden App Store (zB Apple App Store oder Google Play) übermittelt.
(2) Insbesondere werden beim Herunterladen die E-Mail-Adresse, der Nutzername, die Kundennummer des herunterladenden Accounts, die individuelle Gerätekennziffer, Zahlungsinformationen sowie der Zeitpunkt des Downloads an den App Store übertragen. (3) Auf die Erhebung und Verarbeitung dieser Daten habe ich keinen Einfluss, sie erfolgt vielmehr ausschließlich durch den von Ihnen ausgewählten App Store. Dementsprechend bin ich für diese Erhebung und Verarbeitung nicht verantwortlich; die Verantwortung dafür liegt allein beim App Store.

5.	Bei der Nutzung erhobenen Daten
(1) Die Vorzüge meiner App kann ich Ihnen zwangsläufig nur zur Verfügung stellen, wenn bei der Nutzung von mir bestimmte, für den App-Betrieb erforderliche Daten zu Ihrer Person erhoben werden.
(2) Ich erhebe diese Daten nur, wenn dies für die Erfüllung des Vertrags zwischen Ihnen und mir erforderlich ist (Art. 6 Abs. 1 lit. b DS-GVO). Ferner erhebe ich diese Daten, wenn dies für die Funktionsfähigkeit der App erforderlich ist und Ihr Interesse am Schutz Ihrer personenbezogenen Daten nicht überwiegt (Art. 6 Abs. 1 lit. f DS-GVO).
(3) Ich erhebe und verarbeite folgende Daten von Ihnen:
Geräteinformationen: Zu den Zugriffsdaten gehören die IP-Adresse, Geräte-ID, Geräteart, gerätespezifische Einstellungen und App-Einstellungen sowie App-Eigenschaften, das Datum und die Uhrzeit des Abrufs, Zeitzone die übertragene Datenmenge und die Meldung, ob der Datenaustausch vollständig war, Absturz der App, Browserart und Betriebssystem. Diese Zugriffsdaten werden verarbeitet, um den Betrieb der App technisch zu ermöglichen

6.	Social Media Plugins Facebook
In meiner App können Sie über einen Link auf Facebook gelangen.
Wenn Sie über meine App den Link auswählen, baut Ihr Browser eine direkte Verbindung mit den Servern von Facebook auf. Der Inhalt wird von Facebook direkt an Ihren Browser übermittelt und von diesem in die Webseite eingebunden.
Durch das Klicken erhält Facebook die Information, dass Ihr Browser die entsprechende Seite unseres Webauftritts aufgerufen hat, auch wenn Sie kein Facebook-Konto besitzen oder gerade nicht bei Facebook eingeloggt sind. Diese Information (einschließlich Ihrer IP-Adresse) wird von Ihrem Browser direkt an einen Server von Facebook in den USA übermittelt und dort gespeichert.
Sind Sie bei Facebook eingeloggt, kann Facebook den Besuch meiner Website Ihrem Facebook-Konto direkt zuordnen. Wenn Sie mit den Plugins interagieren, zum Beispiel den „LIKE“ oder „TEILEN“- Button betätigen, wird die entsprechende Information ebenfalls direkt an einen Server von Facebook übermittelt und dort gespeichert. Die Informationen werden zudem auf Facebook veröffentlicht und Ihren Facebook-Freunden angezeigt.
Facebook kann diese Informationen zum Zwecke der Werbung, Marktforschung und bedarfsgerechten Gestaltung der Facebook-Seiten benutzen. Hierzu werden von Facebook Nutzungs- , Interessen- und Beziehungsprofile erstellt, z. B. um Ihre Nutzung unserer Website im Hinblick auf die Ihnen bei Facebook eingeblendeten Werbeanzeigen auszuwerten, andere Facebook-Nutzer über Ihre Aktivitäten auf unserer Website zu informieren und um weitere mit der Nutzung von Facebook verbundene Dienstleistungen zu erbringen.
Wenn Sie nicht möchten, dass Facebook die über meinen Webauftritt gesammelten Daten Ihrem Facebook-Konto zuordnet, müssen Sie sich vor Ihrem Besuch meiner Website bei Facebook ausloggen. Sie können das Laden der Facebook Plugins und damit die oben beschriebenen Datenverarbeitungsvorgänge auch mit Add-Ons für Ihren Browser für die Zukunft widersprechen, z.B. mit dem Skript-Blocker „NoScript“ (http://noscript.net/).
Zweck und Umfang der Datenerhebung und die weitere Verarbeitung und Nutzung der Daten durch Facebook sowie Ihre diesbezüglichen Rechte und Einstellungsmöglichkeiten zum Schutz Ihrer Privatsphäre entnehmen Sie bitte den Datenschutzhinweisen (https://www.facebook.com/about/privacy/) von Facebook.

7.	Datenspeicherung
Eine Speicherung der von Ihnen in der App eingegeben Daten findet weder von mir noch extern statt. Die von Ihnen eingegeben Daten werden lediglich auf dem Smartphone bzw. auf dem Google-Konto des Nutzers (z.Bsp. mittels Google-Drive) gespeichert.

8.	Datensicherheit
Ich bediene mich geeigneter technischer und organisatorischer Sicherheitsmaßnahmen, um Ihre Daten gegen zufällige oder vorsätzliche Manipulationen, teilweisen oder vollständigen Verlust, Zerstörung oder gegen den unbefugten Zugriff Dritter zu schützen unter Berücksichtigung des Stands der Technik, der Implementierungskosten und der Natur, des Umfangs, des Kontextes und des Zwecks der Verarbeitung sowie der bestehenden Risiken einer Datenpanne (inklusive von deren Wahrscheinlichkeit und Auswirkungen) für den Betroffenen. Meine Sicherheitsmaßnahmen werden entsprechend der technologischen Entwicklung fortlaufend verbessert. Nähere Informationen hierzu erteile ich Ihnen auf Anfrage gerne.

9.	Keine automatisierte Entscheidungsfindung (einschließlich Profiling)
Ich habe nicht die Absicht, von Ihnen erhobene personenbezogene Daten für ein Verfahren zur automatisierten Entscheidungsfindung (einschließlich Profiling) zu verwenden.

10.	Zweckänderung
(1) Verarbeitungen Ihrer personenbezogenen Daten zu anderen als den beschriebenen Zwecken erfolgen nur, soweit eine Rechtsvorschrift dies erlaubt oder Sie in den geänderten Zweck der Datenverarbeitung eingewilligt haben.
(2) Im Falle einer Weiterverarbeitung zu anderen Zwecken als denen, für den die Daten ursprünglich erhoben worden sind, informieren ich Sie vor der Weiterverarbeitung über diese anderen Zwecke und stelle Ihnen sämtliche weitere hierfür maßgeblichen Informationen zur Verfügung.

  ''';

  String verantwortlichkeit = '''
1.	Verantwortlicher und Kontaktdaten
(1) Die für die Verarbeitung Ihrer personenbezogenen Daten verantwortliche Stelle im Sinne des Art. 4 Nr. 7 DS-GVO bin ich

	Euer Wunschkind
Anja Albert
Hadrianstraße 33
61130 Nidderau
Tel.: 0170/4391716
E-Mail: info@euer-wunschkind.de

(2) Wenden Sie sich an die vorbenannte Kontaktstelle insbesondere, wenn Sie die Ihnen zustehenden Rechte, die unter Kapitel F erläutert werden, mir gegenüber geltend machen wollen.
(3) Bei weiteren Fragen oder Anmerkungen zur Erhebung und Verarbeitung Ihrer personenbezogenen Daten wenden Sie sich ebenfalls an die vorbenannte Kontaktstelle.

2. Datenerhebung bei der Kontaktaufnahme
(1) Wenn Sie mit mir per E-Mail Kontakt aufnehmen, dann werden Ihre E-Mail-Adresse, Ihr Name und alle weiteren personenbezogenen Daten, die Sie im Zuge der Kontaktaufnahme angegeben haben, von mir gespeichert, damit ich mit Ihnen zur Beantwortung der Frage Kontakt aufnehmen kann.
(2) Diese Daten lösche ich, sobald die Speicherung nicht mehr erforderlich ist. Liegen gesetzliche Aufbewahrungsfristen vor, bleiben die Daten zwar gespeichert, aber ich schränke die Verarbeitung ein.
  ''';

  String datenverarbeitung = '''
1.	Auftragsdatenverarbeitung
(1) Es kann vorkommen, dass für einzelne Funktionen meine App auf beauftragte Dienstleister zurückgegriffen wird. Wie bei jedem größeren Unternehmen, setze auch ich zur Abwicklung unseres Geschäftsverkehrs externe in- und ausländische Dienstleister ein (z. B. für die Bereiche IT, Logistik, Telekommunikation, Vertrieb und Marketing). Diese werden nur nach meiner Weisung tätig und wurden iSv Art. 28 DS-GVO vertraglich dazu verpflichtet, die datenschutzrechtlichen Bestimmungen einzuhalten.
(2) Folgende Kategorien von Empfängern, bei denen es sich im Regelfall um Auftragsverarbeiter handelt, erhalten ggf. Zugriff auf Ihre personenbezogenen Daten:
• Dienstleister für den Betrieb unserer App und die Verarbeitung der durch die Systeme gespeicherten oder übermittelten Daten (zB für Rechenzentrumsleistungen, Zahlungsabwicklungen, IT-Sicherheit). Rechtsgrundlage für die Weitergabe ist dann Art. 6 Abs. 1 S. 1 lit. b oder lit. f DS-GVO, soweit es sich nicht um Auftragsverarbeiter handelt;
• Staatliche Stellen/Behörden, soweit dies zur Erfüllung einer gesetzlichen Verpflichtung erforderlich ist. Rechtsgrundlage für die Weitergabe ist dann Art. 6 Abs. 1 S. 1 lit. c DS-GVO;
• Zur Durchführung meines Geschäftsbetriebs eingesetzte Personen (zB Auditoren, Banken, Versicherungen, Rechtsberater, Aufsichtsbehörden, Beteiligte bei Unternehmenskäufen oder der Gründung von Gemeinschaftsunternehmen). Rechtsgrundlage für die Weitergabe ist dann Art. 6 Abs. 1 S. 1 lit. b oder lit. f DS-GVO.
(3) Darüber hinaus gebe ich Ihre personenbezogenen Daten nur an Dritte weiter, wenn Sie nach Art. 6 Abs. 1 S. 1 lit. a DS-GVO eine ausdrückliche Einwilligung dazu erteilt haben.
 
2.	Voraussetzungen der Weitergabe von personenbezogenen Daten an Drittländer
(1) Im Rahmen unserer Geschäftsbeziehungen können Ihre personenbezogenen Daten an Drittgesellschaften weitergegeben oder offengelegt werden. Diese können sich auch außerhalb des Europäischen Wirtschaftsraums (EWR), also in Drittländern, befinden. Eine derartige Verarbeitung erfolgt ausschließlich zur Erfüllung der vertraglichen und geschäftlichen Verpflichtungen und zur Pflege Ihrer Geschäftsbeziehung zu mir. Über die jeweiligen Einzelheiten der Weitergabe unterrichte ich Sie nachfolgend an den dafür relevanten Stellen.
(2) Einigen Drittländern bescheinigt die Europäische Kommission durch sog. Angemessenheitsbeschlüsse einen Datenschutz, der dem EWR-Standard vergleichbar ist (eine Liste dieser Länder sowie eine Kopie der Angemessenheitsbeschlüsse erhalten Sie hier: http://ec.europa.eu/justice/data-protection/international-transfers/adequacy/index_en.html). In anderen Drittländern, in die ggf. personenbezogene Daten übertragen werden, herrscht aber unter Umständen wegen fehlender gesetzlicher Bestimmungen kein durchgängig hohes Datenschutzniveau. Soweit dies der Fall ist, achte ich darauf, dass der Datenschutz ausreichend gewährleistet ist. Möglich ist dies über bindende Unternehmensvorschriften, StandardVertragsklauseln der Europäischen Kommission zum Schutz personenbezogener Daten, Zertifikate oder anerkannte Verhaltenskodizes. Bitte wenden Sie sich an unseren Datenschutzbeauftragten (siehe D. 1.), wenn Sie hierzu nähere Informationen erhalten möchten.

3.	Gesetzliche Verpflichtung zur Übermittlung bestimmter Daten
Ich kann unter Umständen einer besonderen gesetzlichen oder rechtlichen Verpflichtung unterliegen, die rechtmäßig verarbeiteten personenbezogenen Daten für Dritte, insbesondere öffentlichen Stellen, bereitzustellen (Art. 6 Abs. 1 S. 1 lit. c DS-GVO).
 ''';

  String ihre = '''
  1. Auskunftsrecht
(1) Sie haben mir gegenüber das Recht im Umfang von Art. 15 DS-GVO, Auskunft über die Sie betreffenden personenbezogenen Daten zu erhalten.
(2) Hierfür ist ein Antrag von Ihnen erforderlich, der entweder per E-Mail oder postalisch an die oben angegebenen Adressen (siehe D. 1.) zu senden ist.

2. Recht auf Widerspruch gegen die Datenverarbeitung und Widerruf der Einwilligung
(1) Sie haben gemäß Art. 21 DS-GVO das Recht, jederzeit gegen die Verarbeitung Sie betreffender personenbezogener Daten Widerspruch einzulegen. Ich werde die Verarbeitung Ihrer personenbezogenen Daten einstellen, es sei denn, ich kann zwingende schutzwürdige Gründe für die Verarbeitung nachweisen, die Ihre Interessen, Rechte und Freiheiten überwiegen, oder wenn die Verarbeitung der Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen dient.
(2) Gemäß Art. 7 Abs. 3 DS-GVO haben Sie das Recht Ihre einmal (auch vor der Geltung der DS-GVO, d.h. vor dem 25.5.2018) erteilte Einwilligung – also Ihr freiwilliger, in informierter Weise und unmissverständlich durch eine Erklärung oder eine sonstige eindeutige bestätigende Handlung verständlich gemachter Willen, dass Sie mit der Verarbeitung der betreffenden personenbezogenen Daten für einen oder mehrere bestimmte Zwecke einverstanden sind – jederzeit mir gegenüber zu widerrufen, falls Sie eine solche erteilt haben. Dies hat zur Folge, dass ich die Datenverarbeitung, die auf dieser Einwilligung beruhte, für die Zukunft nicht mehr fortführen darf.
(3) Diesbezüglich wenden Sie sich bitte an die oben angegebene Kontaktstelle (siehe D. 1.).

3. Recht zur Berichtigung und Löschung
(1) Insoweit Sie betreffende personenbezogene Daten unrichtig sind, haben Sie gemäß Art. 16 DSGVO das Recht, von mir die unverzügliche Berichtigung zu verlangen. Mit einem diesbezüglichen Antrag wenden Sie sich bitte an die oben angegebene Kontaktstelle (siehe D. 1.).
(2) Unter den in Art. 17 DS-GVO genannten Voraussetzungen steht Ihnen das Recht zu, die Löschung Sie betreffender personenbezogener Daten zu verlangen. Mit einem diesbezüglichen Antrag wenden Sie sich bitte an die oben angegebene Kontaktstelle (siehe D. 1.). Das Recht auf Löschung steht Ihnen insbesondere zu, wenn die fraglichen Daten für die Erhebungs- oder Verarbeitungszwecke nicht mehr notwendig sind, wenn der Datenspeicherungszeitraum verstrichen ist, ein Widerspruch vorliegt (siehe F. 2.), oder eine unrechtmäßige Verarbeitung vorliegt.

4. Recht auf Einschränkung der Verarbeitung
(1) Nach Maßgabe des Art. 18 DS-GVO haben Sie das Recht, von mir die Einschränkung der Verarbeitung Ihrer personenbezogenen Daten zu verlangen.
(2) Mit einem diesbezüglichen Antrag wenden Sie sich bitte an die oben angegebene Kontaktstelle (siehe D. 1.).
(3) Das Recht auf Einschränkung der Verarbeitung steht Ihnen insbesondere zu, wenn die Richtigkeit der personenbezogenen Daten zwischen Ihnen und mir umstritten ist; das Recht steht Ihnen in diesem Fall für eine Zeitspanne zu, die für die Überprüfung der Richtigkeit erfordert wird. Entsprechendes gilt, wenn die erfolgreiche Ausübung eines Widerspruchsrechts (siehe F. 2.) zwischen Ihnen und mir noch umstritten ist. Dieses Recht steht Ihnen außerdem insbesondere dann zu, wenn Ihnen ein Recht auf Löschung zusteht (siehe F. 3.) und Sie anstelle einer Löschung eine eingeschränkte Verarbeitung verlangen.

5. Recht auf Datenübertragbarkeit
(1) Nach Maßgabe des Art. 20 DS-GVO haben Sie das Recht, von mir die Sie betreffenden personenbezogenen Daten, die Sie mir bereitgestellt haben, in einem strukturierten, gängigen, maschinenlesbaren Format nach Maßgabe zu erhalten.
(2) Mit einem diesbezüglichen Antrag wenden Sie sich bitte an die oben angegebene Kontaktstelle (siehe D. 1.).

6. Recht auf Beschwerde bei der Aufsichtsbehörde
(1) Sie haben gemäß Art. 77 DS-GVO das Recht, sich über die Erhebung und Verarbeitung Ihrer personenbezogenen Daten bei der zuständigen Aufsichtsbehörde zu beschweren.
(2) Die zuständige Aufsichtsbehörde erreichen Sie unter folgenden Kontaktdaten: Der Hessische Datenschutzbeauftragte, Postfach 3163, 65021 Wiesbaden, Tel. 0611/1408-0, E-Mail: poststelle@datenschutz.hessen.de.
 ''';

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Heading(
              text: "A. Vorwort",
            ),
            Dec(
              text: vorwort,
            ),
            Heading(
              text: "B. Allgemeines",
            ),
            Dec(
              text: allgemeines,
            ),
            Heading(
              text: "C. Informationen über die Verarbeitung Ihrer Daten",
            ),
            Dec(
              text: informationen,
            ),
            Heading(
              text: "D. Verantwortlichkeit für Ihre Daten und Kontakte",
            ),
            Dec(
              text: verantwortlichkeit,
            ),
            Heading(
              text: "E. Datenverarbeitung durch Dritte",
            ),
            Dec(
              text: datenverarbeitung,
            ),
            Heading(
              text: "F. Ihre Rechte",
            ),
            Dec(
              text: ihre,
            ),
          ],
        )));
  }
}
