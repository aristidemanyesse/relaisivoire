import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
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
                padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 0, color: MyColors.primary)),
                  color: MyColors.primary,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: MyColors.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: Tools.PADDING),
                  ],
                ),
              ),
              const SizedBox(height: 30, child: Wave()),
              SizedBox(height: Tools.PADDING),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ListView(children: [
                    ItemBloc(
                      title: "Enveloppe / Porte-document",
                      subtitle: "Boutique de Banbara - Port-bouët Abattoir",
                      created: "il y a 2 min",
                      received: false,
                    ),
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
                    ItemBloc(
                        title: "Carton moyen",
                        subtitle: "ANK Service - Port-bouët Vridi",
                        created: "il y a 2 heures",
                        received: false),
                  ]),
                ),
              ),
              Container(
                color: MyColors.secondary,
                height: Get.height / 10,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.primary,
          onPressed: () {
            Get.to(const CommanderPage());
          },
          child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: MyColors.primary,
              ),
              child: const Icon(Icons.add)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
