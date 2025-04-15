import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/GeneralController.dart';
import 'package:lpr/pages/ChangeInfosPage.dart';
import 'package:lpr/pages/ChangeNumberPage.dart';
import 'package:lpr/pages/parametre_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  GeneralController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(ParametrePage(), transition: Transition.rightToLeft);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
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
                        ListTile(
                            title: Text('Changer mes informations'),
                            leading: const Icon(Icons.person),
                            onTap: () {
                              Get.dialog(const ChangeInfosPage());
                            }),
                        ListTile(
                            title: Text('Changer de numéro de téléphone'),
                            leading: const Icon(Icons.phone),
                            onTap: () {
                              Get.dialog(ChangeNumberPage());
                            }),
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
                    Border(top: BorderSide(width: 0, color: MyColors.primary))),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.15,
                  width: Get.size.width,
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height * 0.15,
                        width: Get.size.width,
                        decoration: const BoxDecoration(
                          color: MyColors.primary,
                          border: Border.symmetric(
                              horizontal: BorderSide.none,
                              vertical: BorderSide.none),
                        ),
                      ),
                      Opacity(
                        opacity: 0.15,
                        child: Image.asset("assets/images/pattern.png",
                            fit: BoxFit.cover, width: Get.width),
                      ),
                    ],
                  ),
                ),
                const Expanded(flex: 1, child: Wave()),
                Spacer(
                  flex: 10,
                ),
                Container(
                  color: MyColors.secondary,
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
                          color: MyColors.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 185,
                    width: 185,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: MyColors.secondary,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: MyColors.primary, width: 7),
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
                    Obx(() {
                      return Text(
                        controller.client.value!.fullName(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      );
                    }),
                    SizedBox(height: Tools.PADDING / 3),
                    Obx(() {
                      return Text(
                          "+225 ${controller.client.value!.showContact()}",
                          style: Theme.of(context).textTheme.titleSmall!);
                    }),
                    SizedBox(height: Tools.PADDING / 3),
                    Text(
                        " ${controller.client.value!.typeClient.target?.libelle}",
                        style: Theme.of(context).textTheme.bodySmall!),
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
                      color: MyColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Obx(() {
                        return Text(
                            "Niveau ${controller.client.value!.palier.target?.level}",
                            style: Theme.of(context).textTheme.bodySmall!);
                      }),
                      Obx(() {
                        return Text(
                          " ${controller.client.value!.palier.target?.libelle}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        );
                      }),
                      SizedBox(height: Tools.PADDING / 3),
                      Obx(() {
                        return Text(
                            " ${controller.client.value!.palier.target?.description}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontStyle: FontStyle.italic));
                      }),
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
