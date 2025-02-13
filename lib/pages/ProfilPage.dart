import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
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
                            title: Text('Changer mes informations'),
                            leading: const Icon(Icons.person),
                            onTap: () {}),
                        ListTile(
                            title: Text('Changer de numéro de téléphone'),
                            leading: const Icon(Icons.phone),
                            onTap: () {}),
                        ListTile(
                          title: Text('Changer ma photo'),
                          leading: const Icon(Icons.photo),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: Get.size.height,
            width: Get.size.width,
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(width: 0, color: MyColors.bleu))),
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.15,
                  padding:
                      const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                  width: Get.size.width,
                  decoration: const BoxDecoration(
                      color: MyColors.bleu,
                      border: Border.symmetric(
                          horizontal: BorderSide.none,
                          vertical: BorderSide.none)),
                ),
                const Expanded(flex: 1, child: Wave()),
                Spacer(
                  flex: 10,
                ),
                Container(
                  color: MyColors.beige,
                  height: Get.height / 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.08,
                  child: Center(
                    child: Text(
                      "Mon profil",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: MyColors.beige, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 185,
                    width: 185,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: MyColors.beige,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: MyColors.bleu, width: 7),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Bonjour,",
                        style: Theme.of(context).textTheme.bodyLarge!),
                    SizedBox(height: Tools.PADDING / 2),
                    Text(
                      "Jacques Amessan",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: Tools.PADDING / 3),
                    Text("+225 07 582 258 52",
                        style: Theme.of(context).textTheme.titleSmall!),
                  ],
                ),
                Spacer(
                  flex: 2,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: Tools.PADDING),
                  padding: EdgeInsets.symmetric(
                      horizontal: Tools.PADDING, vertical: Tools.PADDING),
                  decoration: BoxDecoration(
                      color: MyColors.bleu.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text("Niveau 4",
                          style: Theme.of(context).textTheme.bodyMedium!),
                      Text(
                        "Pigeon voyageur",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: Tools.PADDING / 3),
                      Text(
                          "Vous êtes de ceux qui aiment envoyer des colis, partout dans le monde, et tout le temps...",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
                Spacer(
                  flex: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
