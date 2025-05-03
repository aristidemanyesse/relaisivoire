import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/elements/main_button_inverse.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/AnimatedNotificationIcon.dart';
import 'package:lpr/controllers/ColisController.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/controllers/HandleTypesController.dart';
import 'package:lpr/controllers/NotificationController.dart';
import 'package:lpr/models/ClientApp/Client.dart';
import 'package:lpr/pages/HistoriquePage.dart';
import 'package:lpr/pages/NotificationsPage.dart';
import 'package:lpr/pages/commanderPage.dart';
import 'package:lpr/pages/parametre_page.dart';
import 'package:lpr/components/widgets/item_bloc.dart';
import 'package:lpr/components/widgets/wave.dart';

class ListeColisPage extends StatefulWidget {
  const ListeColisPage({super.key});

  @override
  State<ListeColisPage> createState() => _ListeColisPageState();
}

class _ListeColisPageState extends State<ListeColisPage> {
  GeneralController controller = Get.find();
  HandleTypesController handleTypesController = Get.find();
  ColisController colisController = Get.find();
  NotificationController notificationsController = Get.find();

  @override
  void initState() {
    super.initState();
  }

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
            Obx(() {
              return AnimatedNotificationIcon(
                count: notificationsController.notReads.value.length,
                onTap: () => Get.to(const NotificationsPage()),
              );
            }),
            SizedBox(width: Tools.PADDING / 2),
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
                        SizedBox(height: Tools.PADDING / 2),
                        Obx(() {
                          Client client = controller.client.value!;
                          return Text(
                            client.fullName() != ''
                                ? client.fullName()
                                : client.showContact(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: MyColors.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30, child: Wave()),
              SizedBox(height: Tools.PADDING / 2),
              Expanded(
                child: Obx(() {
                  final liste = colisController.listeEnCours.value +
                      colisController.listeAttentes.value;
                  return liste.isEmpty
                      ? Center(
                          child: Text("Aucun colis en cours ou en attente"))
                      : SingleChildScrollView(
                          child: Column(
                          children: (liste).map((colis) {
                            return ItemBloc(colis: colis);
                          }).toList(),
                        ));
                }),
              ),
              Row(
                children: [
                  Spacer(),
                  MainButtonInverse(
                    onPressed: () async {
                      Get.to(const CommanderPage());
                    },
                    title: "Nouveau colis",
                    icon: Icons.add,
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: Tools.PADDING * 2),
            ],
          ),
        ),
      ),
    );
  }
}
