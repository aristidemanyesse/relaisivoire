import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/pages/HistoriquePage.dart';
import 'package:lpr/pages/NotificationsPage.dart';
import 'package:lpr/pages/commander.dart';
import 'package:lpr/pages/parametre_page.dart';
import 'package:lpr/components/widgets/item_bloc.dart';
import 'package:lpr/components/widgets/wave.dart';

class ListeColisPage extends StatefulWidget {
  const ListeColisPage({super.key});

  @override
  State<ListeColisPage> createState() => _ListeColisPageState();
}

class _ListeColisPageState extends State<ListeColisPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, element) async {
        Get.dialog(
          ConfirmDialog(
            title: "😩😟 Hhmmm !",
            message: "Voulez-vous vraiment quitter cette application ?",
            testOk: "Oui",
            testCancel: "Non, je reste",
            functionOk: () {
              exit(0);
            },
            functionCancel: () {
              Get.back();
            },
          ),
        );
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.to(const ParametrePage(),
                    transition: Transition.leftToRight);
              },
              icon: const Icon(Icons.menu)),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(const HistoriquePage());
                },
                icon: const Icon(Icons.search)),
            SizedBox(width: Tools.PADDING / 3),
            IconButton(
                onPressed: () {
                  Get.to(const NotificationsPage());
                },
                icon: const Icon(Icons.notifications)),
          ],
        ),
        body: Container(
          height: Get.size.height,
          width: Get.size.width,
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(width: 0, color: MyColors.primary))),
          child: Column(
            children: [
              Container(
                width: Get.width,
                height: 110,
                padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 0, color: MyColors.primary)),
                  color: MyColors.primary,
                ),
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
                          "Bonjour,",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: MyColors.secondary),
                        ),
                        Text(
                          "Jacques Amessan",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: MyColors.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30, child: Wave()),
              SizedBox(height: Tools.PADDING / 2),
              Expanded(
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              color: MyColors.primary.withOpacity(0.5),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Tools.PADDING, vertical: 5),
                              child: Text("Nouveaux colis à récupérer (3)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ),
                            Column(
                              children: [
                                ItemBloc(
                                    title: "Petit sac, sachet",
                                    subtitle: "Boutique Aly - Marcory Anoumabo",
                                    created: "il y a 1 heures",
                                    received: true),
                                ItemBloc(
                                    title: "Spécial, fragile",
                                    subtitle: "Boutique Méféré - Cocody danga",
                                    created: "il y a 1 jour",
                                    received: true),
                                ItemBloc(
                                    title: "Valise",
                                    subtitle: "Boutique Aly - Marcory Anoumabo",
                                    created: "il y a 1 heures",
                                    received: true),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Tools.PADDING * 1.5,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: MyColors.primary.withOpacity(0.2),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Tools.PADDING, vertical: 5),
                                child: Text("Colis à déposer (2)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontWeight: FontWeight.bold)),
                              ),
                              Column(
                                children: [
                                  ItemBloc(
                                    title: "Enveloppe / Porte-document",
                                    subtitle:
                                        "Boutique de Banbara - Port-bouët Abattoir",
                                    created: "il y a 2 min",
                                    received: false,
                                  ),
                                  ItemBloc(
                                      title: "Carton moyen",
                                      subtitle:
                                          "ANK Service - Port-bouët Vridi",
                                      created: "il y a 2 heures",
                                      received: false),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: MyColors.secondary,
                height: Get.height / 10,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          children: [
            Spacer(),
            MainButtonInverse(
              onPressed: () {
                Get.to(const CommanderPage());
              },
              title: "Nouveau colis",
              icon: Icons.add,
            ),
            Spacer(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
