import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/HandlePayementPopup.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/models/ColisApp/Colis.dart';
import 'package:lpr/models/ColisApp/StatusColis.dart';
import 'package:lpr/pages/ListeColisPage.dart';
import 'package:lpr/pages/PleaseWait2.dart';
import 'package:lpr/pages/SearchPointRelais.dart';
import 'package:lpr/components/widgets/ColisCard.dart';
import 'package:lpr/pages/open_q_r_code.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ColisPage extends StatefulWidget {
  final Colis colis;
  const ColisPage({super.key, required this.colis});

  @override
  State<ColisPage> createState() => _ColisPageState();
}

class _ColisPageState extends State<ColisPage> {
  final PageController _controller = PageController();
  HandleTypesController controller = Get.find();
  GeneralController generalController = Get.find();
  bool isWaiting = true;
  bool forMe = false;

  Timer? _timer;
  void startCheck() {
    _timer?.cancel(); // 🔁 stoppe un ancien timer s’il existe
    _timer = Timer.periodic(Duration(seconds: 7), (Timer t) async {
      dynamic res = await widget.colis.checkStartPayement();
      if (res[0]) {
        _timer?.cancel();
        print('timer cancelled');
        // lancer le payement
        Get.bottomSheet(
            HandlePayementPopup(
              colis: res[1],
            ),
            isDismissible: false,
            enableDrag: false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    forMe = widget.colis.sender.target?.contact ==
        generalController.client.value?.contact;
    isWaiting = widget.colis.status.target!.level == StatusColis.EN_ATTENTE;
    startCheck();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
        title: Text(
          widget.colis.getCode(),
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: MyColors.secondary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (forMe)
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
                          if (forMe && widget.colis.sold)
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
                                Get.dialog(
                                  ConfirmDialog(
                                    title: "Confirmation",
                                    message:
                                        "Voulez-vous vraiment annuler cette commande de livraison de colis ?",
                                    testOk: "Oui, annuler",
                                    testCancel: "Non",
                                    functionOk: () async {
                                      Get.dialog(PleaseWait2());
                                      bool res = await widget.colis.annuler();
                                      if (res) {
                                        Get.back();
                                        Get.offAll(ListeColisPage());
                                      } else {
                                        Get.back();
                                        Get.snackbar("❌ Ooops",
                                            "Une erreur est survenue, veuillez réessayer plus tard!");
                                      }
                                    },
                                    functionCancel: () {
                                      Get.back();
                                    },
                                  ),
                                );
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
              child: Container(
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
                            Expanded(
                              child: Hero(
                                tag: "qr_code",
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(Tools.PADDING / 2),
                                  child: Material(
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(OpenQRCode(
                                          colis: widget.colis,
                                        ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                            Tools.PADDING / 5),
                                        child: QrImageView(
                                          data: widget.colis.code,
                                          version: QrVersions.auto,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Tools.PADDING / 2),
                            Text("* Scannez le QR code dans le point relais",
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
            ),
            const SizedBox(height: 30, child: Wave()),
            SizedBox(height: Tools.PADDING),
            ColisCard(colis: widget.colis),
            SizedBox(
              height: Tools.PADDING * 2,
            ),
            if (isWaiting && !cutOff()) ...{
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
                          Get.to(SearchPointRelais());
                        }),
                  ],
                ),
              ),
            } else if (!forMe)
              MainButtonInverse(
                  title: "Me guider vers le point relais",
                  icon: Icons.location_on_sharp,
                  onPressed: () {
                    // Get.to(SearchLPR());
                  }),
            SizedBox(
              height: Tools.PADDING * 2,
            ),
          ],
        ),
      ),
    );
  }
}
