import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/pages/HistoriquePage.dart';
import 'package:lpr/pages/NotificationsPage.dart';
import 'package:lpr/pages/commander.dart';
import 'package:lpr/pages/parametre_page.dart';
import 'package:lpr/controllers/keyboard_controller.dart';
import 'package:lpr/components/widgets/item_bloc.dart';
import 'package:lpr/components/widgets/wave.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final KeyBoradController _keyBoradController = Get.find();

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
        body: SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: Column(
            children: [
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                width: Get.size.width,
                decoration: const BoxDecoration(
                    color: MyColors.bleu,
                    border: Border.symmetric(
                        horizontal: BorderSide.none,
                        vertical: BorderSide.none)),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bonjour,",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: MyColors.beige),
                      ),
                      Text(
                        "Jacques Amessan",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: MyColors.beige, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [],
                      ),
                      SizedBox(height: Tools.PADDING),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50, child: Wave()),
              SizedBox(height: Tools.PADDING),
              Expanded(
                flex: 10,
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
                        title: "Valise gros colis",
                        subtitle: "Boutique Aly - Marcory Anoumabo",
                        created: "il y a 1 heures",
                        received: true),
                    ItemBloc(
                        title: "Valise gros colis",
                        subtitle: "Boutique Aly - Marcory Anoumabo",
                        created: "il y a 1 heures",
                        received: true),
                    ItemBloc(
                        title: "Valise gros colis",
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
                color: MyColors.beige,
                height: Get.height / 10,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(const CommanderPage());
          },
          child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: MyColors.bleu,
              ),
              child: const Icon(Icons.add)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
