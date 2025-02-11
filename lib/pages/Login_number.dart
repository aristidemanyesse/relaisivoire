import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/key_board_number.dart';
import 'package:lpr/components/widgets/my_input_number.dart';
import 'package:lpr/controllers/keyboard_controller.dart';
import 'package:lpr/pages/Index_page.dart';
import 'package:lpr/pages/Login_name.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'dart:io';

import 'package:lpr/pages/OTP_page.dart';

class LoginNumber extends StatefulWidget {
  const LoginNumber({Key? key}) : super(key: key);

  @override
  State<LoginNumber> createState() => _LoginNumberState();
}

class _LoginNumberState extends State<LoginNumber> {
  final KeyBoradController _keyBoradController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, element) async {
        Get.dialog(
          ConfirmDialog(
            title: "😩😟 Hhmmm !",
            message: "Voulez-vous vraiment quitter cette application ?",
            testOk: "Oui",
            testCancel: "Non, je reste",
            functionOk: () {
              exit(0);
            },
            functionCancel: () {
              Get.back();
            },
          ),
        );
        return;
      },
      child: Scaffold(
          body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                width: Get.size.width,
                decoration: const BoxDecoration(
                    color: MyColors.bleu,
                    border: Border.symmetric(
                        horizontal: BorderSide.none,
                        vertical: BorderSide.none)),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CONNEXION",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: MyColors.beige),
                      ),
                      const SizedBox(height: Tools.PADDING / 3),
                      Text(
                        "Entrez votre numéro de téléphone",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: MyColors.beige),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .moveX(duration: 800.ms, begin: 1000.0, end: 0),
                ),
              ),
            ),
            const Expanded(flex: 1, child: Wave()),
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: Tools.PADDING * 3,
                ),
                decoration: const BoxDecoration(
                    color: MyColors.beige,
                    border: Border(top: BorderSide.none)),
                child: Column(
                  children: [
                    MyInputNumber(
                        nb_places: 10, keyBoradController: _keyBoradController),
                    const Spacer(),
                    KeyBoardNumber(),
                    SizedBox(
                      height: Tools.PADDING * 2,
                    ),
                    const Spacer(),
                    MainButtonInverse(
                        title: "Valider",
                        onPressed: () {
                          Get.dialog(
                            ConfirmDialog(
                              title: "Confirmation",
                              message:
                                  "Vous confirmez que le ${_keyBoradController.value} est vraiment votre numero? \n Un SMS sera envoyé à cette adresse.",
                              testOk: "Je confirme",
                              testCancel: "Non",
                              functionOk: () {
                                Get.off(const OPTPage());
                              },
                              functionCancel: () {
                                Get.back();
                              },
                            ),
                          );
                        }),
                    SizedBox(
                      height: Tools.PADDING * 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
