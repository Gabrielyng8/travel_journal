import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifService {
  final notifications = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  // Initialize Notification
  Future<void> initNotification(BuildContext context) async {
    if (_isInitialized) return;

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: initSettingsAndroid);

    final androidPlugin = notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    final granted = await androidPlugin?.requestNotificationsPermission();

    if (granted == false) {
      // 🔔 Show dialog explaining next steps
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Notifications Disabled'),
          content: const Text(
            'To receive notifications, please enable them from system settings or reinstall the app and allow notifications on launch.',
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    }

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