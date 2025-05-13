import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void requestPermissions() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // Demande d'autorisation de notification pour iOS et Android 13+
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> initNotification() async {
    AwesomeNotifications().initialize(
      null, // Icône de notification par défaut pour Android
      [
        NotificationChannel(
            channelKey: 'RelaisIvoire_channel_id',
            channelName: 'RelaisIvoire Channel',
            channelDescription: 'RelaisIvoire Notification channel',
            defaultColor: Colors.white,
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            onlyAlertOnce: true,
            enableVibration: true,
            playSound: true,
            soundSource: "resource://raw/notification")
      ],
    );

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
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationService.onActionReceivedMethod,
      //   onNotificationCreatedMethod:
      //       NotificationService.onNotificationCreatedMethod,
      //   onNotificationDisplayedMethod:
      //       NotificationService.onNotificationDisplayedMethod,
      //   onDismissActionReceivedMethod:
      //       NotificationService.onDismissActionReceivedMethod,
    );
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

  Future showNotification(
      {int id = 0, String? title, String? message, String? payLoad}) async {
    var random = Random();
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: random.nextInt(1000),
          channelKey: 'RelaisIvoire_channel_id',
          title: title,
          body: message,
          payload: {"payload": payLoad},
          wakeUpScreen: true,
          autoDismissible: false,
          backgroundColor: MyColors.primary,
          notificationLayout: NotificationLayout.Default,
        ),
        actionButtons: [
          NotificationActionButton(
              key: 'REPLY',
              label: 'VOIR LA REPONDRE',
              color: MyColors.primary,
              actionType: ActionType.Default),
          NotificationActionButton(
            key: 'DISMISS',
            label: 'OK',
            color: Colors.grey,
            actionType: ActionType.DismissAction,
          ),
        ]);
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedNotification received) async {
    String id = received.payload!["payload"]!;
    // if (id == "") {
    //   Get.to(const HomeScreen());
    // } else {
    //   DemandeController controller = Get.find();
    //   controller.getData();
    //   Demande? demande =
    //       controller.demandes.firstWhereOrNull((item) => item.id == id);
    //   if (demande != null) {
    //     Get.to(DetailDemande(
    //       demande: demande,
    //     ));
    //   } else {
    //     Get.to(const HomeScreen());
    //   }
    // }
  }
}
