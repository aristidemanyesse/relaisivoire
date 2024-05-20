import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/circle.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/key_board_number.dart';
import 'package:lpr/components/widgets/my_input_number.dart';
import 'package:lpr/controllers/keyboard_controller.dart';
import 'package:lpr/pages/Index_page.dart';
import 'package:lpr/pages/Login_name.dart';
import 'package:lpr/components/elements/prefix.dart';
import 'package:lpr/components/widgets/wave.dart';

class OPTPage extends StatefulWidget {
  const OPTPage({Key? key}) : super(key: key);

  @override
  State<OPTPage> createState() => _OPTPageState();
}

class _OPTPageState extends State<OPTPage> {
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
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
              width: Get.size.width,
              decoration: const BoxDecoration(
                  color: MyColors.bleu,
                  border: Border.symmetric(
                      horizontal: BorderSide.none, vertical: BorderSide.none)),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: Tools.PADDING / 2),
                    Container(
                      height: 70,
                      width: 70,
                      color: Colors.grey,
                    ),
                    Text(
                      "Vérification OTP",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: MyColors.beige),
                    ),
                    Text(
                      "Nous vous avons envoyé un code par SMS sur \n +222 0404444040404",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: MyColors.beige, height: 2),
                    ),
                    const SizedBox(height: Tools.PADDING),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(flex: 1, child: Wave()),
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: Tools.PADDING * 2,
              ),
              decoration: const BoxDecoration(
                  color: MyColors.beige, border: Border(top: BorderSide.none)),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Tools.PADDING,
                      ),
                      child: MyInputNumber(
                          keyBoradController: _keyBoradController)),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Tools.PADDING,
                      ),
                      child: KeyBoardNumber()),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainButtonInverse(
                          title: "",
                          onPressed: () {
                            Get.back();
                          }),
                      MainButtonInverse(
                          title: "Valider",
                          onPressed: () {
                            Get.to(IndexPage());
                          }),
                    ],
                  ),
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
