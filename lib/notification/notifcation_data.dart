import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationData {
  String title;
  String description;
  Time time;
  int notificationId;

  NotificationData(this.title,this.description,this.time);
}