import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationManager {
  /*var flutterLocalNotificationsPlugin;

  NotificationManager() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  void initNotifications() {

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void scheduleAlarm(
      int id, String title, String body, DateTime dateTime) async {
*/ /*
    await flutterLocalNotificationsPlugin.schedule(
        id, title, body, dateTime, getPlatformChannelSpecfics());
*/ /*
    var time = tz.TZDateTime.from(
      dateTime,
      tz.local,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        time,
        NotificationDetails(
            android: AndroidNotificationDetails(
          'desire_baby_channel',
          'desire_baby',
          'All notification belong to desire baby.',
          playSound: true,
          enableVibration: true,
          importance: Importance.max,
          priority: Priority.high,
        )),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }


  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    return Future.value(0);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return Future.value(1);
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }
*/

  void scheduleAlarm(
      int id, String title, String body, DateTime dateTime) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          title: title,
          body: body,
          autoDismissable: false,
          channelKey: 'desire_baby',


        ),
        schedule: NotificationCalendar.fromDate(date: dateTime));
  }

  void removeReminder(int notificationId) {}
}
