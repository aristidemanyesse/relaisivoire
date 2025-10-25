import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/KeyBoardNumberPad.dart';
import 'package:lpr/components/widgets/my_input_number.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/controllers/KeyBoardController.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/models/AdministrationApp/CustomUser.dart';
import 'dart:io';

import 'package:lpr/pages/OTP_page.dart';

class LoginNumber extends StatefulWidget {
  const LoginNumber({super.key});

  @override
  State<LoginNumber> createState() => _LoginNumberState();
}

class _LoginNumberState extends State<LoginNumber> {
  KeyBoardController keyBoardController = Get.find();
  GeneralController controller = Get.find();
  String _number = "";

  @override
  void initState() {
    super.initState();
    keyBoardController.value.value = "";
  }

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
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
              width: Get.size.width,
              decoration: const BoxDecoration(
                  color: MyColors.primary,
                  border: Border.symmetric(
                      horizontal: BorderSide.none, vertical: BorderSide.none)),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.15,
                    child: Image.asset("assets/images/pattern.png",
                        fit: BoxFit.cover, width: Get.width),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Tools.PADDING / 2),
                      Text(
                        "CONNEXION",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: MyColors.secondary),
                      ),
                      const SizedBox(height: Tools.PADDING / 3),
                      Text(
                        "Entrez votre numéro de téléphone",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: MyColors.secondary),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 300.ms)
                      .moveX(duration: 300.ms, begin: 1000.0, end: 0),
                ],
              ),
            ),
            const SizedBox(height: 30, child: Wave()),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: Get.width / 10),
                decoration: const BoxDecoration(
                    color: MyColors.secondary,
                    border: Border(top: BorderSide.none)),
                child: Column(
                  children: [
                    SizedBox(height: Tools.PADDING * 2),
                    Obx(() {
                      _number = keyBoardController.value.value;
                      return MyInputNumber(nbPlaces: 10, value: _number);
                    }),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Tools.PADDING),
                        child: KeyBoardNumberPad(
                          limit: 10,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Tools.PADDING,
                    ),
                    Obx(() {
                      return (keyBoardController.value.value.length == 10)
                          ? MainButtonInverse(
                              title: "Valider",
                              icon: Icons.check,
                              onPressed: () {
                                Get.dialog(
                                  ConfirmDialog(
                                    title: "Confirmation",
                                    message:
                                        "Vous confirmez que le $_number est vraiment votre numero? Un SMS sera envoyé sur celui-ci.",
                                    testOk: "Je confirme",
                                    testCancel: "Non",
                                    functionOk: () async {
                                      bool response =
                                          await CustomUser.connexion(_number);
                                      if (!response) {
                                        await Client.inscription(_number);
                                      }
                                      keyBoardController.value.value = "";
                                      Get.off(OPTPage(number: _number));
                                    },
                                    functionCancel: () {
                                      Get.back();
                                    },
                                  ),
                                );
                              })
                          : Container();
                    }),
                    SizedBox(
                      height: Tools.PADDING,
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
