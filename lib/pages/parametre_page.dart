import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/elements/confirmDialog.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/parametre_menu_item.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/components/widgets/wave_inverse.dart';
import 'package:lpr/controllers/keyboard_controller.dart';
import 'package:lpr/pages/HistoriquePage.dart';
import 'package:lpr/pages/ProfilPage.dart';
import 'package:lpr/pages/search_lpr.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ParametrePage extends StatefulWidget {
  const ParametrePage({super.key});

  @override
  State<ParametrePage> createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  final KeyBoradController _keyBoradController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.bleu,
        title: Text(
          "Paramètres",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: MyColors.beige, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: MyColors.beige,
            )),
      ),
      body: Column(
        children: [
          SizedBox(height: 30, child: const Wave()),
          SizedBox(
            height: Tools.PADDING,
          ),
          Expanded(
            child: Container(
                width: Get.size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: Tools.PADDING,
                ),
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
                          backgroundColor: MyColors.beige,
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
                        Get.to(
                          Get.dialog(
                            ConfirmDialog(
                              title: "Déconnexion",
                              message:
                                  "Voulez-vous vraiment vous deconnecter?\n Toutes vos données seront supprimées sur cet appareil.",
                              testOk: "Déconnexion",
                              testCancel: "Non",
                              functionOk: () {
                                exit(0);
                              },
                              functionCancel: () {
                                Get.back();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )),
          ),
          SizedBox(height: 50, child: const WaveInverse()),
          Container(
            color: MyColors.bleu,
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
                        .copyWith(color: MyColors.beige)),
                SizedBox(height: Tools.PADDING / 3),
                Text("Version 1.0.0.1502",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: MyColors.beige)),
                SizedBox(height: Tools.PADDING / 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Conditons générales",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyColors.beige)),
                    SizedBox(
                      width: Tools.PADDING,
                      child: Center(
                          child: Text("|",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: MyColors.beige))),
                    ),
                    Text("Politique d'utilisation",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: MyColors.beige)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
