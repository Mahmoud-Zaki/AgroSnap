import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationsService {
  const NotificationsService._();

  static final _flutterLocalNotification = FlutterLocalNotificationsPlugin();

  static Future<void> initialNotificationSettings() async {
    const androidInitialization = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initializationSettings = InitializationSettings(android: androidInitialization);
    await _flutterLocalNotification.initialize(initializationSettings);
    await _configureLocalTimeZone();
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  static Future<DateTime> scheduleNotification({
    required int id,
    required String body,
    required DateTime time,
    required String repeat
  }) async {
    await initialNotificationSettings();
    var tempTime = time.toLocal();
    DateTimeComponents dateTimeComponents = DateTimeComponents.dateAndTime;
    switch(repeat){
      case 'no':
        dateTimeComponents = DateTimeComponents.dateAndTime;
        break;
      case 'daily':
        dateTimeComponents = DateTimeComponents.time;
        break;
      case 'weekly':
        dateTimeComponents = DateTimeComponents.dayOfWeekAndTime;
        break;
      case 'monthly':
        dateTimeComponents = DateTimeComponents.dayOfMonthAndTime;
        break;
    }

    await _flutterLocalNotification.zonedSchedule(
      id,
      "AgroSnap",
      body,
      tz.TZDateTime.from(tempTime, tz.local).toLocal(),
      NotificationDetails(
        android: AndroidNotificationDetails(
          "default_notification_channel_id",
          "default_notification_channel_name",
          channelDescription: "default_notification_channel_description",
          priority: Priority.high,
          importance: Importance.max,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: dateTimeComponents,
    );
    return tempTime.toLocal();
  }

  static Future<void> cancelNotification({required int id}) async {
    return _flutterLocalNotification.cancel(id);
  }
}