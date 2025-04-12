import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/step_process.dart';
import 'package:lpr/components/widgets/step_recap.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/pages/ListeColisPage.dart';
import 'package:lpr/pages/PleaseWait2.dart';
import 'package:lpr/pages/open_q_r_code.dart';
import 'package:lpr/pages/search_lpr.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ColisPage extends StatefulWidget {
  final Colis colis;
  final bool received;
  const ColisPage({super.key, required this.colis, required this.received});

  @override
  State<ColisPage> createState() => _ColisPageState();
}

class _ColisPageState extends State<ColisPage> {
  final PageController _controller = PageController();

  bool cutOff() {
    final maintenant = DateTime.now();
    return maintenant.hour > 11 ||
        (maintenant.hour == 11 && maintenant.minute >= 30);
  }

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
              widget.colis.getCode(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: MyColors.secondary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          if (!widget.received)
            IconButton(
                onPressed: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    backgroundColor: MyColors.secondary,
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                              title: Text(
                                'Voir le réçu de payement',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: MyColors.textprimary,
                                    ),
                              ),
                              leading: const Icon(
                                Icons.receipt_long,
                                color: MyColors.textprimary,
                              ),
                              onTap: () {}),
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
                      height: 220,
                      width: Get.size.width,
                      decoration: const BoxDecoration(
                          color: MyColors.primary,
                          border: Border.symmetric(
                              horizontal: BorderSide.none,
                              vertical: BorderSide.none)),
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: 0.15,
                            child: Image.asset("assets/images/pattern.png",
                                fit: BoxFit.cover, width: Get.width),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: Tools.PADDING / 2,
                                ),
                                Hero(
                                  tag: "qr_code",
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Tools.PADDING / 2),
                                    child: Material(
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(const OpenQRCode());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(
                                              Tools.PADDING / 4),
                                          child: QrImageView(
                                              data: widget.colis.code,
                                              version: QrVersions.auto,
                                              size: 170),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: Tools.PADDING / 2),
                                Text(
                                    "* Scannez le QR code dans le point relais",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: MyColors.secondary)),
                              ],
                            ),
                          ),
                        ],
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
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        StepRecap(
                                            title: "Type de colis",
                                            subtitle:
                                                "${widget.colis.typeColis.target?.libelle} ${widget.colis.typeColis.target?.icone}"),
                                        StepRecap(
                                            title: "Poids du colis",
                                            subtitle:
                                                "entre ${widget.colis.typeColis.target?.poids_min} et ${widget.colis.typeColis.target?.poids_max} Kg"),
                                        StepRecap(
                                            title: "Niveau d'emballage",
                                            subtitle: widget.colis.typeEmballage
                                                        .target?.level ==
                                                    1
                                                ? "Oui bien emballé"
                                                : "Non, c'est juste le colis"),
                                        StepRecap(
                                            title:
                                                "Coordonnées du destinataire",
                                            subtitle: widget
                                                        .colis
                                                        .typeDestinataire
                                                        .target
                                                        ?.level ==
                                                    1
                                                ? "Moi-même (${widget.colis.sender.target?.contact})"
                                                : "${widget.colis.receiver_name} - ${widget.colis.receiver_phone}"),
                                        StepRecap(
                                          title: "Lieu de Rétrait du colis",
                                          subtitle:
                                              "${widget.colis.pointRelaisReceiver.target?.libelle}",
                                          subtitle2:
                                              "${widget.colis.pointRelaisReceiver.target?.adresse()}",
                                        ),
                                        if (!widget.received)
                                          StepRecap(
                                              title: "Total à payer au dépôt",
                                              subtitle:
                                                  "${widget.colis.total} Fcfa"),
                                        Container(
                                          height: 3,
                                          width: 20,
                                          margin: EdgeInsets.only(
                                              top: Tools.PADDING / 4),
                                          color:
                                              MyColors.primary.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (widget.received)
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StepProcess(
                                            text: "1",
                                            title: "Colis renseigné",
                                            subtitle: "En attende de dépôt"),
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
                                          color:
                                              MyColors.primary.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (widget.received) ...{
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                      color: MyColors.primary.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                const SizedBox(
                                  width: Tools.PADDING / 3,
                                ),
                                Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                      color: MyColors.primary.withOpacity(1),
                                      borderRadius: BorderRadius.circular(100)),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Tools.PADDING,
                            )
                          }
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!widget.received) ...{
              SizedBox(
                height: Tools.PADDING,
              ),
              if (!cutOff())
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Tools.PADDING),
                  child: Text(
                    " * Si vous déposez le colis avant 11h30, il sera disponible pour recuperation avant 16h30",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                ),
              SizedBox(
                height: Tools.PADDING,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainButtonInverse(
                        title: "Trouver un point relais",
                        icon: Icons.location_on_sharp,
                        onPressed: () {
                          Get.to(SearchLPR());
                        })
                  ],
                ),
              ),
            } else
              MainButtonInverse(
                  title: "Me guider vers le point relais",
                  icon: Icons.location_on_sharp,
                  onPressed: () {
                    Get.to(SearchLPR());
                  }),
            SizedBox(
              height: Tools.PADDING,
            ),
          ],
        ),
      ),
    );
  }
}
