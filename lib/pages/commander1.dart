import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/type_colis_item.dart';
import 'package:lpr/components/widgets/wave.dart';
import 'package:lpr/controllers/CommandeProcessController.dart';

class Commander1 extends StatelessWidget {
  Commander1({
    super.key,
  });

  CommandeProcessController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 120,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            decoration: const BoxDecoration(
                color: MyColors.primary,
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Que voulez-vous faire livrer ?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: MyColors.secondary, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Type de colis",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: MyColors.secondary),
                ),
              ],
            )),
        const SizedBox(height: 20, child: Wave()),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING / 2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: Tools.PADDING * 2,
                ),
                Container(
                  height: 500,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Tools.PADDING,
                  ),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: Tools.PADDING * 2.5,
                      crossAxisSpacing: Tools.PADDING * 1.5,
                    ),
                    children: [
                      TypeColisItem(
                          id: "1", title: "Ultra léger", icon: "​🗂️"),
                      TypeColisItem(
                          id: "2", title: "Petit sac, sachet", icon: "🛍️"),
                      TypeColisItem(id: "3", title: "Boite", icon: "​🗃️​"),
                      TypeColisItem(
                          id: "4", title: "Carton moyen", icon: "📦​​​"),
                      TypeColisItem(
                          id: "5", title: "Gros cartons", icon: "🗄️"),
                      TypeColisItem(id: "6", title: "Valise", icon: "🧳"),
                      TypeColisItem(id: "7", title: "Petit meuble", icon: "🪑"),
                      TypeColisItem(
                          id: "8", title: "Electroménager", icon: "📺"),
                      TypeColisItem(
                          id: "9", title: "Spécial, fragile", icon: "💎"),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
                  child: Text(
                      " * Veuillez choisir le format le plus adapté à votre colis au risque que votre colis ne soit accepté par le point relais.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.danger,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: Tools.PADDING,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
