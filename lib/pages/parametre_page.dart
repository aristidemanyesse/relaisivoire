import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/parametre_menu_item.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/components/widgets/wave_inverse.dart';
import 'package:lpr/controllers/KeyBoardController.dart';
import 'package:lpr/pages/HistoriquePage.dart';
import 'package:lpr/pages/Login_number.dart';
import 'package:lpr/pages/ProfilPage.dart';
import 'package:lpr/pages/search_lpr.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ParametrePage extends StatefulWidget {
  const ParametrePage({super.key});

  @override
  State<ParametrePage> createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: Text(
          "Paramètres",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: MyColors.secondary, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: MyColors.secondary,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0, color: MyColors.primary))),
        child: Column(
          children: [
            SizedBox(height: 30, child: const Wave()),
            SizedBox(
              height: Tools.PADDING * 2,
            ),
            Expanded(
              child: SizedBox(
                width: Get.size.width,
                child: ListView(
                  children: [
                    ParametreMenuItem(
                      icon: Icons.person,
                      title: "Mon Profil",
                      subtitle: "Toutes mes activités",
                      ontap: () {
                        Get.to(ProfilPage());
                      },
                    ),
                    Divider(),
                    ParametreMenuItem(
                      icon: Icons.history,
                      title: "Historique",
                      subtitle: "Toutes mes activités",
                      ontap: () {
                        Get.to(HistoriquePage());
                      },
                    ),
                    ParametreMenuItem(
                      icon: Icons.search,
                      title: "Rechercher un point relais",
                      subtitle: "Toutes mes activités",
                      ontap: () {
                        Get.to(SearchLPR());
                      },
                    ),
                    Divider(),
                    ParametreMenuItem(
                      icon: Icons.help,
                      title: "Assistance",
                      subtitle: "Toutes mes activités",
                      ontap: () {
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
                                    title: Text('Appel téléphonique'),
                                    leading: const Icon(Icons.phone),
                                    onTap: () {}),
                                ListTile(
                                    title: Text('Assistance Whatsapp'),
                                    leading: const Icon(Icons.whatshot),
                                    onTap: () {}),
                                ListTile(
                                  title: Text('Assistance Télégram'),
                                  leading: const Icon(Icons.telegram),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(),
                    ParametreMenuItem(
                      icon: Icons.logout,
                      title: "Se déconnecter",
                      subtitle: "Toutes mes activités",
                      ontap: () {
                        Get.dialog(ConfirmDialog(
                          title: "Déconnexion",
                          message:
                              "Voulez-vous vraiment vous deconnecter?\n Toutes vos données seront supprimées sur cet appareil.",
                          testOk: "Déconnexion",
                          testCancel: "Non",
                          functionOk: () {
                            KeyBoardController keyBoardController = Get.find();
                            keyBoardController.onInit();
                            Get.offAll(LoginNumber());
                          },
                          functionCancel: () {
                            Get.back();
                          },
                        ));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Center(
              child: Image.asset(
                "assets/images/logo.png",
                height: 150,
              ),
            )),
            SizedBox(height: 50, child: const WaveInverse()),
            Container(
              color: MyColors.primary,
              padding: const EdgeInsets.only(bottom: Tools.PADDING / 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Tools.PADDING / 3),
                  Text("Le Point Relais",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: MyColors.secondary)),
                  SizedBox(height: Tools.PADDING / 3),
                  Text("Version 1.0.0.1502",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: MyColors.secondary)),
                  SizedBox(height: Tools.PADDING / 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Conditons générales",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: MyColors.secondary)),
                      SizedBox(
                        width: Tools.PADDING,
                        child: Center(
                            child: Text("|",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: MyColors.secondary))),
                      ),
                      Text("Politique d'utilisation",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: MyColors.secondary)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
