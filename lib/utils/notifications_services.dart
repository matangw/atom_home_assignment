import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotificationsServices{


  static final NotificationsServices _notificationsServices = NotificationsServices._internal();

  factory NotificationsServices(){
    return _notificationsServices;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationsServices._internal();

  Future<void> initNotification() async{
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('flutter');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true
        );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  Future<bool> showNotification(int id,String title,String body,int seconds)async{
    await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
        const NotificationDetails(
        android: AndroidNotificationDetails(
          'Main_channel', 'Main_Channel',
            importance: Importance.max,
            priority: Priority.max

        ),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        )
        ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
    return true;

  }

}