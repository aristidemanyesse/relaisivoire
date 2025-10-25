import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/elements/confirmDialog.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/components/widgets/parametre_menu_item.dart';
import 'package:relaisivoire/components/widgets/wave.dart';
import 'package:relaisivoire/components/widgets/wave_inverse.dart';
import 'package:relaisivoire/controllers/GeneralController.dart';
import 'package:relaisivoire/controllers/HandleTypesController.dart';
import 'package:relaisivoire/pages/HistoriquePage.dart';
import 'package:relaisivoire/pages/ListeColisPage.dart';
import 'package:relaisivoire/pages/ProfilPage.dart';
import 'package:relaisivoire/pages/SearchPointRelais.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class ParametrePage extends StatefulWidget {
  const ParametrePage({super.key});

  @override
  State<ParametrePage> createState() => _ParametrePageState();
}

class _ParametrePageState extends State<ParametrePage> {
  HandleTypesController controller = Get.find();
  GeneralController generalController = Get.find();

  String number = "+225 05 45 46 75 03";
  void call() async {
    String number_ = number.replaceAll(" ", "");
    if (!await launchUrl(Uri.parse("tel:$number_"))) {
      throw 'Could not launch whatsapp ';
    }
  }

  void whatsapp() async {
    String number_ = number.replaceAll(" ", "");
    if (!await launchUrl(Uri.parse("https://wa.me/$number_"))) {
      throw 'Could not launch whatsapp ';
    }
  }

  void telegram() async {
    if (!await launchUrl(Uri.parse("https://t.me/+iKRQ2Nd7YDQyNjI0"))) {
      throw 'Could not launch whatsapp ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: Text(
          "Paramètres",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: MyColors.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.off(ListeColisPage());
          },
          icon: const Icon(Icons.arrow_back, color: MyColors.secondary),
        ),
      ),
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0, color: MyColors.primary)),
        ),
        child: Column(
          children: [
            SizedBox(height: 30, child: const Wave()),
            SizedBox(height: Tools.PADDING),
            SizedBox(
              width: Get.size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ParametreMenuItem(
                    icon: Icons.person,
                    title: "Mon Profil",
                    subtitle: "Mes informations personnelles",
                    ontap: () {
                      Get.to(ProfilPage());
                    },
                  ),
                  Divider(),
                  ParametreMenuItem(
                    icon: Icons.history,
                    title: "Mon historique",
                    subtitle: "Tous les colis traités",
                    ontap: () {
                      Get.to(HistoriquePage());
                    },
                  ),
                  ParametreMenuItem(
                    icon: Icons.search,
                    title: "Rechercher un point relais",
                    subtitle: "Nom, localisations, services...",
                    ontap: () {
                      Get.to(SearchPointRelais());
                    },
                  ),
                  Divider(),
                  ParametreMenuItem(
                    icon: Icons.help,
                    title: "Assistance",
                    subtitle: "Vous avez un souci ?",
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
                                title: Text(
                                  'Appel téléphonique',
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(number),
                                leading: const Icon(Icons.phone, size: 30),
                                onTap: () {
                                  call();
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Assistance Whatsapp',
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                ),
                                subtitle: Text(number),
                                leading: const Icon(Icons.whatshot, size: 30),
                                onTap: () {
                                  whatsapp();
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Assistance Télégram',
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                ),
                                subtitle: Text(number),
                                leading: const Icon(
                                  Icons.telegram,
                                  color: Colors.blueAccent,
                                  size: 30,
                                ),
                                onTap: () {
                                  telegram();
                                },
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
                      Get.dialog(
                        ConfirmDialog(
                          title: "Déconnexion",
                          message:
                              "Voulez-vous vraiment vous déconnecter?\n Toutes vos données seront éffacées sur cet appareil.",
                          testOk: "Déconnexion",
                          testCancel: "Non",
                          functionOk: () async {
                            generalController.deconnexion();
                          },
                          functionCancel: () {
                            Get.back();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
            Center(child: Image.asset("assets/images/logo.png", height: 120)),
            Spacer(),
            SizedBox(height: 20, child: const WaveInverse()),
            Container(
              color: MyColors.primary,
              padding: const EdgeInsets.only(bottom: Tools.PADDING / 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Tools.PADDING / 3),
                  Text(
                    "Relais'Ivoir",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: MyColors.secondary),
                  ),
                  Text(
                    "Version 1.0.0.1502",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: MyColors.secondary),
                  ),
                  SizedBox(height: Tools.PADDING / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          launchUrl(
                            Uri.parse(
                              "https://www.relais-ivoir.com/app/privacy/",
                            ),
                          );
                        },
                        child: Text(
                          "Conditons générales | Politique d'utilisation",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: MyColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Tools.PADDING),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
