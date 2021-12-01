import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {

  static bool hasInitializated = false;
  static FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();
  static int nextId = 0;

  void initilizate(){
    if (!hasInitializated) {
      this.loadNotificationSettings();
    }
  }

  void selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  void loadNotificationSettings() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flnp.initialize(initializationSettings, onSelectNotification: selectNotification);
    hasInitializated = true;
  }

  void displayNotification(String title, String body ) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('pharmacy_wiki_channel', 'pharmacy_wiki_channel',
        channelDescription: '',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flnp.show(nextId++, title, body, platformChannelSpecifics, payload: 'item x');
  }

  void displayScheduledNotification(String title, String body, DateTime dateTime) async {

    var now = tz.TZDateTime.now(tz.local);
    now = now.add(Duration(hours: -now.hour, minutes: -now.minute, seconds: -now.second));
    now = now.add(Duration(hours: dateTime.hour, minutes: dateTime.minute, seconds: dateTime.second));

    await flnp.zonedSchedule(
    nextId++,
    title,
    body,
    now,
    const NotificationDetails(
        android: AndroidNotificationDetails(
            'pharmacy_wiki_channel', 'pharmacy_wiki_channel',
            channelDescription: '')),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelAllNotifications() async {
    await flnp.cancelAll();
  }


  
}