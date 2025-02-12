import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpr/components/tools/tools.dart';
import 'package:lpr/components/widgets/emballage_bloc.dart';
import 'package:lpr/components/widgets/wave.dart';

class Commander3 extends StatelessWidget {
  const Commander3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 120,
            width: Get.size.width,
            padding: const EdgeInsets.symmetric(horizontal: Tools.PADDING),
            decoration: const BoxDecoration(
                color: MyColors.bleu,
                border: Border.symmetric(
                    horizontal: BorderSide.none, vertical: BorderSide.none)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Votre colis est-il bien emballé ?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: MyColors.beige, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Etat du colis",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: MyColors.beige),
                ),
              ],
            )),
        const SizedBox(height: 20, child: Wave()),
        SizedBox(
          height: Tools.PADDING,
        ),
        Spacer(),
        Container(
          height: 300,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: Tools.PADDING,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                EmballageBloc(
                  title: "Oui, j'ai bien emballé.",
                  subtitle: "oui parfaitement emballé, bien scéllé.",
                  icon: Icons.redeem,
                ),
                EmballageBloc(
                  title: "Euuh, un peu ...",
                  subtitle: "C'est pas vraiment emballé mais ça va.",
                  icon: Icons.inventory_2_outlined,
                ),
                EmballageBloc(
                  title: "Non, pas du tout !",
                  subtitle: "Y'a rien dessus, juste le colis.",
                  icon: Icons.layers_outlined,
                ),
              ]),
        ),
        Spacer(),
      ],
    );
  }
}
