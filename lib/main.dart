import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/AppTheme.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/controllers/KeyBoardController.dart';
import 'package:lpr/pages/Splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(CommandeProcessController());
  Get.put(KeyBoardController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "Relais'Ivoire",
        theme: AppTheme.lightTheme,
        // darkTheme: AppTheme.darkTheme,
        // themeMode: ThemeMode.system,
        home: SelectableRegion(
          selectionControls: materialTextSelectionControls,
          focusNode: FocusNode(),
          child: const Splashscreen(),
        ));
  }
}
