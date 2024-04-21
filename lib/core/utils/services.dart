import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/utils/hive.dart';
import 'package:fruit_market/core/utils/locator.dart';
import 'package:fruit_market/core/utils/notifications.dart';
import 'package:fruit_market/firebase_options.dart';

Future<void> initializeServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initNotifications();
  await initHive();
  //TODO: Init Stripe
  // Bloc.observer = MyObserver();
  await initLocator();

}

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
