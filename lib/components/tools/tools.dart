import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Tools {
  static const double PADDING = 20;

  static void showErrorToast({String title = "Erreur", String message = ""}) {
    Get.snackbar(title, message,
        icon: Icon(Icons.error, size: 40, color: MyColors.secondary),
        backgroundColor: Colors.red,
        colorText: Colors.white);
  }
}

class MyColors {
  // static const Color primary = Color(0xFF2B124C);
  // static const Color primary = Color.fromARGB(255, 9, 150, 68);
  static const Color primary = Color.fromARGB(255, 9, 106, 217);
  static const Color textprimary = Color.fromARGB(255, 1, 36, 76);
  // static const Color secondary = Color(0xFFFBE4D8);
  static const Color secondary = Color.fromARGB(255, 241, 240, 246);
  static const Color danger = Color(0xFFCE6A6B);
  static const Color bleunuit = Color(0xFF212E53);
  static const Color success = Color.fromARGB(255, 9, 176, 76);
}
