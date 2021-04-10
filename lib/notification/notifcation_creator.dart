import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_health/notification/notifcation_data.dart';
import 'package:my_health/notification/notification_plugin.dart';

List<NotificationData> _notifications = [];
NotificationPlugin _notificationPlugin = NotificationPlugin();

Future notificationCreator(NotificationData notification) async {
  if (notification != null) {
    final notificationList = await _notificationPlugin
        .getScheduledNotifications();
    int id = 0;
    for (var i = 0; i < 1000; i++) {
      bool exist = checkIfIdExists(_notifications, i);
      if (!exist) {
        id = i;
        break;
      }
    }
    notification.notificationId = id;
    await _notificationPlugin.showDailyAtTime(
        notification.time, notification.notificationId, notification.title,
        notification.description);
  }
}

bool checkIfIdExists(List<NotificationData> notifications, int id) {
  for (final notification in notifications) {
    if (notification.notificationId == id) {
      return true;
    }
  }
  return false;
}