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
                  "Votre colis est-il bien emballé ?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyColors.beige),
                ),
                Text(
                  "Etat du colis",
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
              horizontal: Tools.PADDING,
            ),
            child: const Column(
              children: [
                SizedBox(
                  height: Tools.PADDING,
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EmballageBloc(
                          title: "Oui, j'ai bien emballé.",
                          subtitle: "oui parfaitement emballé, bien scéllé",
                        ),
                        EmballageBloc(
                          title: "Euuh, un peu ...",
                          subtitle: "C'est pas vraiment emballé mais ça va ",
                        ),
                        EmballageBloc(
                          title: "Non, pas du tout !",
                          subtitle: "Y'a rien dessus, juste le colis",
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
