import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/key_board_number.dart';
import 'package:lpr/components/widgets/my_input_number.dart';
import 'package:lpr/controllers/keyboard_controller.dart';
import 'package:lpr/pages/Index_page.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vérification OTP",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: MyColors.beige),
                    ),
                    const SizedBox(height: Tools.PADDING / 3),
                    Text(
                      "Nous vous avons envoyé un code par SMS sur \n+222 0404444040404",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: MyColors.beige, height: 2),
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
                          nb_places: 4,
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
                      MainButton(
                          title: "Retour",
                          onPressed: () {
                            Get.back();
                          }),
                      MainButtonInverse(
                          title: "Confirmer OTP",
                          onPressed: () {
                            Get.to(const IndexPage());
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
