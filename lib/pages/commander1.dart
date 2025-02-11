import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/type_colis_item.dart';
import 'package:lpr/components/widgets/wave.dart';

class Commander1 extends StatelessWidget {
  const Commander1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: Get.height * 0.15,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            decoration: const BoxDecoration(
                color: MyColors.bleu,
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Que voulez-vous faire livrer ?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyColors.beige),
                ),
                Text(
                  "Type de colis",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: MyColors.beige),
                ),
              ],
            )),
        const Expanded(flex: 1, child: Wave()),
        Expanded(
          flex: 10,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: Tools.PADDING / 2,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: Tools.PADDING * 2,
                ),
                Expanded(
                  child: Container(
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
                        TypeColisItem(title: "Ultra léger", icon: "​🗂️"),
                        TypeColisItem(title: "Petit sac, sachet", icon: "🛍️"),
                        TypeColisItem(title: "Boite", icon: "​🗃️​"),
                        TypeColisItem(title: "Carton moyen", icon: "📦​​​"),
                        TypeColisItem(title: "Gros cartons", icon: "🗄️"),
                        TypeColisItem(title: "Valise", icon: "🧳"),
                        TypeColisItem(title: "Petit meuble", icon: "🪑"),
                        TypeColisItem(title: "Electroménager", icon: "📺"),
                        TypeColisItem(title: "Spécial, fragile", icon: "💎"),
                      ],
                    ),
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
