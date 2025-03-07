import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/elements/KeyBoardNumberPad.dart';
import 'package:lpr/components/widgets/my_input_number.dart';
import 'package:lpr/controllers/KeyBoardController.dart';
import 'package:lpr/pages/ListeColisPage.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/pages/PleaseWait2.dart';

class OPTPage extends StatefulWidget {
  final String number;
  const OPTPage({super.key, required this.number});

  @override
  State<OPTPage> createState() => _OPTPageState();
}

class _OPTPageState extends State<OPTPage> {
  KeyBoardController keyBoardController = Get.find();
  String _otp = "";

  int _counter = 60; // Durée du timer (secondes)
  late Timer _timer;
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _isButtonDisabled = true;
    _counter = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        setState(() {
          _isButtonDisabled = false;
        });
        _timer.cancel();
      }
    });
  }

  void _resendOtp() {
    // Logique pour renvoyer l'OTP ici
    _startTimer(); // Redémarrer le timer
  }

  void checkOtp() {
    Get.dialog(PleaseWait2());
    Future.delayed(Duration(seconds: 3), () {
      Get.to(const ListeColisPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text(
                      "Vérification OTP",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: MyColors.secondary),
                    ),
                    const SizedBox(height: Tools.PADDING / 3),
                    Text(
                      "Nous vous avons envoyé un code par SMS sur \n+222 ${widget.number}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: MyColors.secondary, height: 2),
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
              padding: const EdgeInsets.symmetric(
                horizontal: Tools.PADDING * 2,
              ),
              decoration: const BoxDecoration(
                  color: MyColors.secondary,
                  border: Border(top: BorderSide.none)),
              child: Column(
                children: [
                  const SizedBox(height: Tools.PADDING / 3),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Tools.PADDING,
                      ),
                      child: Obx(() {
                        _otp = keyBoardController.value.value;
                        return MyInputNumber(nbPlaces: 4, value: _otp);
                      })),
                  const Spacer(),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Tools.PADDING,
                      ),
                      child: KeyBoardNumberPad(limit: 4)),
                  const Spacer(),
                  if (_isButtonDisabled)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Renvoyer le code dans ",
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text("$_counter s",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ],
                    )
                  else
                    TextButton(
                      onPressed: _isButtonDisabled ? null : _resendOtp,
                      child: Text("Renvoyer le code OTP",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                  const Spacer(),
                  Obx(() {
                    return Row(
                      mainAxisAlignment:
                          (keyBoardController.value.value.length == 4)
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                      children: [
                        MainButton(
                            title: "Retour",
                            forward: false,
                            icon: Icons.chevron_left,
                            onPressed: () {
                              Get.back();
                            }),
                        if (keyBoardController.value.value.length == 4)
                          MainButtonInverse(
                              title: "Confirmer OTP",
                              icon: Icons.check,
                              onPressed: () {
                                checkOtp();
                              }),
                      ],
                    );
                  }),
                  const Spacer(),
                  SizedBox(
                    height: Tools.PADDING,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
