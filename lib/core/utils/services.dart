import 'package:firebase_core/firebase_core.dart';
import 'package:fruit_market/core/utils/locator.dart';
import 'package:fruit_market/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> initializeServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  initLocator();
}

Future<void> _onBackgroundMessage(RemoteMessage message) async {}

void _onMessageOpenedApp(RemoteMessage event) {}
