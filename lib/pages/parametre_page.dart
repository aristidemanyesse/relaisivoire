import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/parametre_menu_item.dart';
import 'package:lpr/components/widgets/wave_inverse.dart';
import 'package:lpr/controllers/keyboard_controller.dart';
import 'package:lpr/pages/HistoriquePage.dart';
import 'package:lpr/pages/ProfilPage.dart';
import 'package:lpr/pages/search_lpr.dart';

class ParametrePage extends StatefulWidget {
  const ParametrePage({Key? key}) : super(key: key);

  @override
  State<ParametrePage> createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  final KeyBoradController _keyBoradController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.beige,
        title: Text(
          "Paramètres",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: MyColors.bleu,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                width: Get.size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: Tools.PADDING,
                ),
                child: ListView(
                  children: [
                    ParametreMenuItem(
                      title: "Mon Profil",
                      subtitle: "Toutes mes activités",
                      ontap: () {
                        Get.to(ProfilPage());
                      },
                    ),
                    Divider(),
                    ParametreMenuItem(
                      title: "Historique",
                      subtitle: "Toutes mes activités",
                      ontap: () {
                        Get.to(HistoriquePage());
                      },
                    ),
                    ParametreMenuItem(
                      title: "Rechercher un point relais",
                      subtitle: "Toutes mes activités",
                      ontap: () {
                        Get.to(SearchLPR());
                      },
                    ),
                    Divider(),
                    ParametreMenuItem(
                      title: "Assistance",
                      subtitle: "Toutes mes activités",
                      ontap: () {
                        Get.to(HistoriquePage());
                      },
                    ),
                    Divider(),
                    ParametreMenuItem(
                      title: "Se déconnecter",
                      subtitle: "Toutes mes activités",
                      ontap: () {
                        Get.to(HistoriquePage());
                      },
                    ),
                  ],
                )),
          ),
          Container(height: 50, child: const WaveInverse()),
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
