import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/pages/ColisPage.dart';
import 'package:lpr/controllers/keyboard_controller.dart';

class PleaseWait extends StatefulWidget {
  const PleaseWait({super.key});

  @override
  State<PleaseWait> createState() => _PleaseWaitState();
}

class _PleaseWaitState extends State<PleaseWait> {
  final KeyBoradController _keyBoradController = Get.find();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAll(const ColisPage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.beige.withOpacity(0.8),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/wait.json', width: Get.width * 0.7),
            SizedBox(height: Tools.PADDING),
            Text("Veuillez patienter...",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: MyColors.bleu, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
