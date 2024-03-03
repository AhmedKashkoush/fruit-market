import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruit_market/core/constants/api_keys.dart';
import 'package:fruit_market/core/utils/locator.dart';
import 'package:fruit_market/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> initializeServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  // Bloc.observer = MyObserver();
  await initLocator();
  if (kIsWeb) {
    sl<FacebookAuth>().webAndDesktopInitialize(
      appId: facebookAppId,
      cookie: true,
      xfbml: true,
      version: 'v15.0',
    );
  }

}

Future<void> _onBackgroundMessage(RemoteMessage message) async {}

void _onMessageOpenedApp(RemoteMessage event) {}

class MyObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('Bloc: $bloc changed to $change');
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('Bloc: $bloc closed');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('Bloc: $bloc created');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('Bloc: $bloc error: $error');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('Bloc: $bloc fired event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('Bloc: $bloc transitted to: $transition');
  }
}
