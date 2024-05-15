import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/circle.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/key_board_number.dart';
import 'package:lpr/controllers/keyboard_controller.dart';
import 'package:lpr/pages/prefix.dart';
import 'package:lpr/pages/wave.dart';

class LoginNumber extends StatefulWidget {
  const LoginNumber({Key? key}) : super(key: key);

  @override
  State<LoginNumber> createState() => _LoginNumberState();
}

class _LoginNumberState extends State<LoginNumber> {
  final KeyBoradController _keyBoradController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      horizontal: BorderSide.none, vertical: BorderSide.none)),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: Tools.PADDING),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "CONNEXION",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: MyColors.beige),
                            ),
                            const SizedBox(
                              height: Tools.PADDING,
                            ),
                            Text(
                              "Entrez votre numéro de téléphone",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: MyColors.beige),
                            ),
                            Text(
                              "(+225)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: MyColors.beige),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(flex: 1, child: Wave()),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: Tools.PADDING * 3,
              ),
              decoration: const BoxDecoration(
                  color: MyColors.beige, border: Border(top: BorderSide.none)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(10, (index) {
                              if (index <=
                                  _keyBoradController.value.string.length - 1) {
                                return Text(
                                    "${_keyBoradController.value.toString()[index]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge);
                              } else {
                                return Text("_",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge);
                              }
                            }),
                          );
                        }),
                      ),
                    ],
                  ),
                  const Spacer(),
                  KeyBoardNumber(),
                  const Spacer(
                    flex: 2,
                  ),
                  MainButtonInverse(title: "Valider", onPressed: () {}),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
