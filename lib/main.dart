import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/AppTheme.dart';
import 'package:lpr/controllers/ColisController.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/controllers/KeyBoardController.dart';
import 'package:lpr/controllers/NotificationController.dart';
import 'package:lpr/firebase_options.dart';
import 'package:lpr/pages/SplashScreen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lpr/services/FirebaseService.dart';
// import 'package:lpr/services/NotificationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseService();
  FirebaseMessaging.onBackgroundMessage(
      FirebaseService.firebaseMessagingBackgroundHandler);

  // NotificationService().initNotification();
  // NotificationService.requestPermissions();

  await initializeDateFormatting('fr_FR', null);
  Get.put(GeneralController());
  Get.put(KeyBoardController());
  Get.put(HandleTypesController());
  Get.put(ColisController());
  Get.put(NotificationController());
  Get.put(CommandeProcessController());

  // ⚡ Activer l'affichage bord à bord
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Définir les couleurs transparentes pour le bord à bord
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Vérifie si l'app a été lancée via une notification
  // ReceivedAction? initialAction = await AwesomeNotifications()
  //     .getInitialNotificationAction(removeFromActionEvents: false);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final ReceivedAction? initialAction;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GeneralController controller = Get.find();
    // print("🔔 Notification initiale : $initialAction");
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Relais'Ivoir",
        theme: AppTheme.lightTheme,
        home: SelectableRegion(
          selectionControls: materialTextSelectionControls,
          focusNode: FocusNode(),
          child: SplashScreen(),
          // child: controller.connected.value
          //     ? const ListeColisPage()
          //     : const Splashscreen(),
        ));
  }
}
