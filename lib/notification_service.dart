import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifService {
  final notifications = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Initialize Notification
  Future<void> initNotification() async {
    if (_isInitialized) return;

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: initSettingsAndroid);

    // Request permissions on Android 13+
    final androidPlugin = notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    final _ = await androidPlugin?.requestNotificationsPermission();

    await notifications.initialize(initSettings);
    _isInitialized = true;
  }

  
  // Notification Detail Setup
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'new_log_channel_id',
        'New Log',
        channelDescription: 'A channel for new logs',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  // Show Notification
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    
    await notifications.show(
      0,
      title,
      body,
      notificationDetails(),
    );
  }
}