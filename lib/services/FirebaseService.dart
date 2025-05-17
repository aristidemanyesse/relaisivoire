import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lpr/services/NotificationService.dart';

class FirebaseService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseService() {
    _initialize();
  }

  void _initialize() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        Map<String, String> payload =
            message.data.map((key, value) => MapEntry(key, value.toString()));
        NotificationService().showNotification(
          title: '${message.notification!.title}',
          message: "${message.notification!.body}",
          payLoad: payload,
        );
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    Map<String, String> payload =
        message.data.map((key, value) => MapEntry(key, value.toString()));
    NotificationService().showNotification(
      title: '${message.notification!.title}',
      message: "${message.notification!.body}",
      payLoad: payload,
    );
  }
}
