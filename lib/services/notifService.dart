import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vtapp/screens/notices.dart';
class NotifService{
  final notificationService = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;


  Future<void> initNotification() async {
    if (_isInitialized) return;
    const initAndroidSettings = AndroidInitializationSettings(
        "@mipmap/ic_launcher");
    const initSettings = InitializationSettings(
        android: initAndroidSettings
    );

    await notificationService.initialize(initSettings);
  }
  NotificationDetails notificationDetails() {
      return const NotificationDetails(
        android: AndroidNotificationDetails("daily_channel_id", "Daily Notifications",channelDescription: "Daily Notification Channel",importance: Importance.max,priority: Priority.high)
      );
  }

  Future<void> showNotif({int id = 0, String? title, String? body}) async{
    return notificationService.show(id, title, body, const NotificationDetails());
  }
}