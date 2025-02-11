import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/components/widgets/step_recap.dart';

class Commander6 extends StatelessWidget {
  const Commander6({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: Get.height * 0.15,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            decoration: const BoxDecoration(
                color: MyColors.bleu,
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "On fait une dernière vérification",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyColors.beige),
                ),
                Text(
                  "Récapitulatif...",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: MyColors.beige),
                ),
              ],
            )),
        const Expanded(flex: 1, child: Wave()),
        Expanded(
          flex: 10,
          child: Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: Tools.PADDING * 2,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  const StepRecap(
                      title: "Type de colis",
                      subtitle: "Enveloppe - Porte-document"),
                  const StepRecap(
                      title: "Poids du colis", subtitle: "entre 2Kg et 5Kg"),
                  const StepRecap(
                      title: "NIveau d'emballage",
                      subtitle: "Oui bien emballé"),
                  const StepRecap(
                      title: "Coordonnées du destinataire",
                      subtitle: "Koumba Yacine - 07 859 569 20"),
                  const StepRecap(
                      title: "Lieu de livraison",
                      subtitle: "Aly le bon - Marcory - Anoumabo"),
                  const StepRecap(title: "Total à payer", subtitle: "1 200 Fcfa"),
                  const Spacer(),
                  Text(
                      " * Si vous déposez le colis avant 11h30, il sera disponible pour recuperation avant 16h30",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
