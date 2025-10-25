import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/components/widgets/type_colis_item.dart';
import 'package:relaisivoire/components/widgets/wave.dart';
import 'package:relaisivoire/controllers/CommandeProcessController.dart';
import 'package:relaisivoire/controllers/HandleTypesController.dart';
import 'package:relaisivoire/pages/ProhibedPage.dart';

class TypeColisStep extends StatelessWidget {
  TypeColisStep({super.key});

  final HandleTypesController handleTypesController = Get.find();
  final CommandeProcessController _controller = Get.find();

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
              horizontal: BorderSide.none,
              vertical: BorderSide.none,
            ),
          ),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.15,
                child: Image.asset(
                  "assets/images/pattern.png",
                  fit: BoxFit.cover,
                  width: Get.width,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Que voulez-vous faire livrer ?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: MyColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Type de colis",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: MyColors.secondary),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20, child: Wave()),
        const SizedBox(height: Tools.PADDING * 3),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            child: Obx(() {
              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: Tools.PADDING * 2.5,
                  crossAxisSpacing: Tools.PADDING * 1.5,
                ),
                children: handleTypesController.listeTypeColis.value.map((
                  typeColis,
                ) {
                  return TypeColisItem(type: typeColis);
                }).toList(),
              );
            }),
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
            ),
          ),
        ),
        const SizedBox(height: Tools.PADDING),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Get.to(ProhibedPage());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: MyColors.danger.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    size: 20,
                    color: MyColors.danger,
                  ),
                  Text(
                    " Voir la liste des produits prohibés ",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: MyColors.danger,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: Tools.PADDING),
      ],
    );
  }
}
