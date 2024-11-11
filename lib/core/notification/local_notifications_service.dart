import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  void Function(String? payload)? onSelectNotification;

  //Singleton pattern
  static final LocalNotificationService _notificationService =
  LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _notificationService;
  }

  LocalNotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init(
      {void Function(NotificationResponse? payload)? onSelectNotification}) async {
    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_launcher');

    //Initialization Settings for iOS
    // const IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    // );

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS
    );

    await flutterLocalNotificationsPlugin.initialize(
      onDidReceiveNotificationResponse: onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: onSelectNotification,
      initializationSettings,
    );
  }

  Future selectNotification(String payload) async {}

  Future<void> showNotification({
    required String title,
    bool enableVibration = false,
    bool playSound = false,
    bool showProgress = false,
    bool onlyAlertOnce = false,
    int progress = 0,
    bool ongoing = false,
    int maxProgress = 100,
    String body = '',
    int notificationId = 0,
  }) async {
    if (showProgress && Platform.isIOS) return;
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'channel ID',
      'channel name',
      enableVibration: enableVibration,
      showProgress: showProgress,
      ongoing: ongoing,
      onlyAlertOnce: onlyAlertOnce,
      progress: progress,
      maxProgress: maxProgress,
      channelDescription: 'channel description',
      playSound: playSound,
      priority: Priority.high,
      importance: Importance.high,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetails,
      // iOS: _iOSNotificationDetails
    );

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

// NotificationDetails platformChannelSpecifics =
// NotificationDetails(
//   android: _androidNotificationDetails,
//   // iOS: _iOSNotificationDetails
// );

// final IOSNotificationDetails _iosNotificationDetails = IOSNotificationDetails(
//     presentAlert: bool?,
//     presentBadge: bool?,
//     presentSound: bool?,
//     badgeNumber: int?
//     attachments: List<IOSNotificationAttachment>?
//     subtitle: String?,
//     threadIdentifier: String?
// );
}