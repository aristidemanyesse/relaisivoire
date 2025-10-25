import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relaisivoire/components/tools/tools.dart';
import 'package:relaisivoire/components/widgets/EmballageBloc.dart';
import 'package:relaisivoire/components/widgets/wave.dart';
import 'package:relaisivoire/controllers/HandleTypesController.dart';

class Commander3 extends StatelessWidget {
  Commander3({super.key});

  HandleTypesController handleTypesController = Get.find();

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
                    "Votre colis est-il bien emballé ?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: MyColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Etat du colis",
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
        SizedBox(height: Tools.PADDING),
        Spacer(),
        Container(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              EmballageBloc(
                id: "1",
                title: "Oui, j'ai bien emballé.",
                subtitle: "oui parfaitement emballé, bien scéllé.",
                icon: Icons.redeem,
                typeEmballage:
                    handleTypesController.listeTypeEmballages.value[0],
              ),
              EmballageBloc(
                id: "2",
                title: "Euuh, pas vraiment ...",
                subtitle: "C'est pas vraiment emballé, juste le colis.",
                icon: Icons.layers_outlined,
                typeEmballage:
                    handleTypesController.listeTypeEmballages.value[1],
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}
