import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_news/main.dart' as notification;

class LocalNotification {
  Future<void> initLocalNotification() async {
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    DarwinInitializationSettings iosSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    bool? isInitializedNotifications = await notification.notificationsPlugin
        .initialize(initializationSettings);

    log("isInitializedNotifications $isInitializedNotifications");
  }

  static Future<void> showNotification(String title, String description) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "Authentication",
      "AuthenticationDetails",
      priority: Priority.max,
      importance: Importance.max,
      playSound: true,
    );
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosDetails);

    await notification.notificationsPlugin
        .show(0, title, description, notificationDetails);
  }
}
