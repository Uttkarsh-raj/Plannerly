import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  //on tapping any notification
  static void onNotificationTap(NotificationResponse res) {
    onClickNotification.add(res.payload!);
  }

  //initialize plugin
  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  //show simple notifications
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  static Future cancel(int id) async {
    await _flutterLocalNotificationPlugin.cancel(id);
  }

  //schedule notifictaions
  static Future scheduleNotifications({
    required String title,
    required String body,
    required String payload,
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minutes,
    required int seconds,
  }) async {
    tz.initializeTimeZones();
    final location = tz.getLocation('UTC');
    final now = tz.TZDateTime.now(location);
    print((
      location,
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second + 5,
    ));
    await _flutterLocalNotificationPlugin.zonedSchedule(
      2,
      title,
      body,
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      // tz.TZDateTime.local(2023, 11, 14, 23, 49, 30, 0, 0),
      // tz.TZDateTime(
      //   location,
      //   now.year,
      //   now.month,
      //   now.day,
      //   now.hour,
      //   now.minute,
      //   now.second + 5,
      // ),
      tz.TZDateTime(location, year, month, day, hour, minutes, seconds).add(
        const Duration(seconds: 3),
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails('channel 3', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker'),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }
}
