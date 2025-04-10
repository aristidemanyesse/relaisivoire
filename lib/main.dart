import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/AppTheme.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/controllers/KeyBoardController.dart';
import 'package:lpr/models/AdministrationApp/CustomUser.dart';
import 'package:lpr/pages/ListeColisPage.dart';
import 'package:lpr/pages/Login_number.dart';
import 'package:lpr/services/SessionService.dart';
import 'package:lpr/objectbox.g.dart';
import 'package:lpr/pages/Splashscreen.dart';
import 'package:lpr/services/ApiService.dart';
import 'package:lpr/services/StoreService.dart';
import 'package:lpr/services/SyncService.dart';
import 'package:objectbox/objectbox.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(CommandeProcessController());
  Get.put(GeneralController());
  Get.put(KeyBoardController());

  final store = await getStore();
  final sync = SyncService(store: store);
  final session = SessionService(syncService: sync);
  final client = await session.restoreOrAuthenticate();

  GeneralController controller = Get.find();
  if (client != null) {
    controller.client.value = client;
    CustomUser.connexion(client.contact);
    controller.connected.value = true;
  } else {
    controller.connected.value = false;
  }
  // sync.syncAllData();

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
        home: SelectableRegion(
          selectionControls: materialTextSelectionControls,
          focusNode: FocusNode(),
          child: controller.connected.value
              ? const ListeColisPage()
              : const Splashscreen(),
        ));
  }
}
