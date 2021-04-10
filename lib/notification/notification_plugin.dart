import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_health/notification/notifcation_data.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationPlugin() {
    _initializeNotifications();
  }

  void _initializeNotifications() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = IOSInitializationSettings();
    final initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: ' + payload);
    }
  }

  // Future<void> showWeeklyAtDayAndTime(
  //     Time time, Day day, int id, String title, String description) async {
  //   final androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'show weekly channel id',
  //     'show weekly channel name',
  //     'show weekly description',
  //   );
  //   final iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   final platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //     iOS: iOSPlatformChannelSpecifics,
  //   );
  //   await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
  //     id,
  //     title,
  //     description,
  //     day,
  //     time,
  //     platformChannelSpecifics,
  //   );
  // }

  Future<void> showDailyAtTime(Time time, int id, String title, String description) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show weekly channel id',
      'show weekly channel name',
      'show weekly description',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true
    );
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.showDailyAtTime(
      id,
      title,
      description,
      time,
      platformChannelSpecifics,
    );
    print('notification created ');
  }
  Future<void> schedule(DateTime time, int id, String title, String description) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
    );
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      description,
      time,
      platformChannelSpecifics,
    );
    print('notification created ');
  }


  Future<List<PendingNotificationRequest>> getScheduledNotifications() async {
    final pendingNotifications =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  // Future<void> scheduleAllNotifications(
  //     List<NotificationData> notifications) async {
  //   for (final notification in notifications) {
  //     await showDailyAtTime(
  //       Time(notification.hour, notification.minute),
  //       notification.notificationId,
  //       notification.title,
  //       notification.description,
  //     );
  //   }
  // }
}
