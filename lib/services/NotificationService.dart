import 'dart:math';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/models/ColisApp/Colis.dart';
import 'package:relaisivoire/pages/ColisPage.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void requestPermissions() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // Demande d'autorisation de notification pour iOS et Android 13+
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> initNotification() async {
    // AwesomeNotifications().initialize(
    //   null, // Icône de notification par défaut pour Android
    //   [
    //     NotificationChannel(
    //       channelKey: 'RelaisIvoire_channel_id',
    //       channelName: 'RelaisIvoire Channel',
    //       channelDescription: 'RelaisIvoire Notification channel',
    //       defaultColor: Colors.white,
    //       ledColor: Colors.white,
    //       importance: NotificationImportance.Max,
    //       onlyAlertOnce: true,
    //       enableVibration: true,
    //       playSound: true,
    //       soundSource: "resource://raw/notification",
    //     ),
    //   ],
    // );

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification:
      //     (int id, String? title, String? message, String? payload) async {}
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );

    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: NotificationService.onActionReceivedMethod,
    //   //   onNotificationCreatedMethod:
    //   //       NotificationService.onNotificationCreatedMethod,
    //   //   onNotificationDisplayedMethod:
    //   //       NotificationService.onNotificationDisplayedMethod,
    //   //   onDismissActionReceivedMethod:
    //   //       NotificationService.onDismissActionReceivedMethod,
    // );
  }

  // Future showSimpleNotification(
  //     {int id = 0, String? title, String? message, String? payLoad}) async {
  //   var random = Random();
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: random.nextInt(1000),
  //       channelKey: 'RelaisIvoire_channel_id',
  //       title: title,
  //       body: message,
  //       payload: {"payload": payLoad},
  //       notificationLayout: NotificationLayout.Default,
  //       largeIcon: 'resource://mipmap/ic_launcher',
  //     ),
  //   );
  // }

  Future showNotification({
    int id = 0,
    String? title,
    String? message,
    Map<String, String>? payLoad,
  }) async {
    var random = Random();
    // AwesomeNotifications().createNotification(
    //   content: NotificationContent(
    //     id: random.nextInt(1000),
    //     channelKey: 'RelaisIvoire_channel_id',
    //     title: title,
    //     body: message,
    //     payload: payLoad,
    //     wakeUpScreen: true,
    //     autoDismissible: false,
    //     backgroundColor: MyColors.primary,
    //     notificationLayout: NotificationLayout.Default,
    //   ),
    //   actionButtons: [
    //     NotificationActionButton(
    //       key: 'REPLY',
    //       label: 'VOIR LA REPONDRE',
    //       color: MyColors.primary,
    //       actionType: ActionType.Default,
    //     ),
    //     NotificationActionButton(
    //       key: 'DISMISS',
    //       label: 'OK',
    //       color: Colors.grey,
    //       actionType: ActionType.DismissAction,
    //     ),
    //   ],
    // );

    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: (ReceivedAction receivedAction) async {
    //     await NotificationService.onActionReceivedMethod(receivedAction);
    //   },
    //   onNotificationCreatedMethod:
    //       (ReceivedNotification receivedNotification) async {
    //         NotificationService.onNotificationCreatedMethod(
    //           receivedNotification,
    //         );
    //       },
    //   onNotificationDisplayedMethod:
    //       (ReceivedNotification receivedNotification) async {
    //         NotificationService.onNotificationDisplayedMethod(
    //           receivedNotification,
    //         );
    //       },
    //   onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
    //     NotificationService.onDismissActionReceivedMethod(receivedAction);
    //   },
    // );
  }

  /// Use this method to detect when a new notification or a schedule is created
  // @pragma("vm:entry-point")
  // static Future<void> onNotificationCreatedMethod(
  //   ReceivedNotification receivedNotification,
  // ) async {
  //   // Your code goes here
  // }

  // /// Use this method to detect every time that a new notification is displayed
  // @pragma("vm:entry-point")
  // static Future<void> onNotificationDisplayedMethod(
  //   ReceivedNotification receivedNotification,
  // ) async {
  //   // Your code goes here
  // }

  // /// Use this method to detect if the user dismissed a notification
  // @pragma("vm:entry-point")
  // static Future<void> onDismissActionReceivedMethod(
  //   ReceivedAction receivedAction,
  // ) async {
  //   // Your code goes here
  // }

  /// Use this method to detect when the user taps on a notification or action button
  // @pragma("vm:entry-point")
  // static Future<void> onActionReceivedMethod(
  //   ReceivedAction receivedAction,
  // ) async {
  //   Map<String, dynamic>? payload = receivedAction.payload;
  //   final action = payload!['action'];
  //   print("🔔 Notification action received, $payload");
  //   if (action == "colis") {
  //     final code = payload['code'];
  //     Colis? colis = await Colis.searchByCode(code);
  //     if (colis != null) {
  //       Get.to(ColisPage(colis: colis));
  //     }
  //   }

  //   // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
  //   //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
  //   //     arguments: receivedAction);
  // }
}
