import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:custom_app/lock_screen.dart';
import 'package:custom_app/main_screen.dart';
import 'package:custom_app/other/constant.dart';
import 'package:custom_app/save_value.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async => {
      WidgetsFlutterBinding.ensureInitialized(),
      await Firebase.initializeApp(),
      SaveValue.isLockOn().then((value) => {runApp(MyApp(value))}),
      AwesomeNotifications().initialize(
          // set the icon to null if you want to use the default app icon
          'resource://drawable/small_icon',
          [
            NotificationChannel(
                channelKey: 'desire_baby',
                channelName: 'Desire baby',
                channelDescription:
                    'Notification channel for desire baby application',
                defaultColor: Constant.bar_color,
                ledColor: Colors.white)
          ])
    };

class MyApp extends StatefulWidget {
  final bool isLock;

  MyApp(this.isLock, {Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(Constant.toolbar_color),
      ),
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [const Locale('en'), const Locale('fr')],
      home: widget.isLock != null && widget.isLock
          ? LockScreen(isGoToMain: true)
          : MainScreen(),
      // home: Test(),
      debugShowCheckedModeBanner: false,
    );
  }
}
