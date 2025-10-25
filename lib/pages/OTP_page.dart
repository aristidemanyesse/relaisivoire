import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/elements/main_button.dart';
import 'package:relaisivoire/components/elements/main_button_icon.dart';
import 'package:relaisivoire/components/elements/main_button_inverse.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/components/elements/KeyBoardNumberPad.dart';
import 'package:relaisivoire/components/widgets/my_input_number.dart';
import 'package:relaisivoire/controllers/GeneralController.dart';
import 'package:relaisivoire/controllers/KeyBoardController.dart';
import 'package:relaisivoire/models/ClientApp/Client.dart';
import 'package:relaisivoire/models/AdministrationApp/CustomUser.dart';
import 'package:relaisivoire/pages/ListeColisPage.dart';
import 'package:relaisivoire/components/widgets/wave.dart';
import 'package:relaisivoire/pages/PleaseWait2.dart';
import 'package:otp_autofill/otp_autofill.dart';

class OPTPage extends StatefulWidget {
  final String number;
  const OPTPage({super.key, required this.number});

  @override
  State<OPTPage> createState() => _OPTPageState();
}

class _OPTPageState extends State<OPTPage> {
  KeyBoardController keyBoardController = Get.find();
  String _otp = "";
  String signature = "";

  int _counter = 30; // Durée du timer (secondes)
  late Timer _timer;
  bool _isButtonDisabled = true;

  late OTPTextEditController controller;
  final scaffoldKey = GlobalKey();
  late OTPInteractor _otpInteractor;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _otpInteractor = OTPInteractor();
    // Commence à écouter les SMS entrants
    if (Platform.isAndroid) {
      _otpInteractor.getAppSignature().then((signature) {
        _resendOtp(signature ?? "");
      });
    } else {
      // iOS : pas besoin de signature
      _resendOtp("");
    }

    controller =
        OTPTextEditController(
          codeLength: 6,
          onCodeReceive: (code) {
            print("Code OTP détecté : $code");
          },
        )..startListenUserConsent((code) {
          final exp = RegExp(r'(\d{6})');
          code = exp.stringMatch(code ?? '') ?? '';
          keyBoardController.value.value = code;
          checkOtp();
          return code;
        });
  }

  void _startTimer() {
    _isButtonDisabled = true;
    _counter = 30;
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

  void _resendOtp(String signature) {
    // Logique pour renvoyer l'OTP ici
    CustomUser.genereOtp(widget.number, signature);
    _startTimer(); // Redémarrer le timer
  }

  void checkOtp() async {
    Get.dialog(PleaseWait2());
    bool response = await CustomUser.verifyOtp(
      widget.number,
      keyBoardController.value.value,
    );
    if (response) {
      Client? client = await Client.searchByContact(widget.number);
      if (client != null) {
        GeneralController controller = Get.find();
        controller.client.value = client;
        client.user.target!.update({'fcmtoken': controller.fcmToken.value});
        Get.off(const ListeColisPage());
      } else {
        Get.back();
        Get.snackbar(
          "❌ Ooops",
          "Une erreur est survenue, veuillez réessayer !",
          colorText: MyColors.danger,
        );
      }
    } else {
      Get.back();
      Get.snackbar(
        "❌ Erreur",
        "Votre code OTP est invalide",
        colorText: MyColors.danger,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                  horizontal: BorderSide.none,
                  vertical: BorderSide.none,
                ),
              ),
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.15,
                    child: Image.asset(
                      "assets/images/pattern.png",
                      fit: BoxFit.cover,
                      width: Get.width,
                    ),
                  ),
                  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Tools.PADDING * 2),
                          Text(
                            "Vérification OTP",
                            style: Theme.of(context).textTheme.displayLarge!
                                .copyWith(color: MyColors.secondary),
                          ),
                          const SizedBox(height: Tools.PADDING / 3),
                          Text(
                            "Entrez le code réçu au ${widget.number}",
                            style: Theme.of(context).textTheme.bodyLarge!
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
                padding: const EdgeInsets.symmetric(
                  horizontal: Tools.PADDING * 2,
                ),
                decoration: const BoxDecoration(
                  color: MyColors.secondary,
                  border: Border(top: BorderSide.none),
                ),
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
                        return MyInputNumber(nbPlaces: 6, value: _otp);
                      }),
                    ),
                    const Spacer(),
                    KeyBoardNumberPad(limit: 6),
                    const Spacer(),
                    if (_isButtonDisabled)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Renvoyer le code dans ",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            "$_counter s",
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    else
                      TextButton(
                        onPressed: _isButtonDisabled
                            ? null
                            : () {
                                _resendOtp(signature);
                              },
                        child: Text(
                          "Renvoyer le code OTP",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    const Spacer(),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainButton(
                            title: "Retour",
                            forward: false,
                            icon: Icons.chevron_left,
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          if (keyBoardController.value.value.length == 6)
                            MainButtonInverse(
                              title: "Confirmer OTP",
                              icon: Icons.check,
                              onPressed: () {
                                checkOtp();
                              },
                            )
                          else
                            Container(
                              child: _isButtonDisabled
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Renvoyez dans ",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge,
                                        ),
                                        Text(
                                          "$_counter s",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    )
                                  : MainButtonIcon(
                                      icon: Icons.refresh,
                                      onPressed: () {
                                        _resendOtp(signature);
                                      },
                                    ),
                            ),
                        ],
                      );
                    }),
                    SizedBox(height: Tools.PADDING),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
