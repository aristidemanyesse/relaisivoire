import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/components/widgets/step_recap.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';
import 'package:lpr/controllers/GeneralController.dart';

class RecapitulatifStep extends StatefulWidget {
  const RecapitulatifStep({
    super.key,
  });

  @override
  State<RecapitulatifStep> createState() => _RecapitulatifStepState();
}

class _RecapitulatifStepState extends State<RecapitulatifStep> {
  @override
  void initState() {
    super.initState();
  }

  final GeneralController generalController = Get.find();
  final CommandeProcessController _controller = Get.find();

  bool cutOff() {
    final maintenant = DateTime.now();
    return maintenant.hour > 20 ||
        (maintenant.hour == 20 && maintenant.minute >= 30);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 120,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
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
                      "On fait une dernière vérification",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: MyColors.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Récapitulatif...",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: MyColors.secondary),
                    ),
                  ],
                ),
              ],
            )),
        const SizedBox(height: 20, child: Wave()),
        SizedBox(height: Tools.PADDING),
        Expanded(
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: Tools.PADDING * 1.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StepRecap(
                    title: "Type de colis",
                    subtitle:
                        "${_controller.typeColis.value?.libelle} ${_controller.typeColis.value?.icone}"),
                StepRecap(
                    title: "Poids du colis",
                    subtitle:
                        "entre ${_controller.typeColis.value?.poids_min} et ${_controller.typeColis.value?.poids_max} Kg"),
                StepRecap(
                    title: "Niveau d'emballage",
                    subtitle: _controller.typeEmballage.value?.level == 1
                        ? "Oui bien emballé"
                        : "Non, c'est juste le colis"),
                StepRecap(
                    title: "Coordonnées du destinataire",
                    subtitle: _controller.typeDestinataire.value?.level == 1
                        ? "Moi-même (${generalController.client.value?.contact})"
                        : "${_controller.nomDestinataire.value} - ${_controller.contactDestinataire.value}"),
                StepRecap(
                  title: "Lieu de Rétrait du colis",
                  subtitle: "${_controller.pointRelais.value?.libelle}",
                  subtitle2: "${_controller.pointRelais.value?.adresse()}",
                ),
                StepRecap(
                  title: "Total à payer au dépôt",
                  subtitle: "${_controller.price.value} Fcfa",
                  subtitle2:
                      "* Ce montant est estimé, le montant final sera calculé au dépôt du colis",
                ),
              ],
            ),
          ),
        ),
        if (!cutOff())
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            child: Text(
                " * Si vous déposez le colis avant 10h30, il sera disponible pour recuperation avant 16h30",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontStyle: FontStyle.italic)),
          ),
      ],
    );
  }
}
