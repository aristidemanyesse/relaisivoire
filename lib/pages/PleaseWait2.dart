import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:relaisivoire/components/elements/main_button_inverse.dart';
import 'package:relaisivoire/components/tools/tools.dart';

class PleaseWait2 extends StatefulWidget {
  const PleaseWait2({super.key});

  @override
  State<PleaseWait2> createState() => _PleaseWait2State();
}

class _PleaseWait2State extends State<PleaseWait2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.secondary.withOpacity(0.9),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/loader.json', width: Get.width * 0.7),
            SizedBox(height: Tools.PADDING),
            Text(
              "Veuillez patienter...",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: MyColors.textprimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Tools.PADDING * 2),
            MainButtonInverse(
              title: "Annuler",
              icon: null,
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
