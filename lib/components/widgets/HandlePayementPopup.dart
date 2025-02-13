import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/pages/PleaseWait.dart';
import 'package:lpr/pages/PleaseWait2.dart';

class HandlePayementPopup extends StatelessWidget {
  const HandlePayementPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 350,
        color: MyColors.secondary,
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Text("Espace pour la gestion du paiement",
                style: Theme.of(context).textTheme.titleSmall!),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Tools.PADDING / 3),
              child: MainButtonInverse(
                title: "Valider le paiement",
                icon: Icons.check,
                onPressed: () {
                  Get.dialog(PleaseWait2());
                  Future.delayed(Duration(seconds: 5), () {
                    Get.back();
                    Get.dialog(
                      const PleaseWait(),
                    );
                  });
                },
              ),
            ),
            SizedBox(height: Tools.PADDING * 2),
            SizedBox(height: 30, child: const Wave()),
          ],
        ),
      ),
    );
  }
}
