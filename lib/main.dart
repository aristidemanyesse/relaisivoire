import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/AppTheme.dart';
import 'package:lpr/controllers/ColisController.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/controllers/KeyBoardController.dart';
import 'package:lpr/controllers/NotificationController.dart';
import 'package:lpr/pages/ListeColisPage.dart';
import 'package:lpr/pages/Splashscreen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lpr/services/FirebaseService.dart';
import 'package:lpr/services/NotificationService.dart';
import 'package:lpr/services/SessionService.dart';
import 'package:lpr/services/StoreService.dart';
import 'package:lpr/services/SyncService.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseService();
  FirebaseMessaging.onBackgroundMessage(
      FirebaseService.firebaseMessagingBackgroundHandler);

  NotificationService().initNotification();
  NotificationService.requestPermissions();

  await initializeDateFormatting('fr_FR', null);
  Get.put(GeneralController());
  Get.put(KeyBoardController());
  Get.put(HandleTypesController());
  Get.put(ColisController());
  Get.put(NotificationController());
  Get.put(CommandeProcessController());

  final store = await getStore();
  final sync = SyncService(store: store);
  final session = SessionService(syncService: sync);
  await session.restoreOrAuthenticate();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GeneralController controller = Get.find();
    return GetMaterialApp(
        title: "Relais'Ivoire",
        theme: AppTheme.lightTheme,
        // darkTheme: AppTheme.darkTheme,
        // themeMode: ThemeMode.system,

        home: Obx(() {
          return SelectableRegion(
            selectionControls: materialTextSelectionControls,
            focusNode: FocusNode(),
            child: controller.connected.value
                ? const ListeColisPage()
                : const Splashscreen(),
          );
        }));
  }
}
