import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/step_process.dart';
import 'package:lpr/components/widgets/step_recap.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/pages/ListeColisPage.dart';
import 'package:lpr/pages/PleaseWait2.dart';
import 'package:lpr/pages/open_q_r_code.dart';
import 'package:lpr/pages/search_lpr.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ColisPage extends StatefulWidget {
  final bool received;
  const ColisPage({super.key, required this.received});

  @override
  State<ColisPage> createState() => _ColisPageState();
}

class _ColisPageState extends State<ColisPage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(ListeColisPage());
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LPR - 458 965 230",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: MyColors.beige, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          if (!widget.received)
            IconButton(
                onPressed: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    backgroundColor: MyColors.beige,
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                              title: Text(
                                'Supprimer le colis',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: MyColors.danger,
                                    ),
                              ),
                              leading: const Icon(
                                Icons.delete_forever,
                                color: MyColors.danger,
                              ),
                              onTap: () {
                                Get.dialog(ConfirmDialog(
                                    functionOk: () {
                                      Get.dialog(PleaseWait2());
                                      Future.delayed(Duration(seconds: 5), () {
                                        Get.back();
                                        Get.offAll(
                                          const ListeColisPage(),
                                        );
                                      });
                                    },
                                    functionCancel: () {
                                      Get.back();
                                    },
                                    testOk: "Confirmer",
                                    testCancel: "Annuler",
                                    title: "Confirmation",
                                    message:
                                        "Vous êtes sur le point de supprimer votre colis. Voulez-vous continuer ?"));
                              }),
                        ],
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                ))
        ],
      ),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                      height: 280,
                      width: Get.size.width,
                      decoration: const BoxDecoration(
                          color: MyColors.bleu,
                          border: Border.symmetric(
                              horizontal: BorderSide.none,
                              vertical: BorderSide.none)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: "qr_code",
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Tools.PADDING / 2),
                                child: Material(
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(const OpenQRCode());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(
                                          Tools.PADDING / 2),
                                      child: Image.asset(
                                        "assets/images/qrcode.png",
                                        fit: BoxFit.contain,
                                        height: 180,
                                        width: 180,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Tools.PADDING / 2),
                            Text(
                                "* Faites scaner le QR code par l'agent \ndans le point relais",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: MyColors.beige)),
                          ],
                        ),
                      )),
                  const SizedBox(height: 30, child: Wave()),
                  SizedBox(
                    height: Tools.PADDING,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Tools.PADDING * 2,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Spacer(),
                                      StepRecap(
                                          title: "Type de colis",
                                          subtitle:
                                              "Enveloppe - Porte-document"),
                                      StepRecap(
                                          title: "Poids du colis",
                                          subtitle: "entre 2Kg et 5Kg"),
                                      StepRecap(
                                          title: "NIveau d'emballage",
                                          subtitle: "Oui bien emballé"),
                                      if (!widget.received)
                                        StepRecap(
                                            title:
                                                "Coordonnées du destinataire",
                                            subtitle:
                                                "Koumba Yacine - 07 859 569 20"),
                                      StepRecap(
                                          title: "Lieu de livraison",
                                          subtitle:
                                              "Aly le bon - Marcory - Anoumabo"),
                                      if (!widget.received)
                                        StepRecap(
                                            title: "Total à payer",
                                            subtitle: "1 200 Fcfa"),
                                      Container(
                                        height: 3,
                                        width: 20,
                                        margin: EdgeInsets.only(
                                            top: Tools.PADDING / 4),
                                        color: MyColors.bleu.withOpacity(0.5),
                                      ),
                                      Spacer(
                                        flex: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                if (widget.received)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Tools.PADDING),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Spacer(),
                                            StepProcess(
                                                text: "1",
                                                title: "Colis renseigné",
                                                subtitle:
                                                    "En attende de dépôt"),
                                            StepProcess(
                                                text: "2",
                                                title:
                                                    "Colis déposé pour livraison",
                                                subtitle:
                                                    "En attende d'un livreur"),
                                            StepProcess(
                                                text: "3",
                                                title:
                                                    "Colis en cours de livraison",
                                                subtitle:
                                                    "Un de nos livreur est route pour livrer le colis"),
                                            StepProcess(
                                                text: "4",
                                                title:
                                                    "Colis disponible, on vous attend..",
                                                subtitle:
                                                    "Vous pouvez venir chercher votre colis"),
                                            StepProcess(
                                                text: "5",
                                                title:
                                                    "Colis récupé par le destinataire",
                                                subtitle:
                                                    "Koné moussa a récupéré le colis"),
                                            Container(
                                              height: 3,
                                              width: 40,
                                              margin: EdgeInsets.only(
                                                  top: Tools.PADDING / 4),
                                              color: MyColors.bleu
                                                  .withOpacity(0.5),
                                            ),
                                            Spacer(
                                              flex: 2,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (widget.received)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                      color: MyColors.bleu.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                const SizedBox(
                                  width: Tools.PADDING / 3,
                                ),
                                Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                      color: MyColors.bleu.withOpacity(1),
                                      borderRadius: BorderRadius.circular(100)),
                                )
                              ],
                            ),
                          SizedBox(
                            height: Tools.PADDING,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Tools.PADDING,
            ),
            if (!widget.received)
              Text(
                " * Si vous déposez le colis avant 11h30, il sera disponible pour recuperation avant 16h30",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontStyle: FontStyle.italic),
              ),
            SizedBox(
              height: Tools.PADDING,
            ),
            if (!widget.received)
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainButtonInverse(
                        title: "Me guider vers un point relais",
                        icon: Icons.location_on_sharp,
                        onPressed: () {
                          Get.to(SearchLPR());
                        })
                  ],
                ),
              ),
            SizedBox(
              height: Tools.PADDING * 2,
            ),
          ],
        ),
      ),
    );
  }
}
