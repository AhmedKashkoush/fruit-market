import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> initNotifications() async {
  FirebaseMessaging.instance.setAutoInitEnabled(false);
  _initAwesomeNotifications();
  final RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }
  FirebaseMessaging.onBackgroundMessage(_handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
}

Future<void> _handleMessage(RemoteMessage message) async {
  if (message.messageType! == _NotificationType.latestNews.name) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'latest_news_channel',
        title: message.notification!.title,
        body: message.notification!.body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  if (message.messageType! == _NotificationType.purchase.name) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: 'purchase_channel',
        title: message.notification!.title,
        body: message.notification!.body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  if (message.messageType! == _NotificationType.delivery.name) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 3,
        channelKey: 'delivery_channel',
        title: message.notification!.title,
        body: message.notification!.body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}

void _onMessageOpenedApp(RemoteMessage event) {}

void _initAwesomeNotifications() {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'latest_news_channel',
      channelName: 'Latest News',
      channelDescription: 'For latest events and updates',
      defaultColor: const Color(0xFF9D50DD),
      importance: NotificationImportance.High,
    ),
    NotificationChannel(
      channelKey: 'purchase_channel',
      channelName: 'Purchase',
      channelDescription: 'For product purchasing process',
      defaultColor: const Color(0xFF9D50DD),
      importance: NotificationImportance.High,
    ),
    NotificationChannel(
      channelKey: 'delivery_channel',
      channelName: 'Delivery',
      channelDescription: 'For delivery tracking',
      defaultColor: const Color(0xFF9D50DD),
      importance: NotificationImportance.High,
    ),
  ]);
}

enum _NotificationType {
  latestNews,
  delivery,
  purchase,
}
